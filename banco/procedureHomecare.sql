DELIMITER $$

/* PROCEDURES PARA TODOS OS USUÁRIOS */

/* Procedure criada para verificar login */

DROP PROCEDURE IF EXISTS verificarLogin$$

CREATE PROCEDURE verificarLogin(vEmailUsuario VARCHAR(200), vSenha VARCHAR(128))
BEGIN 
	SELECT 
		nm_email_usuario, cd_tipo_usuario
	FROM
		usuario
	WHERE
		nm_email_usuario = vEmailUsuario
	AND 
		nm_senha = MD5(vSenha);
END$$

/* Procedure criada para alteração de senha */

DROP PROCEDURE IF EXISTS alterarSenha$$

CREATE PROCEDURE alterarSenha(vNovaSenha VARCHAR(128), vEmailUsuario VARCHAR(200))
BEGIN
	UPDATE 
		usuario
	SET
		nm_senha = md5(vNovaSenha)
	WHERE	
		nm_email_usuario = vEmailUsuario;
END$$

/* Procedure criada para gerar ocorrência */

DROP PROCEDURE IF EXISTS gerarOcorrencia$$

CREATE PROCEDURE gerarOcorrencia(vCodigo INT, vDsOcorrencia TEXT, vEmailUsuario VARCHAR(200), vCodigoServico INT, vCodigoTipoOcorrencia INT)
BEGIN
	INSERT INTO
		ocorrencia 
	VALUES 
		(vCodigo, vDsOcorrencia, current_date(), vEmailUsuario, vCodigoServico, vCodigoTipoOcorrencia);
END$$

/* CRIAÇÃO DE FUNCTIONS */

/* PROCEDURES PARA O FUNCIONAMENTO DO AGENDAMENTO DE SERVIÇO */

/* Procedure buscarPaciente será usada para encontrar o nome e código do cliente, pelo email do cliente */

DROP PROCEDURE IF EXISTS buscarPacientes$$

CREATE PROCEDURE buscarPacientes(vEmailUsuario VARCHAR(100))
BEGIN 
	SELECT 
		cd_paciente, nm_paciente,  
		nm_cidade_paciente, nm_uf_paciente,
		img_paciente
	FROM 
		paciente 
	WHERE 
		nm_email_usuario = vEmailUsuario;
END$$

/* Procedure buscarEnderecoPaciente será usada para buscar todas as informações do endereço do paciente */

DROP PROCEDURE IF EXISTS buscarEnderecoPaciente$$

CREATE PROCEDURE buscarEnderecoPaciente(vCodigoPaciente INT)
BEGIN
	select 
		nm_cidade_paciente, nm_rua_paciente, cd_num_paciente, 
		nm_uf_paciente, nm_complemento_paciente, nm_bairro_cidade,
		cd_CEP_paciente
	from 
		paciente 
	where 
		cd_paciente = vCodigoPaciente;
END$$

/* Procedure alterarEnderecoPaciente será usada para salvar um novo endereco que ocorrerá o serviço*/

DROP PROCEDURE IF EXISTS alterarEnderecoPaciente$$

CREATE PROCEDURE alterarEnderecoPaciente(vCep VARCHAR(12), vCidade VARCHAR(200), vBairro VARCHAR(200), vRua VARCHAR(200), vNum INT, vUf VARCHAR(200), vComplemento VARCHAR(100), vCodigoPaciente INT)
BEGIN
	UPDATE 
		paciente
	SET
		cd_CEP_paciente = vCep, nm_cidade_paciente = vCidade, nm_bairro_cidade = vBairro,
		nm_rua_paciente = vRua, cd_num_paciente = vNum, nm_uf_paciente = vUf,
		nm_complemento_paciente = vComplemento
	WHERE
		cd_paciente = vCodigoPaciente;
END$$

/* Procedure buscarCuidadres será usada para buscar os cuidadores aptos para aqueles dias e horas de serviço escolhido pelo cliente */

DROP PROCEDURE IF EXISTS buscarCuidadores$$

