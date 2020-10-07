DELIMITER $$

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
		nm_uf_paciente, cd_complemento_paciente, nm_bairro_cidade,
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
		cd_complemento_paciente = vComplemento
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
		tpe.nm_tipo_especializacao 
	FROM 
		usuario u 
	JOIN 
		disponibilidade d 
	ON 
		(u.nm_email_usuario = d.nm_email_usuario)
	JOIN
		tipo_especializacao tpe
	ON	
		(u.cd_tipo_especializacao = tpe.cd_tipo_especializacao)
	WHERE 
		dt_disponibilidade = vDataServico 
	AND 
		hr_inicio_disponibilidade <= vHoraInicio 
	AND 
		hr_fim_disponibilidade >= vHoraFim;
END$$

/* Procedure buscarCuidadres será usada para buscar os cuidadores aptos para aqueles dias e horas de serviço escolhido pelo cliente (virou o dia) */

DROP PROCEDURE IF EXISTS buscarCuidadoresVirarDia$$

CREATE PROCEDURE buscarCuidadoresVirarDia(vDataServico DATE, vHoraInicio TIME, vHoraFim TIME)
BEGIN
	SELECT 
		u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
		u.vl_hora_trabalho, u.cd_avaliacao, 
		tpe.nm_tipo_especializacao 
	FROM 
		usuario u 
	JOIN 
		disponibilidade d 
	ON 
		(u.nm_email_usuario = d.nm_email_usuario)
	JOIN
		tipo_especializacao tpe
	ON	
		(u.cd_tipo_especializacao = tpe.cd_tipo_especializacao) 
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
		);
END$$

/* Procedure filtrarCuidadores será usada caso o cliente queira buscar o cuidador pelas opções do filtro */

DROP PROCEDURE IF EXISTS filtrarCuidadores$$

CREATE PROCEDURE filtrarCuidadores(vDataServico DATE, vHoraInicio TIME, vHoraFim TIME, vE BOOL, vP BOOL, vA BOOl, vG BOOl, vEspecializacao INT, vPreco DECIMAL(10, 2), vAvaliacao INT, vGenero INT)
BEGIN 
	IF (vE = TRUE) THEN
		IF (vP = TRUE) THEN
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_avaliacao >= vAvaliacao
					AND u.cd_genero = vGenero;
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_avaliacao >= vAvaliacao;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_genero = vGenero;
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = vPreco;
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.cd_avaliacao >= vAvaliacao
					AND u.cd_genero = vGenero;
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.cd_avaliacao >= vAvaliacao;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.cd_genero = vGenero;
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao;
				END IF;
			END IF;
		END IF;
	ELSE
		IF (vP = TRUE) THEN
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_avaliacao >= vAvaliacao
					AND u.cd_genero = vGenero;
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_avaliacao >= vAvaliacao;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_genero = vGenero;
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = vPreco;
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_avaliacao >= vAvaliacao
					AND u.cd_genero = vGenero;
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_avaliacao >= vAvaliacao;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_genero = vGenero;
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
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

CREATE PROCEDURE filtrarCuidadoresVirarDia(vDataServico DATE, vHoraInicio TIME, vHoraFim TIME, vE BOOL, vP BOOL, vA BOOl, vG BOOl, vEspecializacao INT, vPreco DECIMAL(10, 2), vAvaliacao INT, vGenero INT)
BEGIN 
	IF (vE = TRUE) THEN
		IF (vP = TRUE) THEN
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_avaliacao >= vAvaliacao
					AND u.cd_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_avaliacao >= vAvaliacao
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.vl_hora_trabalho = vPreco
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.cd_avaliacao >= vAvaliacao
					AND u.cd_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.cd_avaliacao >= vAvaliacao
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND u.cd_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_tipo_especializacao = vEspecializacao
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
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
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_avaliacao >= vAvaliacao
					AND u.cd_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_avaliacao >= vAvaliacao
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = vPreco
					AND u.cd_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.vl_hora_trabalho = vPreco
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_avaliacao >= vAvaliacao
					AND u.cd_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_avaliacao >= vAvaliacao
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim 
					AND u.cd_genero = vGenero
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
						);
				ELSE
					SELECT u.nm_email_usuario, u.nm_usuario, u.vl_hora_trabalho 
					FROM usuario u 
					JOIN disponibilidade d 
					ON (u.nm_email_usuario = d.nm_email_usuario ) 
					WHERE d.dt_disponibilidade = vDataServico 
					AND d.hr_inicio_disponibilidade <= vHoraInicio
					AND d.hr_fim_disponibilidade >= vHoraFim
					AND EXISTS
						(
							SELECT u.nm_usuario, u.vl_hora_trabalho FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
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
		e.nm_tipo_especializacao, g.nm_genero, u.ds_experiencia_usuario, 
		u.ds_usuario 
	FROM 
		usuario u 
	JOIN 
		tipo_especializacao e
	ON 
		(u.cd_tipo_especializacao = e.cd_tipo_especializacao)
	JOIN 
		tipo_genero g 
	ON 
		(g.cd_genero = u.cd_genero) 
	AND 
		nm_email_usuario = vEmailCuidador;

END$$

/* Procedure agendarServico será usada para executar um insert e registrar o serviço agendado */

DROP PROCEDURE IF EXISTS agendarServico$$

CREATE PROCEDURE agendarServico(vCodigo INT, vDataServico DATE, vHoraInicioServico TIME, vHoraFimServico TIME, vCEP VARCHAR(12), vCidade VARCHAR(200), vBairro VARCHAR(200), vRua VARCHAR(200), vNum INT, vUF VARCHAR(200), vComp VARCHAR(100), vEmailCliente VARCHAR(200), vEmailCuidador VARCHAR(200), vCodigoPaciente INT)
BEGIN
	INSERT INTO servico
		(cd_servico, dt_inicio_servico, hr_inicio_servico, dt_fim_servico, hr_fim_servico, cd_CEP_servico, nm_cidade_servico, nm_bairro_servico,
		nm_rua_servico, cd_num_servico, nm_uf_servico, cd_complemento_servico, nm_email_usuario, nm_email_usuario_cuidador, cd_paciente)
	VALUES
		(vCodigo, vDataServico, vHoraInicioServico, vDataServico, vHoraFimServico, vCEP, vCidade, vBairro ,vRua, vNum, vUF, vComp,
		vEmailCliente, vEmailCuidador, vCodigoPaciente);
END$$

/* Procedure agendarServico será usada para executar um insert e registrar o serviço agendado que mude o dia de término */

DROP PROCEDURE IF EXISTS agendarServicoVirarDia$$

CREATE PROCEDURE agendarServicoVirarDia(vCodigo INT, vDataServico DATE, vHoraInicioServico TIME, vHoraFimServico TIME, vCEP VARCHAR(12), vCidade VARCHAR(200), vBairro VARCHAR(200), vRua VARCHAR(200), vNum INT, vUF VARCHAR(200), vComp VARCHAR(100), vEmailCliente VARCHAR(200), vEmailCuidador VARCHAR(200), vCodigoPaciente INT)
BEGIN
	INSERT INTO servico
		(cd_servico, dt_inicio_servico, hr_inicio_servico, dt_fim_servico, hr_fim_servico, cd_CEP_servico, nm_cidade_servico, nm_bairro_servico,
		nm_rua_servico, cd_num_servico, nm_uf_servico, cd_complemento_servico, nm_email_usuario, nm_email_usuario_cuidador, cd_paciente)
	VALUES
		(vCodigo, vDataServico, vHoraInicioServico, DATE_ADD(vDataServico, INTERVAL 1 DAY), vHoraFimServico, vCEP, vCidade, vBairro ,vRua, vNum, vUF, 
		vComp, vEmailCliente, vEmailCuidador, vCodigoPaciente);
END$$

/* Procedure listarServicos será usada para listar todos os servicos agendados pelo cliente e ordenados de forma decrescente, podendo ser: em andamento, pendentes, finalizados e cancelados */

DROP PROCEDURE IF EXISTS listarServicos$$

CREATE PROCEDURE listarServicos(vEmailCliente VARCHAR(200), vStatusServico INT)
BEGIN 
	SELECT 
		s.dt_inicio_servico AS DtInicioServico, u.nm_usuario AS Nome_Cuidador, p.nm_paciente AS NomePaciente
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
	AND 
		s.nm_email_usuario = vEmailCliente 
	AND 
		s.cd_status_servico = vStatusServico
	ORDER BY 
		s.dt_inicio_servico;
END$$

/* Procedur proxCodigo será usada para bsucar o último código de somar 1 para saber o próximo */

DROP PROCEDURE IF EXISTS proxCodigo$$

CREATE PROCEDURE proxCodigo()
BEGIN 
	SELECT
		MAX(cd_servico) + 1
	FROM
		servico;
END$$

DELIMITER ;