CREATE PROCEDURE buscarCuidadores(vDataServico DATE, vHoraInicio TIME, vHoraFim TIME)
BEGIN
	SELECT 
		u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
		u.vl_hora_trabalho, u.cd_avaliacao, 
		GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
	FROM 
		usuario u 
	JOIN 
		disponibilidade d 
	ON 
		(u.nm_email_usuario = d.nm_email_usuario)
	JOIN
		especializacao_usuario eu
	ON	
		(u.nm_email_usuario = eu.nm_email_usuario)
	JOIN 
		tipo_especializacao te
	ON
		(eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
	WHERE 
		d.dt_disponibilidade = vDataServico 
	AND 
		d.hr_inicio_disponibilidade <= vHoraInicio 
	AND 
		d.hr_fim_disponibilidade >= vHoraFim
	GROUP BY
		u.nm_email_usuario;
END$$

/* Procedure buscarCuidadres será usada para buscar os cuidadores aptos para aqueles dias e horas de serviço escolhido pelo cliente (virou o dia) */

DROP PROCEDURE IF EXISTS buscarCuidadoresVirarDia$$

CREATE PROCEDURE buscarCuidadoresVirarDia(vDataServico DATE, vHoraInicio TIME, vHoraFim TIME)
BEGIN
	SELECT 
		u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
		u.vl_hora_trabalho, u.cd_avaliacao, 
		GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
	FROM 
		usuario u 
	JOIN 
		disponibilidade d 
	ON 
		(u.nm_email_usuario = d.nm_email_usuario)
	JOIN
		especializacao_usuario eu
	ON	
		(u.nm_email_usuario = eu.nm_email_usuario)
	JOIN 
		tipo_especializacao te
	ON
		(eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
	WHERE 
		dt_disponibilidade = vDataServico 
	AND 
		hr_inicio_disponibilidade <= vHoraInicio 
	AND 
		hr_fim_disponibilidade >= vHoraFim
	AND EXISTS
		(
			SELECT 
				u.nm_usuario, u.vl_hora_trabalho, d.* 
			FROM 
				usuario u 
			JOIN 
				disponibilidade d 
			ON 
				(u.nm_email_usuario = d.nm_email_usuario ) 
			WHERE
				dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) 
			AND
				hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
			
		)
	GROUP BY
		u.nm_email_usuario;
END$$

/* Procedure filtrarCuidadores será usada caso o cliente queira buscar o cuidador pelas opções do filtro */

DROP PROCEDURE IF EXISTS filtrarCuidadores$$
CREATE PROCEDURE filtrarCuidadores(vDataServico DATE, vHoraInicio TIME, vHoraFim TIME, vE BOOL, vP BOOL, vA BOOl, vG BOOl, vEspecializacao VARCHAR(100), vPreco DECIMAL(10, 2), vAvaliacao VARCHAR(100), vGenero VARCHAR(100))
BEGIN 
	SET @decimalVPreco := cast(vPreco as decimal(10,2));
    SET @intAvaliacao := cast(vAvaliacao as unsigned);
    
    
	IF (vE = TRUE) THEN
		IF (vP = TRUE) THEN
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao
					AND tp.nm_genero = vGenero;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = @decimalVPreco
					AND tp.nm_genero = vGenero;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = @decimalVPreco;
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.cd_avaliacao >= @intAvaliacao
					AND tp.nm_genero = vGenero;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.cd_avaliacao >= @intAvaliacao;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND tp.nm_genero = vGenero;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao;
				END IF;
			END IF;
		END IF;
	ELSE
		IF (vP = TRUE) THEN
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao
					AND tp.nm_genero = vGenero;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = @decimalVPreco
					AND tp.nm_genero = vGenero;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = @decimalVPreco;
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_avaliacao >= @intAvaliacao
					AND tp.nm_genero = vGenero;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_avaliacao >= @intAvaliacao;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND tp.nm_genero = vGenero;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim; 
				END IF;
			END IF;
		END IF;
	END IF;
END$$

/* Procedure filtrarCuidadores será usada caso o cliente queira buscar o cuidador pelas opções do filtro e o serviço termine no próximo dia */

DROP PROCEDURE IF EXISTS filtrarCuidadoresVirarDia$$
CREATE PROCEDURE filtrarCuidadoresVirarDia(vDataServico DATE, vHoraInicio TIME, vHoraFim TIME, vE BOOL, vP BOOL, vA BOOl, vG BOOl, vEspecializacao INT, vPreco DECIMAL(10, 2), vAvaliacao Varchar(100), vGenero VARCHAR(100))
BEGIN 
    SET @decimalVPreco := cast(vPreco as decimal(10,2));
    SET @intAvaliacao := cast(vAvaliacao as unsigned);
	IF (vE = TRUE) THEN
		IF (vP = TRUE) THEN
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = @decimalVPreco
					AND u.cd_avaliacao >=  @intAvaliacao
					AND tp.nm_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = @decimalVPreco
					AND u.cd_avaliacao >=  @intAvaliacao
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)

					WHERE d.dt_disponibilidade = vDataServico 

					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = @decimalVPreco
					AND tp.nm_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = @decimalVPreco
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.cd_avaliacao >=  @intAvaliacao
					AND tp.nm_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND u.cd_avaliacao >=  @intAvaliacao
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND tp.nm_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND eu.cd_tipo_especializacao = vEspecializacao
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			END IF;
		END IF;
	ELSE
		IF (vP = TRUE) THEN
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao
					AND tp.nm_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = @decimalVPreco
					AND tp.nm_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = @decimalVPreco
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_avaliacao >= @intAvaliacao
					AND tp.nm_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_avaliacao >= @intAvaliacao
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND tp.nm_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario )
					JOIN especializacao_usuario eu
					ON (u.nm_email_usuario = eu.nm_email_usuario)
					JOIN tipo_especializacao te
					ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
                    JOIN tipo_genero tp 
                    ON (u.cd_genero = tp.cd_genero)
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						); 
				END IF;
			END IF;
		END IF;
	END IF;
END$$

/* procedure cuidadorEscolhido será usada para mostrar as informações do cuidador que o cliente clicar */

DROP PROCEDURE IF EXISTS cuidadorEscolhido$$

CREATE PROCEDURE cuidadorEscolhido(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT 
		u.img_usuario, u.vl_hora_trabalho, u.nm_usuario, 
		te.nm_tipo_especializacao, g.nm_genero, u.ds_experiencia_usuario, 
		u.ds_usuario 
	FROM 
		usuario u 
	JOIN 
		especializacao_usuario eu
	ON 
		(u.nm_email_usuario = eu.nm_email_usuario)
	JOIN 
		tipo_genero g 
	ON 
		(g.cd_genero = u.cd_genero)
	JOIN 
		tipo_especializacao te
	ON
		(eu.cd_tipo_especializacao - te.cd_tipo_especializacao) 
	WHERE 
		u.nm_email_usuario = vEmailCuidador;

END$$

/* Procedure agendarServico será usada para executar um insert e registrar o serviço agendado */

DROP PROCEDURE IF EXISTS agendarServico$$

CREATE PROCEDURE agendarServico(vCodigo INT, vDataServico DATE, vHoraInicioServico TIME, vHoraFimServico TIME, vCEP VARCHAR(12), vCidade VARCHAR(200), vBairro VARCHAR(200), vRua VARCHAR(200), vNum INT, vUF VARCHAR(200), vComp VARCHAR(100), vEmailCliente VARCHAR(200), vEmailCuidador VARCHAR(200), vCodigoPaciente INT)
BEGIN
	INSERT INTO servico
		(cd_servico, dt_inicio_servico, hr_inicio_servico, dt_fim_servico, hr_fim_servico, cd_CEP_servico, nm_cidade_servico, nm_bairro_servico,
		nm_rua_servico, cd_num_servico, nm_uf_servico, nm_complemento_servico, nm_email_usuario, nm_email_usuario_cuidador, cd_status_servico, cd_paciente)
	VALUES
		(vCodigo, vDataServico, vHoraInicioServico, vDataServico, vHoraFimServico, vCEP, vCidade, vBairro ,vRua, vNum, vUF, vComp,
		vEmailCliente, vEmailCuidador, 2, vCodigoPaciente);
END$$

/* Procedure agendarServico será usada para executar um insert e registrar o serviço agendado que mude o dia de término */

DROP PROCEDURE IF EXISTS agendarServicoVirarDia$$

CREATE PROCEDURE agendarServicoVirarDia(vCodigo INT, vDataServico DATE, vHoraInicioServico TIME, vHoraFimServico TIME, vCEP VARCHAR(12), vCidade VARCHAR(200), vBairro VARCHAR(200), vRua VARCHAR(200), vNum INT, vUF VARCHAR(200), vComp VARCHAR(100), vEmailCliente VARCHAR(200), vEmailCuidador VARCHAR(200), vCodigoPaciente INT)
BEGIN
	INSERT INTO servico
		(cd_servico, dt_inicio_servico, hr_inicio_servico, dt_fim_servico, hr_fim_servico, cd_CEP_servico, nm_cidade_servico, nm_bairro_servico,
		nm_rua_servico, cd_num_servico, nm_uf_servico, nm_complemento_servico, nm_email_usuario, nm_email_usuario_cuidador, cd_status_servico, cd_paciente)
	VALUES
		(vCodigo, vDataServico, vHoraInicioServico, DATE_ADD(vDataServico, INTERVAL 1 DAY), vHoraFimServico, vCEP, vCidade, vBairro ,vRua, vNum, vUF, 
		vComp, vEmailCliente, vEmailCuidador, 2, vCodigoPaciente);
END$$

/* Procedure listarServicos será usada para listar todos os servicos agendados pelo cliente e ordenados de forma decrescente, podendo ser: em andamento, pendentes, finalizados e cancelados */

DROP PROCEDURE IF EXISTS listarAgendaClienteJaFoi$$

CREATE PROCEDURE listarAgendaClienteJaFoi(vEmailCliente VARCHAR(200))
BEGIN 
	SELECT 
		date_format(s.dt_inicio_servico, '%d/%m/%Y') AS DtInicioServico, time_format(s.hr_inicio_servico,'%H:%i') as Hora_Inicio, time_format(s.hr_fim_servico, '%H:%i') as Hora_Fim, u.img_usuario AS ImagemCuidador,u.nm_usuario 
	AS Nome_Cuidador, group_concat(te.nm_tipo_especializacao) AS NomeEspecializacao, time_format(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i') AS DuracaoServico, p.nm_paciente AS nomePaciente,
	tss.nm_status_servico AS StatusServico, u.vl_hora_trabalho AS valorHora, s.cd_servico as cdServico
	FROM 
		servico s 
	JOIN 
		usuario u 
	ON 
		(s.nm_email_usuario_cuidador = u.nm_email_usuario) 
	JOIN 
		paciente p 
	ON 
		(p.cd_paciente = s.cd_paciente)
	JOIN 
		especializacao_usuario eu
	ON
		(u.nm_email_usuario = eu.nm_email_usuario)
	JOIN
		tipo_especializacao te
	ON
		(te.cd_tipo_especializacao = eu.cd_tipo_especializacao)
	JOIN
		tipo_status_servico tss
	ON
		(s.cd_status_servico = tss.cd_status_servico)
	WHERE 
		u.nm_email_usuario = vEmailCliente
    AND 
		s.cd_status_servico = 3
	OR  
		s.cd_status_servico = 4
    GROUP BY
		s.cd_servico
	ORDER BY 
		s.dt_inicio_servico;
END$$

/* Procedure listarServicos será usada para listar todos os servicos agendados pelo cliente e ordenados de forma decrescente, podendo ser: em andamento, pendentes, finalizados e cancelados */

DROP PROCEDURE IF EXISTS listarAgendaClienteJaFoiSelecionado$$

CREATE PROCEDURE listarAgendaClienteJaFoiSelecionado(vCodigoServico INT)
BEGIN 
	SELECT 
		u.img_usuario, u.nm_usuario, u.cd_avaliacao, group_concat(te.nm_tipo_especializacao), tg.nm_genero, u.ds_usuario, 
		s.nm_rua_servico, s.cd_num_servico ,s.cd_CEP_servico, s.nm_complemento_servico, 
		s.nm_cidade_servico, s.nm_uf_servico, time_format(s.hr_inicio_servico, '%H:%i'), time_format(s.hr_fim_servico, '%H:%i'), 
		time_format(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'),u.vl_hora_trabalho 
	FROM 
		usuario u
	JOIN
		servico s 
	ON
		(u.nm_email_usuario = s.nm_email_usuario_cuidador)
	JOIN
		especializacao_usuario eu
	ON
		(s.nm_email_usuario_cuidador = eu.nm_email_usuario)
	JOIN
		tipo_especializacao te 
	ON
		(te.cd_tipo_especializacao = eu.cd_tipo_especializacao)
	JOIN
		tipo_genero tg
	ON
		(tg.cd_genero = u.cd_genero)
	WHERE 
		s.cd_servico = vCodigoServico;
END$$


DROP PROCEDURE IF EXISTS listarAgendaClienteNaoFoi$$

CREATE PROCEDURE listarAgendaClienteNaoFoi(vEmailCliente VARCHAR(200))
BEGIN 
	SELECT 
		DATEDIFF(s.dt_inicio_servico,current_date()) as diferencaDia, u.nm_usuario as nomeCuidador, group_concat(te.nm_tipo_especializacao) as Especializacao,
		date_format(s.dt_inicio_servico, '%d/%m/%Y') as dataServico, time_format(s.hr_inicio_servico, '%H:%i') as horaInicioServico, time_format(s.hr_fim_servico, '%H:%i') as horaFimServico, p.nm_paciente as nomePaciente,
		tss.nm_status_servico as statusServico, u.vl_hora_trabalho as valorHora, TIMEDIFF(time_format(s.hr_fim_servico,'%H:%i'),time_format(s.hr_inicio_servico,'%H:%i')) 
		as duracaoServico, u.img_usuario as imagemCuidador, s.cd_servico as cdServico
	FROM 
		servico s 
	JOIN 
		usuario u 
	ON 
		(s.nm_email_usuario_cuidador = u.nm_email_usuario) 
	JOIN 
		paciente p 
	ON 
		(p.cd_paciente = s.cd_paciente)
	JOIN
		tipo_status_servico tss
	ON 
		(tss.cd_status_servico = s.cd_status_servico)
	JOIN 
		especializacao_usuario eu
	ON
		(eu.nm_email_usuario = u.nm_email_usuario)
	JOIN
		tipo_especializacao te
	ON
		(te.cd_tipo_especializacao = eu.cd_tipo_especializacao)
	WHERE 
		u.nm_email_usuario = vEmailCliente
    AND 
		s.cd_status_servico = 1
	OR  
		s.cd_status_servico = 2
	OR
		s.cd_status_servico = 5
	GROUP BY s.cd_servico
	ORDER BY 
		s.dt_inicio_servico;
END$$

DROP PROCEDURE IF EXISTS proxCodigo$$

CREATE PROCEDURE proxCodigo()
BEGIN 
	SELECT
		MAX(cd_servico) + 1
	FROM
		servico;
END$$

/* Procedure proxCodigoOcorrencia será usada para bsucar o último código e somar 1 para saber o próximo */

DROP PROCEDURE IF EXISTS proxCodigoOcorrencia$$

CREATE PROCEDURE proxCodigoOcorrencia()
BEGIN 
	SELECT
		MAX(cd_ocorrencia) + 1
	FROM
		ocorrencia;
END$$

/* Procedure criada para buscar os cuidadores disponíveis no horário de agora */

DROP PROCEDURE IF EXISTS buscarCuidadoresAgora$$

CREATE PROCEDURE buscarCuidadoresAgora(vValorHora DECIMAL(10, 2))
BEGIN
	SELECT 
		u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
		u.vl_hora_trabalho, u.cd_avaliacao, 
		GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações
	FROM 
		usuario u 
	JOIN
		especializacao_usuario eu
	ON	
		(u.nm_email_usuario = eu.nm_email_usuario)
	JOIN 
		tipo_especializacao te
	ON
		(eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
	WHERE 
		u.ic_ativo = true
	AND
		u.vl_hora_trabalho <= vValorHora
	GROUP BY
		u.nm_email_usuario;
END$$

/* Procedure criada para buscar os pacientes que estão em serviço no momento da busca */

DROP PROCEDURE IF EXISTS buscarPacienteServicoEmAndamento$$

CREATE PROCEDURE buscarPacienteServicoEmAndamento(vEmailUsuario VARCHAR(200	))
BEGIN
	SELECT 
		p.img_paciente, p.nm_paciente, p.nm_cidade_paciente, 
		p.nm_uf_paciente, s.cd_servico
	FROM
		servico s 
	JOIN
		paciente p 
	ON
		(s.cd_paciente = p.cd_paciente)
	WHERE
		s.cd_status_servico = 1
	AND
	    s.nm_email_usuario = vEmailUsuario;
END$$

/*PROCEDURES REFENRENTE AO CUIDADOR*/

/* Procedure será usada para enviar o formulário de cadstro do usuário */

DROP PROCEDURE IF EXISTS cadastrarCuidador$$

CREATE PROCEDURE cadastrarCuidador(vEmailCuidador VARCHAR(200), vNomeUsuario VARCHAR(200), vCPF VARCHAR(15), vTel VARCHAR(15), vSenha VARCHAR(128), vValorHora DECIMAL(10, 2), vCurriculo TEXT, vExperiencia TEXT, vDescricao TEXT, vGenero INT)
BEGIN
	INSERT INTO
		usuario(nm_email_usuario, nm_usuario, cd_CPF, cd_telefone, nm_senha, img_usuario, vl_hora_trabalho,  
		cd_link_curriculo, ic_ativo, ds_experiencia_usuario, ds_usuario, cd_tipo_usuario, cd_genero, cd_situacao_usuario)
	VALUES
		(vEmailCuidador, vNomeUsuario, vCPF, vTel, MD5(vSenha), null, vValorHora, vCurriculo,
		false, vExperiencia, vDescricao, 3, vGenero, 2);
END$$

/* Procedure será usada para cadastrar as especializações do cuidador */

DROP PROCEDURE IF EXISTS cadastrarEspecializacoes$$

CREATE PROCEDURE cadastrarEspecializacoes(vEspecializacao INT, vEmailCuidador VARCHAR(200))
BEGIN
	INSERT INTO
		especializacao_usuario
	VALUES
		(vEspecializacao, vEmailCuidador);
END$$

/* Procedure será usada pra listar os serviços pendentes em ordem decrescente */

DROP PROCEDURE IF EXISTS listarServicosFuturos$$

CREATE PROCEDURE listarServicosFuturos(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT 
		p.nm_paciente, s.nm_rua_servico, s.cd_num_servico, group_concat(tnp.nm_tipo_necessidade_paciente),
		DATE_FORMAT(s.dt_inicio_servico, '%d/%m/%Y'), s.hr_inicio_servico, s.hr_fim_servico, 
		tss.nm_status_servico, p.img_paciente,DATEDIFF(s.dt_inicio_servico, current_date()), 
		u.vl_hora_trabalho, TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), s.cd_servico
	FROM 
		servico s 
	JOIN 
		paciente p 
	ON 
		(s.cd_paciente = p.cd_paciente) 
	JOIN 
		necessidade_paciente np 
	ON 
		(p.cd_paciente = np.cd_paciente) 
	JOIN 
		tipo_necessidade_paciente tnp 
	ON 
		(np.cd_tipo_necessidade_paciente = tnp.cd_tipo_necessidade_paciente) 
	JOIN
		tipo_status_servico tss
	ON
		(tss.cd_status_servico = s.cd_status_servico)
	JOIN
		usuario u 
	ON
		(u.nm_email_usuario = s.nm_email_usuario_cuidador)
	WHERE 
		s.nm_email_usuario_cuidador = vEmailCuidador AND s.cd_status_servico = 2
	GROUP BY
		s.cd_servico
	ORDER BY 
		s.dt_inicio_servico DESC, s.hr_inicio_servico; 
END$$

/* Procedure será usada pra listar os serviços pendentes em ordem crescente */

DROP PROCEDURE IF EXISTS listarServicosProximos$$

CREATE PROCEDURE listarServicosProximos(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT 
		p.nm_paciente, s.nm_rua_servico, s.cd_num_servico, group_concat(tnp.nm_tipo_necessidade_paciente),
		DATE_FORMAT(s.dt_inicio_servico, '%d/%m/%Y'), s.hr_inicio_servico, s.hr_fim_servico, tss.nm_status_servico, p.img_paciente, DATEDIFF(s.dt_inicio_servico, current_date()),
		u.vl_hora_trabalho, TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), s.cd_servico
	FROM 
		servico s 
	JOIN 
		paciente p 
	ON 
		(s.cd_paciente = p.cd_paciente) 
	JOIN 
		necessidade_paciente np 
	ON 
		(p.cd_paciente = np.cd_paciente) 
	JOIN 
		tipo_necessidade_paciente tnp 
	ON 
		(np.cd_tipo_necessidade_paciente = tnp.cd_tipo_necessidade_paciente) 
	JOIN
		tipo_status_servico tss
	ON
		(tss.cd_status_servico = s.cd_status_servico)
	JOIN
		usuario u 
	ON
		(u.nm_email_usuario = s.nm_email_usuario_cuidador)
	WHERE 
		s.nm_email_usuario_cuidador = vEmailCuidador AND s.cd_status_servico = 2
	GROUP BY
		s.cd_servico
	ORDER BY 
		s.dt_inicio_servico, s.hr_inicio_servico; 
END$$

/* Procedure usada para listar os serviços já fainalizados em order decrescente */

DROP PROCEDURE IF EXISTS listarServicosFinalizadosAntigos$$

CREATE PROCEDURE listarServicosFinalizadosAntigos(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT 
		p.img_paciente, p.nm_paciente, s.nm_rua_servico, s.cd_servico, tnp.nm_tipo_necessidade_paciente,
		DATE_FORMAT(s.dt_inicio_servico, '%d/%m/%Y'), TIME_FORMAT(s.hr_inicio_servico, '%H:%i'), TIME_FORMAT(s.hr_fim_servico, '%H:%i'),
		u.vl_hora_trabalho, TIME_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'), p.cd_paciente
	FROM 
		servico s 
	JOIN 
		paciente p 
	ON 
		(s.cd_paciente = p.cd_paciente) 
	JOIN 
		necessidade_paciente np 
	ON 
		(p.cd_paciente = np.cd_paciente) 
	JOIN 
		tipo_necessidade_paciente tnp 
	ON 
		(np.cd_tipo_necessidade_paciente = tnp.cd_tipo_necessidade_paciente) 
	JOIN 
		usuario u
	ON
		(s.nm_email_usuario_cuidador = u.nm_email_usuario)
	WHERE 
		s.nm_email_usuario_cuidador = vEmailCuidador AND s.cd_status_servico = 3
	ORDER BY 
		s.dt_inicio_servico DESC, s.hr_inicio_servico; 
END$$

/* Procedure será usada pra listar os serviços já finalziados em ordem crescente */

DROP PROCEDURE IF EXISTS listarServicosFinalizadosRecentes$$

CREATE PROCEDURE listarServicosFinalizadosRecentes(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT 
		p.img_paciente, p.nm_paciente, s.nm_rua_servico, s.cd_servico, tnp.nm_tipo_necessidade_paciente,
		DATE_FORMAT(s.dt_inicio_servico, '%d/%m/%Y'), TIME_FORMAT(s.hr_inicio_servico, '%H:%i'), TIME_FORMAT(s.hr_fim_servico, '%H:%i'),
		u.vl_hora_trabalho, TIME_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'), p.cd_paciente
	FROM 
		servico s 
	JOIN 
		paciente p 
	ON 
		(s.cd_paciente = p.cd_paciente) 
	JOIN 
		necessidade_paciente np 
	ON 
		(p.cd_paciente = np.cd_paciente) 
	JOIN 
		tipo_necessidade_paciente tnp 
	ON 
		(np.cd_tipo_necessidade_paciente = tnp.cd_tipo_necessidade_paciente) 
	JOIN 
		usuario u
	ON
		(s.nm_email_usuario_cuidador = u.nm_email_usuario)
	WHERE 
		s.nm_email_usuario_cuidador = vEmailCuidador AND s.cd_status_servico = 3
	ORDER BY 
		s.dt_inicio_servico, s.hr_inicio_servico; 
END$$

/* Procedure será usada para mostrar as informações completas do serviço */

DROP PROCEDURE IF EXISTS servicoSelecionado$$

CREATE PROCEDURE servicoSelecionado(vCodigoServico INT)
BEGIN
	SELECT 
		p.img_paciente, p.nm_paciente, GROUP_CONCAT(tnp.nm_tipo_necessidade_paciente), p.ds_paciente, s.cd_CEP_servico, s.nm_cidade_servico, 
		s.nm_uf_servico, s.nm_bairro_servico, s.nm_rua_servico, s.cd_num_servico, s.nm_complemento_servico, 
		TIME_FORMAT(s.hr_inicio_servico, '%H:%i'), TIME_FORMAT(s.hr_fim_servico, '%H:%i'), 
		DATE_FORMAT(s.dt_inicio_servico, '%d/%m/%Y'), u.vl_hora_trabalho, TIME_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'), tsp.nm_status_servico
	FROM 
		servico s 
	JOIN
		paciente p 
	ON 
		(s.cd_paciente = p.cd_paciente) 
	JOIN 
		necessidade_paciente np 
	ON 
		(p.cd_paciente = np.cd_paciente) 
	JOIN 
		tipo_necessidade_paciente tnp 
	ON 
		(np.cd_tipo_necessidade_paciente = tnp.cd_tipo_necessidade_paciente)
	JOIN
		usuario u 
	ON
		(s.nm_email_usuario_cuidador = u.nm_email_usuario)
	JOIN
		tipo_status_servico tsp
	ON  (tsp.cd_status_servico = s.cd_status_servico)
	WHERE 
		s.cd_servico = vCodigoServico;
END$$

/* Procedure criada para salvar o horário do check-in */

DROP PROCEDURE IF EXISTS marcarCheckin$$
	
CREATE PROCEDURE marcarCheckin(vServico INT)
BEGIN 
	UPDATE
		servico
	SET
		hr_checkin_servico = CURRENT_TIME(), dt_checkin_servico = CURRENT_DATE()
	WHERE
		cd_servico = vServico;
END$$

/* Procedure criada para salvar o horário do check-out */

DROP PROCEDURE IF EXISTS marcarCheckout$$
	
CREATE PROCEDURE marcarCheckout(vServico INT)
BEGIN 
	UPDATE
		servico
	SET
		hr_checkout_servico = CURRENT_TIME(), dt_checkiout_servico = CURRENT_DATE()
	WHERE
		cd_servico = vServico;
END$$

/* Procedure criada para buscar informações do serviço atual */

DROP PROCEDURE IF EXISTS infoServicoAtual$$

CREATE PROCEDURE infoServicoAtual(vServico INT)
BEGIN
	SELECT
		u.img_usuario, u.nm_usuario, s.nm_rua_servico, s.cd_num_servico, 
		s.nm_bairro_servico, DATE_FORMAT(s.dt_inicio_servico, '%d/%m/%Y'),
		CASE WEEKDAY(s.dt_inicio_servico) 
                       when 0 then 'Segunda-feira'
                       when 1 then 'Terça-feira'
                       when 2 then 'Quarta-feira'
                       when 3 then 'Quinta-feira'
                       when 4 then 'Sexta-feira'
                       when 5 then 'Sábado'
                       when 6 then 'Domingo'                 
                       END AS DiaDaSemana,
		TIME_FORMAT(s.hr_inicio_servico, '%H:%i'), TIME_FORMAT(s.hr_fim_servico, '%H:%i'), s.cd_geolocalizacao_entrada,
		u.vl_hora_trabalho, TIME_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i')
	FROM
		servico s
	JOIN
		paciente p
	ON
		(s.cd_paciente = p.cd_paciente)
	JOIN
		necessidade_paciente np
	ON
		(p.cd_paciente = np.cd_paciente)
	JOIN
		tipo_necessidade_paciente tnp
	ON
		(np.cd_tipo_necessidade_paciente = tnp.cd_tipo_necessidade_paciente)
	JOIN
		usuario u
	ON
		(s.nm_email_usuario_cuidador = u.nm_email_usuario)
	WHERE
		s.cd_servico = vServico;
END$$	

/* Procedure criada para tornar o cuidador disponível para serviços sem agendamento */

DROP PROCEDURE IF EXISTS tornarDisponivel$$

CREATE PROCEDURE tornarDisponivel(vEmailUsuario VARCHAR(200))
BEGIN
	UPDATE 
		usuario
	SET 
		ic_ativo = true
	WHERE
		nm_email_usuario = vEmailUsuario;
END$$

/* Procedure criada para tornar o cuidador indisponível para serviços sem agendamento */

DROP PROCEDURE IF EXISTS tornarIndisponivel$$

CREATE PROCEDURE tornarIndisponivel(vEmailUsuario VARCHAR(200))
BEGIN
	UPDATE 
		usuario
	SET 
		ic_ativo = false
	WHERE
		nm_email_usuario = vEmailUsuario;
END$$

/*PROCEDURES REFENRENTE AO ADMINISTRADOR*/

/* Procedure criada para o adm listar as ocorrências */

DROP PROCEDURE IF EXISTS listarOcorrencia$$

CREATE PROCEDURE listarOcorrencia()
BEGIN
	SELECT
		o.cd_ocorrencia, o.dt_ocorrencia, o.ds_ocorrencia,
		o.nm_email_usuario, o.cd_servico, tpo.nm_tipo_ocorrencia
	FROM
		ocorrencia o
	JOIN
		tipo_ocorrencia tpo
	ON
		(o.cd_tipo_ocorrencia = tpo.cd_tipo_ocorrencia);
END$$

/* Proedure criada para listar os cuidadores a serem contratados */

DROP PROCEDURE IF EXISTS listarSituacaoCuidadores$$

CREATE PROCEDURE listarSituacaoCuidadores(vSituacaoUsuario INT)
BEGIN
	SELECT 
		u.nm_email_usuario, u.img_usuario, u.nm_usuario,
		u.cd_avaliacao, u.vl_hora_trabalho, GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializacao
	FROM
		usuario u
	JOIN 
		especializacao_usuario eu
	ON
		(u.nm_email_usuario = eu.nm_email_usuario)
	JOIN 
		tipo_especializacao te
	ON
		(eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
	WHERE
		u.cd_situacao_usuario = vSituacaoUsuario
	GROUP BY
		u.nm_email_usuario;
END$$

/* Procedure criada para visualizar as informações de cuidadores que podem ser contratados */

DROP PROCEDURE IF EXISTS verificarCuidador$$

CREATE PROCEDURE verificarCuidador(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT
		u.nm_usuario, tg.nm_genero, u.cd_avaliacao,
		u.cd_telefone, u.cd_CPF, u.nm_email_usuario, 
		u.cd_link_curriculo, u.ds_usuario, 
		GROUP_CONCAT(te.nm_tipo_especializacao) AS Especialização, u.vl_hora_trabalho
	FROM
		usuario u
	JOIN
		tipo_genero tg
	ON
		(u.cd_genero = tg.cd_genero)
	JOIN
		especializacao_usuario eu
	ON
		(u.nm_email_usuario = eu.nm_email_usuario)
	JOIN
		tipo_especializacao te
	ON
		(eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
	WHERE
		u.nm_email_usuario = vEmailCuidador
	GROUP BY
		u.nm_email_usuario;
END$$

/* Procedure criada para definir o cuidador como contratado */

DROP PROCEDURE IF EXISTS contratarCuidador$$

CREATE PROCEDURE contratarCuidador(vEmailCuidador VARCHAR(200))
BEGIN
	UPDATE
		usuario
	SET
		cd_situacao_usuario = 1
	WHERE
		nm_email_usuario = vEmailCuidador;
END$$

/* Procedure criada para listar todas as ocorrências cadastradas */

DROP PROCEDURE IF EXISTS listarOcorrencia$$

CREATE PROCEDURE listarOcorrencia()
BEGIN
	SELECT 
		o.cd_ocorrencia, o.ds_ocorrencia, o.dt_ocorrencia,
		o.nm_email_usuario, o.cd_servico, tpo.nm_tipo_ocorrencia
	FROM
		ocorrencia o 
	JOIN 
		tipo_ocorrencia tpo
	ON
		(o.cd_tipo_ocorrencia = tpo.cd_tipo_ocorrencia)
	ORDER BY 
		o.cd_ocorrencia;
END$$

/* Procedure criada para listar o número de ocorrências de cada cuidador */

DROP PROCEDURE IF EXISTS listarNumerosOcorrencia$$

CREATE PROCEDURE listarNumerosOcorrencia()
BEGIN
	SELECT
		u.nm_email_usuario, COUNT(o.cd_ocorrencia)
	FROM
		usuario u
	JOIN 
		ocorrencia o
	ON
		(u.nm_email_usuario = o.nm_email_usuario)
	GROUP BY
		u.nm_email_usuario
	ORDER BY
		o.cd_ocorrencia
	DESC;
END$$

/* Procedure criada para marcar o cuidador na situação de advertido */

DROP PROCEDURE IF EXISTS situacaoAdvertencia$$

CREATE PROCEDURE situacaoAdvertencia(vEmailCuidador VARCHAR(200))
BEGIN
	UPDATE
		usuario
	SET
		cd_situacao_usuario = 3
	WHERE	
		nm_email_usuario = vEmailCuidador;
END$$

/* Procedure criada para saber o próximo código de advertência */

DROP PROCEDURE IF EXISTS proxCodigoAdvertencia$$

CREATE PROCEDURE proxCodigoAdvertencia()
BEGIN 
	SELECT
		MAX(cd_advertencia) + 1
	FROM
		advertencia;
END$$

/* Procedure criada para definir o tempo de advertencia do cuidador */

DROP PROCEDURE IF EXISTS definirAdvertencia$$

CREATE PROCEDURE definirAdvertencia(vCodigo INT, vDescricao TEXT, vDataInicio DATE, vDataFim DATE, vEmailUsuario VARCHAR(200), vEmailAdm VARCHAR(200), vTipoAdvertencia INT)
BEGIN
	INSERT INTO 
		advertencia
	VALUES
		(vCodigo, vDescricao, vDataInicio, vDataFim, vEmailUsuario, vEmailAdm, vTipoAdvertencia);
END$$

/* Procedure criada para marcar o cuidador na situação de demitido */

DROP PROCEDURE IF EXISTS marcarDemissao$$

CREATE PROCEDURE marcarDemissao(vEmailCuidador VARCHAR(200))
BEGIN
	UPDATE
		usuario
	SET
		cd_situacao_usuario = 4
	WHERE	
		nm_email_usuario = vEmailCuidador;
END$$


DROP PROCEDURE IF EXISTS buscarDadosPaciente$$

CREATE PROCEDURE buscarDadosPaciente(vCdPaciente VARCHAR(200))
BEGIN
	select 
	nm_paciente, tnp.nm_tipo_necessidade_paciente, ds_paciente, 
	cd_CEP_paciente, nm_cidade_paciente, nm_bairro_cidade, nm_rua_paciente,cd_num_paciente,
    nm_uf_paciente,nm_complemento_paciente, img_paciente
    from paciente
	JOIN 
    necessidade_paciente np ON (paciente.cd_paciente = np.cd_paciente)
	JOIN 
    tipo_necessidade_paciente tnp ON (np.cd_tipo_necessidade_paciente = tnp.cd_tipo_necessidade_paciente)
	WHERE paciente.cd_paciente = vCdPaciente;
END$$

DROP PROCEDURE IF EXISTS atualizarDadosPaciente$$

CREATE PROCEDURE atualizarDadosPaciente(vCdPaciente VARCHAR(200),vNmPaciente varchar(200),vDsPaciente varchar(200),vCepPaciente varchar(200),vCidadePaciente varchar(200),vBairroPaciente varchar(200),vRuaPaciente varchar(200),vNumPaciente varchar(200),vUFPaciente varchar(200),vComplementoPaciente varchar(200))
BEGIN
	UPDATE
    paciente
	SET nm_paciente = vNmPaciente, ds_paciente = vDsPaciente, cd_CEP_paciente = vCepPaciente, 
	nm_cidade_paciente = vCidadePaciente, nm_bairro_cidade = vBairroPaciente, nm_rua_paciente = vRuaPaciente,cd_num_paciente = vNumPaciente,
    nm_uf_paciente = vUFPaciente,nm_complemento_paciente = vComplementoPaciente
	WHERE cd_paciente = vCdPaciente;
END$$

DROP PROCEDURE IF EXISTS proxCdPaciente$$

CREATE PROCEDURE proxCdPaciente(OUT maxCD varchar(30))
BEGIN 
	SELECT
		MAX(cd_paciente) + 1
	FROM
		paciente;
END$$

DROP PROCEDURE IF EXISTS adicionarPaciente$$

CREATE PROCEDURE adicionarPaciente(vUsuarioLogado varchar(200),vNmPaciente varchar(200),vDsPaciente varchar(200),vCepPaciente varchar(200),vCidadePaciente varchar(200),vBairroPaciente varchar(200),vRuaPaciente varchar(200),vNumPaciente varchar(200),vUFPaciente varchar(200),vComplementoPaciente varchar(200))
BEGIN
	SET @maxCD = (SELECT MAX(cd_paciente) + 1 FROM paciente LIMIT 1);
	Insert into paciente (cd_paciente,nm_paciente, ds_paciente,cd_CEP_paciente,nm_cidade_paciente,nm_bairro_cidade,nm_rua_paciente,cd_num_paciente,nm_uf_paciente,nm_complemento_paciente, nm_email_usuario)
	Values (@maxCD,vNmPaciente,vDsPaciente,vCepPaciente,vCidadePaciente ,vBairroPaciente,vRuaPaciente,vNumPaciente ,vUFPaciente ,vComplementoPaciente,vUsuarioLogado);
END$$





DELIMITER ;