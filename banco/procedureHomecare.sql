DELIMITER $$

/* PROCEDURES PARA TODOS OS USUÁRIOS */

/* Procedure criada para verificar login */

DROP PROCEDURE IF EXISTS cadastroCliente$$

CREATE PROCEDURE cadastroCliente(vEmailUsuario VARCHAR(200), vNomeUsuario VARCHAR(200),
vTelefoneUsuario VARCHAR(15), vCpfUsuario VARCHAR(15), vSenhaUsuario VARCHAR(128))
BEGIN

	insert into 
		usuario (nm_email_usuario, nm_usuario, cd_telefone, cd_CPF, nm_senha, cd_tipo_usuario) 
	values 
		(vEmailUsuario, vNomeUsuario, vTelefoneUsuario, vCpfUsuario, md5(vSenhaUsuario), 2);

END$$

DROP PROCEDURE IF EXISTS cadastroCuidador$$

CREATE PROCEDURE cadastroCuidador(vEmailUsuario VARCHAR(200), vNomeUsuario VARCHAR(200), vTelefoneUsuario VARCHAR(15),vCpfUsuario VARCHAR(15), vSenhaUsuario VARCHAR(128), vImgUsuario LONGBLOB, vCdGenero INT, vLinkCurriculo TEXT, vDescricaoCuidador TEXT, vValorHora DECIMAL(10, 2), vDescricaoEspecializacao TEXT)
BEGIN
	insert into usuario (nm_email_usuario, nm_usuario, cd_CPF, cd_telefone, nm_senha, img_usuario, vl_hora_trabalho, cd_link_curriculo, ds_experiencia_usuario, 
	ds_usuario, cd_tipo_usuario, cd_genero, cd_situacao_usuario) 
	values (vEmailUsuario, vNomeUsuario, vCpfUsuario, vTelefoneUsuario, md5(vSenhaUsuario), vImgUsuario, vValorHora, 
	vLinkCurriculo, vDescricaoEspecializacao, vDescricaoCuidador, 3, vCdGenero, 2);
END$$

/* Procedure será usada para cadastrar as especializações do cuidador dentro de um for */

DROP PROCEDURE IF EXISTS cadastrarEspecializacoes$$

CREATE PROCEDURE cadastrarEspecializacoes(vEspecializacao INT, vEmailCuidador VARCHAR(200))
BEGIN
	INSERT INTO
		especializacao_usuario
	VALUES
		(vEspecializacao, vEmailCuidador);
END$$

DROP PROCEDURE IF EXISTS deletarEspecializacoes$$

CREATE PROCEDURE deletarEspecializacoes(vEmailCuidador VARCHAR(200))
BEGIN


	delete from 
		especializacao_usuario 
	where 
		nm_email_usuario = vEmailCuidador;


END$$


DROP PROCEDURE IF EXISTS verificarLogin$$

CREATE PROCEDURE verificarLogin(vEmailUsuario VARCHAR(200), vSenha VARCHAR(128))
BEGIN 
	SELECT 
		nm_email_usuario, cd_tipo_usuario, cd_situacao_usuario
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


DROP PROCEDURE IF EXISTS verificarSenha$$

CREATE PROCEDURE verificarSenha(vEmailUsuario VARCHAR(200), vSenhaAtual VARCHAR(128))
BEGIN
	SELECT 
		md5(nm_senha) 
	FROM 
		usuario 
	WHERE 
		nm_email_usuario = vEmailUsuario
	AND
		nm_senha = md5(vSenhaAtual);
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

/* Function crriada para buscar a quantidade de serviços que um cuidador tem em dia específico para a busca dele no agendamento */

DROP FUNCTION IF EXISTS qtdServicoHorario$$

CREATE FUNCTION qtdServicoHorario(vEmailCuidador VARCHAR(200), vDataServico DATE, vHoraInicio TIME, vHoraFim TIME) RETURNS INT
BEGIN
	DECLARE qtdServico INT;

	SELECT
		COUNT(cd_servico) INTO qtdServico
	FROM
		servico
	WHERE
		(nm_email_usuario_cuidador = vEmailCuidador AND dt_inicio_servico = vDataServico AND hr_inicio_servico >= vHoraInicio AND hr_fim_servico <= vHoraFim)
	OR
		(nm_email_usuario_cuidador = vEmailCuidador AND dt_inicio_servico = vDataServico AND hr_inicio_servico >= vHoraInicio AND hr_fim_servico >= vHoraFim)
	OR
		(nm_email_usuario_cuidador = vEmailCuidador AND dt_inicio_servico = vDataServico AND hr_inicio_servico <= vHoraInicio AND hr_fim_servico <= vHoraFim)
	OR
		(nm_email_usuario_cuidador = vEmailCuidador AND dt_inicio_servico = vDataServico AND hr_inicio_servico <= vHoraInicio AND hr_fim_servico >= vHoraFim);

	RETURN qtdServico;
END$$

/* Procedure buscarCuidadres será usada para buscar os cuidadores aptos para aqueles dias e horas de serviço escolhido pelo cliente */

DROP PROCEDURE IF EXISTS buscarCuidadores$$

CREATE PROCEDURE buscarCuidadores(vDataServico DATE, vHoraInicio TIME, vHoraFim TIME)
BEGIN
	SELECT 
		u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
		u.vl_hora_trabalho, u.cd_avaliacao, 
		buscarEspecializacao(u.nm_email_usuario) AS Especializações,
		qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
		GROUP_CONCAT(te.nm_tipo_especializacao) AS Especializações,
		qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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


/*Procedure confirmarPedido*/

DROP PROCEDURE IF EXISTS confirmarPedido$$
CREATE PROCEDURE confirmarPedido(vCdServico VARCHAR(200))
BEGIN

	UPDATE 
		servico 
	SET
		cd_status_servico = 5
	WHERE
		cd_servico = vCdServico;

END$$

/* function criada para buscar as especializações de cada cuidador refente ao código */

DROP FUNCTION IF EXISTS buscarEspecializacao$$

CREATE FUNCTION buscarEspecializacao(vEmailCuidador VARCHAR(200)) RETURNS TEXT
BEGIN
	DECLARE nomeEspecializacao TEXT;

	SELECT 
		GROUP_CONCAT(te.nm_tipo_especializacao) INTO nomeEspecializacao
	FROM
		tipo_especializacao te
	JOIN 
		especializacao_usuario eu
	ON
		(te.cd_tipo_especializacao = eu.cd_tipo_especializacao)
	WHERE
		eu.nm_email_usuario = vEmailCuidador
	GROUP BY
		eu.nm_email_usuario;

	RETURN nomeEspecializacao;
END$$

/* Procedure filtrarCuidadores será usada caso o cliente queira buscar o cuidador pelas opções do filtro */

DROP PROCEDURE IF EXISTS filtrarCuidadores$$

CREATE PROCEDURE filtrarCuidadores(vDataServico DATE, vHoraInicio TIME, vHoraFim TIME, vE BOOL, vP BOOL, vA BOOl, vG BOOl, vEspecializacao INT, vPreco DECIMAL(10, 2), vAvaliacao DECIMAL(10, 2), vGenero VARCHAR(100))
BEGIN 
	SET @decimalVPreco := cast(vPreco as decimal(10,2));
    SET @intAvaliacao := cast(vAvaliacao as unsigned);
    
    
	IF (vE = TRUE) THEN
		IF (vP = TRUE) THEN
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao
					GROUP BY u.nm_email_usuario;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.vl_hora_trabalho <= @decimalVPreco
					GROUP BY u.nm_email_usuario;
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.cd_avaliacao >= @intAvaliacao
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.cd_avaliacao >= @intAvaliacao
					GROUP BY u.nm_email_usuario;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					GROUP BY u.nm_email_usuario;
				END IF;
			END IF;
		END IF;
	ELSE
		IF (vP = TRUE) THEN
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao
					GROUP BY u.nm_email_usuario;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					GROUP BY u.nm_email_usuario;
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					GROUP BY u.nm_email_usuario;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					GROUP BY u.nm_email_usuario;
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					GROUP BY u.nm_email_usuario;
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					GROUP BY u.nm_email_usuario; 
				END IF;
			END IF;
		END IF;
	END IF;
END$$

/* Procedure filtrarCuidadores será usada caso o cliente queira buscar o cuidador pelas opções do filtro e o serviço termine no próximo dia */

DROP PROCEDURE IF EXISTS filtrarCuidadoresVirarDia$$
CREATE PROCEDURE filtrarCuidadoresVirarDia(vDataServico DATE, vHoraInicio TIME, vHoraFim TIME, vE BOOL, vP BOOL, vA BOOl, vG BOOl, vEspecializacao INT, vPreco DECIMAL(10, 2), vAvaliacao DECIMAL(10, 2), vGenero VARCHAR(100))
BEGIN 
    SET @decimalVPreco := cast(vPreco as decimal(10,2));
    SET @intAvaliacao := cast(vAvaliacao as unsigned);
	IF (vE = TRUE) THEN
		IF (vP = TRUE) THEN
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND u.cd_avaliacao >=  @intAvaliacao
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND u.cd_avaliacao >=  @intAvaliacao
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.vl_hora_trabalho <= @decimalVPreco
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.cd_avaliacao >=  @intAvaliacao
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND u.cd_avaliacao >=  @intAvaliacao
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND eu.cd_tipo_especializacao LIKE vEspecializacao
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
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
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND u.cd_avaliacao >= @intAvaliacao
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					AND u.vl_hora_trabalho <= @decimalVPreco
					AND tp.nm_genero = vGenero
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				END IF;
			END IF;
		ELSE
			IF (vA = TRUE) THEN
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				END IF;
			ELSE
				IF (vG = TRUE) THEN
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
						);
				ELSE
					SELECT  u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
							u.vl_hora_trabalho, u.cd_avaliacao, 
							buscarEspecializacao(u.nm_email_usuario) AS Especializações,
							qtdServicoHorario(u.nm_email_usuario, vDataServico, vHoraInicio, vHoraFim)
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
					GROUP BY u.nm_email_usuario
					AND EXISTS
						(
							SELECT u.nm_email_usuario, u.img_usuario, u.nm_usuario, 
								   u.vl_hora_trabalho, u.cd_avaliacao, 
		                           buscarEspecializacao(u.nm_email_usuario) AS Especializações FROM usuario u 
							JOIN disponibilidade d ON (u.nm_email_usuario = d.nm_email_usuario ) 
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario) 
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							WHERE dt_disponibilidade = DATE_ADD(vDataServico, INTERVAL 1 DAY) AND
							hr_inicio_disponibilidade >= '00:00:00' AND hr_fim_disponibilidade >= '01:00:00'
							GROUP BY u.nm_email_usuario
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
		buscarEspecializacao(u.nm_email_usuario), g.nm_genero, u.ds_experiencia_usuario, 
		u.ds_usuario, u.cd_CPF, u.cd_telefone, u.cd_link_curriculo
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
		u.nm_email_usuario = vEmailCuidador
	GROUP BY 
		u.nm_email_usuario;
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

/* Porocedure criada para buscar um servico para agora */

DROP PROCEDURE IF EXISTS agendarServicoAgora$$

CREATE PROCEDURE agendarServicoAgora(vCodigo INT, vHoraFimServico TIME, vCEP VARCHAR(12), vCidade VARCHAR(200), vBairro VARCHAR(200), vRua VARCHAR(200), vNum INT, vUF VARCHAR(200), vComp VARCHAR(100), vEmailCliente VARCHAR(200), vCodigoPaciente INT, vValorMaximo DECIMAL(10, 2))
BEGIN
	INSERT INTO servico
		(cd_servico, dt_inicio_servico, hr_inicio_servico, dt_fim_servico, hr_fim_servico, cd_CEP_servico, nm_cidade_servico, nm_bairro_servico,
		nm_rua_servico, cd_num_servico, nm_uf_servico, nm_complemento_servico, nm_email_usuario, cd_status_servico, cd_paciente, vl_maximo)
	VALUES
		(vCodigo, CURRENT_DATE(), CURRENT_TIME(), CURRENT_DATE(), vHoraFimServico, vCEP, vCidade, vBairro ,vRua, vNum, vUF, vComp,
		vEmailCliente, 6, vCodigoPaciente, vValorMaximo);
END$$

/* Porocedure criada para buscar um servico para agora e virar o dia */

DROP PROCEDURE IF EXISTS agendarServicoAgoraVirarDia$$

CREATE PROCEDURE agendarServicoAgoraVirarDia(vCodigo INT, vHoraFimServico TIME, vCEP VARCHAR(12), vCidade VARCHAR(200), vBairro VARCHAR(200), vRua VARCHAR(200), vNum INT, vUF VARCHAR(200), vComp VARCHAR(100), vEmailCliente VARCHAR(200), vCodigoPaciente INT, vValorMaximo DECIMAL(10, 2))
BEGIN
	INSERT INTO servico
		(cd_servico, dt_inicio_servico, hr_inicio_servico, dt_fim_servico, hr_fim_servico, cd_CEP_servico, nm_cidade_servico, nm_bairro_servico,
		nm_rua_servico, cd_num_servico, nm_uf_servico, nm_complemento_servico, nm_email_usuario, cd_status_servico, cd_paciente, vl_maximo)
	VALUES
		(vCodigo, CURRENT_DATE(), CURRENT_TIME(), DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY), vHoraFimServico, vCEP, vCidade, vBairro ,vRua, vNum, vUF, vComp,
		vEmailCliente, 6, vCodigoPaciente, vValorMaximo);
END$$

/* Procedure listarServicos será usada para listar todos os servicos agendados pelo cliente e ordenados de forma decrescente, podendo ser: em andamento, pendentes, finalizados e cancelados */

DROP PROCEDURE IF EXISTS listarAgendaClienteJaFoi$$

CREATE PROCEDURE listarAgendaClienteJaFoi(vEmailCliente VARCHAR(200))
BEGIN 
	SELECT 
		date_format(s.dt_inicio_servico, '%d/%m/%Y') AS DtInicioServico, time_format(s.hr_inicio_servico,'%H:%i') as Hora_Inicio, 
		time_format(s.hr_fim_servico, '%H:%i') as Hora_Fim, u.img_usuario AS ImagemCuidador,u.nm_usuario AS Nome_Cuidador, 
		group_concat(te.nm_tipo_especializacao) AS NomeEspecializacao, 
		time_format(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i') AS DuracaoServico, p.nm_paciente AS nomePaciente,
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
		(eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
	JOIN
		tipo_status_servico tss
	ON
		(s.cd_status_servico = tss.cd_status_servico)
	WHERE 
		s.nm_email_usuario = vEmailCliente
	AND
		s.cd_status_servico = 3
	OR
		(s.cd_status_servico = 4 AND s.nm_email_usuario = vEmailCliente)
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
		time_format(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'),u.vl_hora_trabalho, s.nm_email_usuario_cuidador 
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
		s.nm_email_usuario = vEmailCliente
    AND 
		s.cd_status_servico = 1
	OR  
		(s.nm_email_usuario = vEmailCliente AND s.cd_status_servico = 2)
	OR
		(s.cd_status_servico = 5 AND s.nm_email_usuario = vEmailCliente)
	GROUP BY s.cd_servico
	ORDER BY 
		s.dt_inicio_servico;
END$$


DROP PROCEDURE IF EXISTS listarAgendaClienteNaoFoiSelecionado$$

CREATE PROCEDURE listarAgendaClienteNaoFoiSelecionado(vCodigoServico INT)
BEGIN 
	SELECT 
		u.img_usuario, u.nm_usuario, u.cd_avaliacao, group_concat(te.nm_tipo_especializacao), tg.nm_genero, u.ds_usuario, 
		s.nm_rua_servico, s.cd_num_servico ,s.cd_CEP_servico, s.nm_complemento_servico, 
		s.nm_cidade_servico, s.nm_uf_servico, time_format(s.hr_inicio_servico, '%H:%i'), time_format(s.hr_fim_servico, '%H:%i'), 
		time_format(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'),u.vl_hora_trabalho, tss.nm_status_servico, s.nm_email_usuario_cuidador
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
	JOIN
		tipo_status_servico tss
	ON
		(tss.cd_status_servico = s.cd_status_servico)
	WHERE 
		s.cd_servico = vCodigoServico;
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
		u.nm_email_usuario
	FROM 
		usuario u 
	WHERE 
		ic_ativo = true
	AND
		vl_hora_trabalho <= vValorHora
	GROUP BY
		nm_email_usuario;
END$$

/* Procedure criada para buscar os servicos que estão com o cidog 6 */

DROP PROCEDURE IF EXISTS servicoParaAgora$$

CREATE PROCEDURE servicoParaAgora()
BEGIN
	SELECT
		cd_servico, vl_maximo
	FROM
		servico
	WHERE
		cd_status_servico = 6
	AND
		dt_inicio_servico = CURRENT_DATE();
END$$

/* Procedure criada para atualizar os dados e aceitar o serviço de agora */

DROP PROCEDURE IF EXISTS aceitarServicoAgora$$

CREATE PROCEDURE aceitarServicoAgora(vCodigo INT, vEmailCuidador VARCHAR(200))
BEGIN
	UPDATE
		servico
	SET
		nm_email_usuario_cuidador = vEmailCuidador,
		cd_status_servico = 1
	WHERE
		cd_servico = vCodigo;
END$$

/* Procedure criada para buscar informações do serviço de agora com dia da semana */

DROP PROCEDURE IF EXISTS infoServicoAtualCuidador$$

CREATE PROCEDURE infoServicoAtualCuidador(vCodigoServico INT)
BEGIN
	SELECT
		p.img_paciente, p.nm_paciente, GROUP_CONCAT(tnp.nm_tipo_necessidade_paciente), s.nm_rua_servico, s.cd_num_servico, 
		s.nm_complemento_servico, DATE_FORMAT(s.dt_inicio_servico, '%d/%m'),
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
		u.vl_hora_trabalho, TIME_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'),nm_bairro_servico,nm_cidade_servico,nm_uf_servico
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
		s.cd_servico = vCodigoServico
	GROUP BY
		s.cd_servico;
END$$

/* Procedure criada para buscar os pacientes que estão em serviço no momento da busca */

DROP PROCEDURE IF EXISTS buscarPacienteServicoEmAndamento$$

CREATE PROCEDURE buscarPacienteServicoEmAndamento(vEmailUsuario VARCHAR(200))
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

/* Procedure será usada pra listar os serviços pendentes em ordem crescente */

DROP PROCEDURE IF EXISTS listarServicosAgendados$$

CREATE PROCEDURE listarServicosAgendados(vEmailCuidador VARCHAR(200))
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

/* Procedure criada para cancelar o servico agendado */

DROP PROCEDURE IF EXISTS cancelarServicoAgendado$$

CREATE PROCEDURE cancelarServicoAgendado(vCodigoServico INT)
BEGIN
	UPDATE
		servico
	SET
		cd_status_servico = 4
	WHERE
		cd_servico = vCodigoServico;
END$$ 

/* Procedure usada para listar os serviços já fainalizados em order decrescente */

DROP PROCEDURE IF EXISTS listarServicosFinalizadosAntigos$$

CREATE PROCEDURE listarServicosFinalizadosAntigos(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT 
		p.img_paciente, p.nm_paciente, s.nm_rua_servico, s.cd_servico, GROUP_CONCAT(tnp.nm_tipo_necessidade_paciente),
		DATE_FORMAT(s.dt_inicio_servico, '%d/%m/%Y'), TIME_FORMAT(s.hr_inicio_servico, '%H:%i'), TIME_FORMAT(s.hr_fim_servico, '%H:%i'),
		u.vl_hora_trabalho, TIME_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'), p.cd_paciente, s.cd_status_servico
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
		(s.nm_email_usuario_cuidador = vEmailCuidador AND s.cd_status_servico = 3)
	OR
		(s.nm_email_usuario_cuidador = vEmailCuidador AND s.cd_status_servico = 4)
	GROUP BY
		s.cd_servico
	ORDER BY 
		s.dt_inicio_servico DESC, s.hr_inicio_servico; 
END$$

/* Procedure será usada pra listar os serviços já finalziados em ordem crescente */

DROP PROCEDURE IF EXISTS listarServicosFinalizadosRecentes$$

CREATE PROCEDURE listarServicosFinalizadosRecentes(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT 
		p.img_paciente, p.nm_paciente, s.nm_rua_servico, s.cd_servico, GROUP_CONCAT(tnp.nm_tipo_necessidade_paciente),
		DATE_FORMAT(s.dt_inicio_servico, '%d/%m/%Y'), TIME_FORMAT(s.hr_inicio_servico, '%H:%i'), TIME_FORMAT(s.hr_fim_servico, '%H:%i'),
		u.vl_hora_trabalho, TIME_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'), p.cd_paciente, s.cd_status_servico
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
		(s.nm_email_usuario_cuidador = vEmailCuidador AND s.cd_status_servico = 3)
	OR
		(s.nm_email_usuario_cuidador = vEmailCuidador AND s.cd_status_servico = 4)
	GROUP BY
		s.cd_servico
	ORDER BY 
		s.dt_inicio_servico, s.hr_inicio_servico; 
END$$

/* procedure criada para filtrar os servicos finalizados por data */

DROP PROCEDURE IF EXISTS listarServicosFinalizadosData$$

CREATE PROCEDURE listarServicosFinalizadosData(vEmailCuidador VARCHAR(200), vDataServico DATE)
BEGIN
	SELECT 
		p.img_paciente, p.nm_paciente, s.nm_rua_servico, s.cd_servico, GROUP_CONCAT(tnp.nm_tipo_necessidade_paciente),
		DATE_FORMAT(s.dt_inicio_servico, '%d/%m/%Y'), TIME_FORMAT(s.hr_inicio_servico, '%H:%i'), TIME_FORMAT(s.hr_fim_servico, '%H:%i'),
		u.vl_hora_trabalho, TIME_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'), p.cd_paciente, s.cd_status_servico
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
		(s.nm_email_usuario_cuidador = vEmailCuidador AND s.cd_status_servico = 3)
	OR
		(s.nm_email_usuario_cuidador = vEmailCuidador AND s.cd_status_servico = 4)
	AND
		s.dt_inicio_servico = vDataServico
	GROUP BY
		s.cd_servico
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
	ON  
		(tsp.cd_status_servico = s.cd_status_servico)
	WHERE 
		s.cd_servico = vCodigoServico;
END$$

/* Procedure será usada para mostrar as informações completas do serviço de agora */

DROP PROCEDURE IF EXISTS servicoSelecionadoAgora$$

CREATE PROCEDURE servicoSelecionadoAgora(vCodigoServico INT)
BEGIN
	SELECT 
		p.img_paciente, p.nm_paciente, GROUP_CONCAT(tnp.nm_tipo_necessidade_paciente), p.ds_paciente, s.cd_CEP_servico, s.nm_cidade_servico, 
		s.nm_uf_servico, s.nm_bairro_servico, s.nm_rua_servico, s.cd_num_servico, s.nm_complemento_servico, 
		TIME_FORMAT(s.hr_inicio_servico, '%H:%i'), TIME_FORMAT(s.hr_fim_servico, '%H:%i'), 
		DATE_FORMAT(s.dt_inicio_servico, '%d/%m/%Y'), TIME_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'), tsp.nm_status_servico
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
		(s.nm_email_usuario = u.nm_email_usuario)
	JOIN
		tipo_status_servico tsp
	ON  
		(tsp.cd_status_servico = s.cd_status_servico)
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
		hr_checkout_servico = CURRENT_TIME(), dt_checkout_servico = CURRENT_DATE(), cd_status_servico = 3
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
		u.vl_hora_trabalho, TIME_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'), p.nm_cidade_paciente, p.nm_uf_paciente
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

/* Procedure criada para verificar a disponibilidade do cuidador, sabendo se ele está em serviço ou não */

DROP PROCEDURE IF EXISTS verificarDisponibilidade$$

CREATE PROCEDURE verificarDisponibilidade(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT
		s.cd_servico, p.img_paciente, p.nm_paciente, GROUP_CONCAT(tnp.nm_tipo_necessidade_paciente), s.nm_rua_servico, s.cd_num_servico, 
		s.nm_complemento_servico, DATE_FORMAT(s.dt_inicio_servico, '%d/%m'),
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
		u.vl_hora_trabalho, TIME_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i'), s.hr_checkin_servico
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
		s.dt_inicio_servico = CURRENT_DATE()
	AND
		s.hr_inicio_servico <= CURRENT_TIME 
	AND 
		s.hr_fim_servico >= CURRENT_TIME()
	AND
		s.cd_status_servico = 1
	AND
		s.nm_email_usuario_cuidador = vEmailCuidador
	GROUP BY
		s.cd_servico;
END$$

/*PROCEDURES REFENRENTE AO ADMINISTRADOR*/

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

/* Procedure criada para definir o cuidador como demitido */

DROP PROCEDURE IF EXISTS recusarCuidador$$

CREATE PROCEDURE recusarCuidador(vEmailCuidador VARCHAR(200))
BEGIN
	UPDATE
		usuario
	SET
		cd_situacao_usuario = 4
	WHERE
		nm_email_usuario = vEmailCuidador;
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

/* Procedure criada para buscar os cuidadores para contrato */

DROP PROCEDURE IF EXISTS listarCuidadoresContrato$$

CREATE PROCEDURE listarCuidadoresContrato()
BEGIN
	SELECT 
		u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
		GROUP_CONCAT(te.nm_tipo_especializacao) AS especializações,
		u.nm_email_usuario
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
		u.cd_situacao_usuario = 2
	GROUP BY
		u.nm_email_usuario;
END$$

/* Procedure criada para listar quantidade de ocorrências do cuidador */

DROP PROCEDURE IF EXISTS listarOcorrencia$$

CREATE PROCEDURE listarOcorrencia(vEmailCuidador VARCHAR(200)) 
BEGIN
	SELECT
		COUNT(o.cd_ocorrencia)
	FROM
		ocorrencia o
	JOIN 
		servico s
	ON
		(o.cd_servico = s.cd_servico)
	WHERE 
		s.nm_email_usuario_cuidador = vEmailCuidador
	AND
		o.ic_verificado = 0;
END$$

/* Procedure criada para listar quantidade de advertências do cuidador */

DROP PROCEDURE IF EXISTS listarAdvertencia$$

CREATE PROCEDURE listarAdvertencia(vEmailCuidador VARCHAR(200)) 
BEGIN
	SELECT
		COUNT(cd_advertencia)
	FROM
		advertencia 
	WHERE 
		nm_email_usuario = vEmailCuidador;
END$$

/* Function criada para contar a quantidade de serviços que um cuidador tem */

DROP FUNCTION IF EXISTS countServico$$

CREATE FUNCTION countServico(vEmailCuidador VARCHAR(200)) RETURNS INT
BEGIN
	DECLARE qtdServico INT;

	SELECT
		COUNT(cd_servico) INTO qtdServico
	FROM
		servico
	WHERE
		nm_email_usuario_cuidador = vEmailCuidador;
	
	RETURN qtdServico;
END$$ 

/* Procedure criada para buscar informações completas do cuidador para contrato selecionado pelo adm */

DROP PROCEDURE IF EXISTS infoCuidadorContrato$$

CREATE PROCEDURE infoCuidadorContrato(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT
		u.img_usuario, u.nm_usuario, tg.nm_genero, u.cd_CPF,
		u.cd_telefone, u.nm_email_usuario, u.ds_usuario,
		GROUP_CONCAT(te.nm_tipo_especializacao) AS especializacao, 
		u.vl_hora_trabalho, u.cd_link_curriculo, u.cd_situacao_usuario,
		countServico(u.nm_email_usuario)
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
	JOIN
		servico s 
	ON
		(u.nm_email_usuario = s.nm_email_usuario_cuidador)
	WHERE
		u.nm_email_usuario = vEmailCuidador
	GROUP BY
		u.nm_email_usuario;
END$$

/* Procedure criada para buscar informações básicas de todos os cuidadores */

DROP PROCEDURE IF EXISTS listarCuidadores$$

CREATE PROCEDURE listarCuidadores()
BEGIN
	SELECT 
		u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
		buscarEspecializacao(u.nm_email_usuario) AS especializações,
		nm_situacao_usuario, u.nm_email_usuario
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
	JOIN
		tipo_situacao_usuario tsu
	ON
		(u.cd_situacao_usuario = tsu.cd_situacao_usuario)
	WHERE
		u.cd_tipo_usuario = 3
	GROUP BY
		u.nm_email_usuario;
END$$

/* Procedure criada para buscar informações básicas de todos os serviços de um cuidador */

DROP PROCEDURE IF EXISTS infoServicoCuidador$$

CREATE PROCEDURE infoServicoCuidador(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT
		s.nm_email_usuario, DATE_FORMAT(s.dt_inicio_servico, '%d/%m/%Y'), 
		DATE_FORMAT(s.dt_fim_servico, '%d/%m/%Y'), TIME_FORMAT(s.hr_inicio_servico, '%H:%i'), 
		TIME_FORMAT(s.hr_fim_servico, '%H:%i'), DATE_FORMAT(TIMEDIFF(s.hr_fim_servico, s.hr_inicio_servico), '%H:%i') AS duração,
		u.vl_hora_trabalho, tsu.nm_status_servico
	FROM
		servico s
	JOIN	
		usuario u
	ON
		(s.nm_email_usuario_cuidador = u.nm_email_usuario)
	JOIN
		tipo_status_servico tsu
	ON
		(s.cd_status_servico = tsu.cd_status_servico)
	WHERE
		s.nm_email_usuario_cuidador = vEmailCuidador
	ORDER BY
		s.dt_inicio_servico DESC;
END$$

/* Procedure criada para buscar as informações de denúncias que o cuidador recebeu */

DROP PROCEDURE IF EXISTS listarOcorrenciaCuidador$$

CREATE PROCEDURE listarOcorrenciaCuidador(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT
		tpo.nm_tipo_ocorrencia, DATE_FORMAT(o.dt_ocorrencia, '%d/%m/%Y'), 
		u.nm_usuario, o.nm_email_usuario, o.ds_ocorrencia, o.cd_ocorrencia,
		o.cd_tipo_ocorrencia
	FROM
		ocorrencia o 
	JOIN
		usuario u 
	ON
		(o.nm_email_usuario = u.nm_email_usuario)
	JOIN
		servico s
	ON
		(o.cd_servico = s.cd_servico)
	JOIN
		tipo_ocorrencia tpo 
	ON		
		(o.cd_tipo_ocorrencia = tpo.cd_tipo_ocorrencia)
	WHERE
		s.nm_email_usuario_cuidador = vEmailCuidador
	AND
		o.ic_verificado = 0
	ORDER BY
		o.dt_ocorrencia;
END$$

/* Procedure criada para aplicar advertência ao cuidador */

DROP PROCEDURE IF EXISTS aplicarAdvertencia$$

CREATE PROCEDURE aplicarAdvertencia(vCodigoOcorrencia INT, vDsOcorrencia TEXT, vEmailCuidador VARCHAR(200), vEmailAdm VARCHAR(200), vCodigoTipoOcorrencia INT)
BEGIN
	INSERT INTO
		advertencia
	VALUES
		(vCodigoOcorrencia, vDsOcorrencia, CURRENT_DATE, vEmailCuidador, vEmailAdm, vCodigoTipoOcorrencia);
END$$

/* Procedure criada para remover ocorrência */

DROP PROCEDURE IF EXISTS removerOcorrencia$$

CREATE PROCEDURE removerOcorrencia(vCodigoOcorrencia INT)
BEGIN
	UPDATE 
		ocorrencia
	SET
		ic_verificado = 1
	WHERE
		cd_ocorrencia = vCodigoOcorrencia;
END$$

/* Procedure criada para listar todas advertências do cuidador */

DROP PROCEDURE IF EXISTS listarAdvertenciaCuidador$$

CREATE PROCEDURE listarAdvertenciaCuidador(vEmailCuidador VARCHAR(200))
BEGIN
	SELECT
		tpa.nm_tipo_advertencia, DATE_FORMAT(a.dt_advertencia, '%d/%m/%Y'), 
		u.nm_usuario, a.nm_email_usuario_admin, a.ds_advertencia
	FROM
		advertencia a 
	JOIN
		usuario u 
	ON
		(a.nm_email_usuario_admin = u.nm_email_usuario)
	JOIN
		tipo_advertencia tpa 
	ON		
		(a.cd_tipo_advertencia = tpa.cd_tipo_advertencia)
	WHERE
		a.nm_email_usuario = vEmailCuidador
	AND
		a.ic_verificado = 0
	ORDER BY
		a.dt_advertencia;
END$$

/* Procedure criada para buscar os cuidadores que tem ocorrências registradas */

DROP PROCEDURE IF EXISTS listarCuidadoresOcorrencia$$

CREATE PROCEDURE listarCuidadoresOcorrencia()
BEGIN
	SELECT
		u.img_usuario, u.nm_usuario, u.vl_hora_trabalho,
		buscarEspecializacao(u.nm_email_usuario), COUNT(o.cd_ocorrencia),
		u.nm_email_usuario
	FROM
		usuario u 
	JOIN
		servico s
	ON
		(u.nm_email_usuario = s.nm_email_usuario_cuidador)
	JOIN
		ocorrencia o
	ON
		(o.cd_servico = s.cd_servico)
	WHERE
		o.ic_verificado = 0
	GROUP BY
		s.nm_email_usuario_cuidador;
END$$


/* Procedure criada para suspender o cuidador por um tempo indeterminado */

DROP PROCEDURE IF EXISTS suspenderCuidador$$

CREATE PROCEDURE suspenderCuidador(vEmailCuidador VARCHAR(200))
BEGIN
	UPDATE
		usuario
	SET
		cd_situacao_usuario = 3
	WHERE
		nm_email_usuario = vEmailCuidador;
END$$

DROP PROCEDURE IF EXISTS dadosSuspensaoCuidador$$

CREATE PROCEDURE dadosSuspensaoCuidador(vEmailCuidador VARCHAR(200))
BEGIN


	select 
		ta.nm_tipo_advertencia, a.ds_advertencia, date_format(a.dt_advertencia, '%d/%m/%Y')
	from 
		advertencia a
	join
		tipo_advertencia ta
	on
		(a.cd_tipo_advertencia = ta.cd_tipo_advertencia)
	where
		a.nm_email_usuario = vEmailCuidador;
	
END$$

/* Procedure criada para tirar suspender do cuidador */

DROP PROCEDURE IF EXISTS removerSuspensao$$

CREATE PROCEDURE removerSuspensao(vEmailCuidador VARCHAR(200))
BEGIN
	UPDATE
		usuario
	SET
		cd_situacao_usuario = 1
	WHERE
		nm_email_usuario = vEmailCuidador;
END$$

/* Procedure criada para banir o cuidador */

DROP PROCEDURE IF EXISTS banirCuidador$$

CREATE PROCEDURE banirCuidador(vEmailCuidador VARCHAR(200))
BEGIN
	UPDATE
		usuario
	SET
		cd_situacao_usuario = 4
	WHERE
		nm_email_usuario = vEmailCuidador;
END$$

/* Procedure criada para desbanir o cuidador caso tenha algum erro */

DROP PROCEDURE IF EXISTS desbanirCuidador$$

CREATE PROCEDURE desbanirCuidador(vEmailCuidador VARCHAR(200))
BEGIN
	UPDATE
		usuario
	SET
		cd_situacao_usuario = 1
	WHERE
		nm_email_usuario = vEmailCuidador;
END$$

/* Procedure criada para o adm filtrar os cuidadores */

DROP PROCEDURE IF EXISTS filtroAdmCuidadores$$

CREATE PROCEDURE filtroAdmCuidadores(vE BOOL, vS BOOL, vP BOOL, vA BOOL, vEm BOOL, vG BOOL, vEspecializacao INT, vStatus INT, vPreco DECIMAL(10, 2), vAvaliacao DECIMAL(10, 2), vEmailCuidador VARCHAR(200), vGenero VARCHAR(200))
BEGIN
	SET @decimalVPreco := cast(vPreco as decimal(10,2));
    SET @intAvaliacao := cast(vAvaliacao as unsigned);

	IF (vE = TRUE) THEN
		IF (vS = TRUE) THEN
			IF (vP = TRUE) THEN
				IF (vA = TRUE) THEN
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				ELSE
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				END IF;
			ELSE
				IF (vA = TRUE) THEN
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.cd_avaliacao >= @intAvaliacao
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.cd_avaliacao >= @intAvaliacao
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				ELSE
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				END IF;
			END IF;
		ELSE
			IF (vP = TRUE) THEN
				IF (vA = TRUE) THEN
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				ELSE
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				END IF;
			ELSE
				IF (vA = TRUE) THEN
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_avaliacao >= @intAvaliacao
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_avaliacao >= @intAvaliacao
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				ELSE
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.cd_situacao_usuario = vStatus
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND	eu.cd_tipo_especializacao LIKE vEspecializacao
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
	ELSE
		IF (vS = TRUE) THEN
			IF (vP = TRUE) THEN
				IF (vA = TRUE) THEN
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				ELSE
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.vl_hora_trabalho <= @decimalVPreco
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				END IF;
			ELSE
				IF (vA = TRUE) THEN
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.cd_avaliacao >= @intAvaliacao
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.cd_avaliacao >= @intAvaliacao
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				ELSE
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_situacao_usuario = vStatus
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				END IF;
			END IF;
		ELSE
			IF (vP = TRUE) THEN
				IF (vA = TRUE) THEN
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.cd_avaliacao >= @intAvaliacao
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				ELSE
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.vl_hora_trabalho <= @decimalVPreco
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.vl_hora_trabalho <= @decimalVPreco
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				END IF;
			ELSE
				IF (vA = TRUE) THEN
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_avaliacao >= @intAvaliacao
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_avaliacao >= @intAvaliacao
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.cd_avaliacao >= @intAvaliacao
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				ELSE
					IF (vEm = TRUE) THEN
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.nm_email_usuario LIKE vEmailCuidador
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND u.nm_email_usuario LIKE vEmailCuidador
							GROUP BY u.nm_email_usuario;
						END IF;
					ELSE
						IF (vG = TRUE) THEN
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							AND tp.nm_genero = vGenero
							GROUP BY u.nm_email_usuario;
						ELSE
							SELECT
							u.img_usuario, u.nm_usuario, u.vl_hora_trabalho, 
							buscarEspecializacao(u.nm_email_usuario) AS especializações,
							nm_situacao_usuario, u.nm_email_usuario
							FROM usuario u
							JOIN tipo_genero tp
							ON (u.cd_genero = tp.cd_genero)
							JOIN especializacao_usuario eu
							ON (u.nm_email_usuario = eu.nm_email_usuario)
							JOIN tipo_especializacao te
							ON (eu.cd_tipo_especializacao = te.cd_tipo_especializacao)
							JOIN tipo_situacao_usuario tsu
							ON (u.cd_situacao_usuario = tsu.cd_situacao_usuario)
							WHERE u.cd_tipo_usuario = 3		
							GROUP BY u.nm_email_usuario;
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
	END IF;
END$$


/* Procedure criada para buscar os dados do paciente */

DROP PROCEDURE IF EXISTS buscarDadosPaciente$$

CREATE PROCEDURE buscarDadosPaciente(vCdPaciente VARCHAR(200))
BEGIN
	select 
	nm_paciente, tnp.nm_tipo_necessidade_paciente, ds_paciente, 
	cd_CEP_paciente, nm_cidade_paciente, nm_bairro_cidade, nm_rua_paciente,cd_num_paciente,
    nm_uf_paciente,nm_complemento_paciente, img_paciente, tnp.cd_tipo_necessidade_paciente
    from paciente
	JOIN 
    necessidade_paciente np ON (paciente.cd_paciente = np.cd_paciente)
	JOIN 
    tipo_necessidade_paciente tnp ON (np.cd_tipo_necessidade_paciente = tnp.cd_tipo_necessidade_paciente)
	WHERE paciente.cd_paciente = vCdPaciente;
END$$

DROP PROCEDURE IF EXISTS atualizarDadosPaciente$$

CREATE PROCEDURE atualizarDadosPaciente(vImgUsuario LONGBLOB, vCdPaciente VARCHAR(200),vNmPaciente varchar(200),vDsPaciente varchar(200),vCepPaciente varchar(200),vCidadePaciente varchar(200),vBairroPaciente varchar(200),vRuaPaciente varchar(200),vNumPaciente varchar(200),vUFPaciente varchar(200),vComplementoPaciente varchar(200))
BEGIN
	UPDATE
    paciente
	SET nm_paciente = vNmPaciente, ds_paciente = vDsPaciente, cd_CEP_paciente = vCepPaciente, 
	nm_cidade_paciente = vCidadePaciente, nm_bairro_cidade = vBairroPaciente, nm_rua_paciente = vRuaPaciente,cd_num_paciente = vNumPaciente,
    nm_uf_paciente = vUFPaciente,nm_complemento_paciente = vComplementoPaciente, img_paciente = vImgUsuario
	WHERE cd_paciente = vCdPaciente;
END$$


DROP PROCEDURE IF EXISTS atualizarNecessidadesPaciente$$

CREATE PROCEDURE atualizarNecessidadesPaciente(vCdPaciente INT, vCdTipoNecessidade INT)
BEGIN

	insert into
		necessidade_paciente 
	values 
		(vCdPaciente, vCdTipoNecessidade);

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

CREATE PROCEDURE adicionarPaciente(vImgUsuario LONGBLOB, vUsuarioLogado varchar(200),vNmPaciente varchar(200),vDsPaciente varchar(200),vCepPaciente varchar(200),vCidadePaciente varchar(200),vBairroPaciente varchar(200),vRuaPaciente varchar(200),vNumPaciente varchar(200),vUFPaciente varchar(200),vComplementoPaciente varchar(200))
BEGIN
	SET @maxCD = (SELECT MAX(cd_paciente) + 1 FROM paciente LIMIT 1);
	Insert into paciente (img_paciente, cd_paciente,nm_paciente, ds_paciente,cd_CEP_paciente,nm_cidade_paciente,nm_bairro_cidade,nm_rua_paciente,cd_num_paciente,nm_uf_paciente,nm_complemento_paciente, nm_email_usuario)
	Values (vImgUsuario, @maxCD,vNmPaciente,vDsPaciente,vCepPaciente,vCidadePaciente ,vBairroPaciente,vRuaPaciente,vNumPaciente ,vUFPaciente ,vComplementoPaciente,vUsuarioLogado);
END$$

DROP PROCEDURE IF EXISTS avaliarServico$$

CREATE PROCEDURE avaliarServico(vEmailUsuario VARCHAR(200), vCdAvaliacao INT)
BEGIN

	UPDATE 
		servico 
	SET
		cd_avaliacao = vCdAvaliacao
	WHERE
		nm_email_usuario_cuidador = vEmailUsuario;

END$$


DROP PROCEDURE IF EXISTS listarEspecializacao$$

CREATE PROCEDURE listarEspecializacao()
BEGIN

	select * from tipo_especializacao;

END$$

/* Proceudre criada para adicionar a disponibilidade do usuario, podendo escolher dia, hora de início e fim */

DROP PROCEDURE IF EXISTS adicionarDisponibilidade$$

CREATE PROCEDURE adicionarDisponibilidade(vDataDisponibilidade DATE, vHoraInicioDisponibilidade TIME, vHoraFimDisponibilidade TIME, vEmailCuidador VARCHAR(200))
BEGIN
	INSERT INTO
		disponibilidade 
	VALUES
		(vDataDisponibilidade, vHoraInicioDisponibilidade, vHoraFimDisponibilidade, vEmailCuidador);
END$$

/* Procedure criada para verificar se a disponibilidade que ele quer adicionar não entra em conflito com outra */

DROP PROCEDURE IF EXISTS verificarHorarioDisponibilidade$$

CREATE PROCEDURE verificarHorarioDisponibilidade(vDataDisponibilidade DATE, vHoraInicioDisponibilidade TIME, vHoraFimDisponibilidade TIME, vEmailCuidador VARCHAR(200))
BEGIN
	SELECT
		*
	FROM
		disponibilidade
	WHERE
		dt_disponibilidade = vDataDisponibilidade 
	AND 
		(hr_inicio_disponibilidade <= vHoraInicioDisponibilidade
	OR
		hr_fim_disponibilidade >= vHoraFimDisponibilidade)
	AND
		nm_email_usuario = vEmailCuidador;
END$$

/* Procedure criada para deletar a disponibilidade caso algum cuidador queira */

DROP PROCEDURE IF EXISTS deletarDisponibilidade$$

CREATE PROCEDURE deletarDisponibilidade(vDataDisponibilidade DATE, vHoraInicioDisponibilidade TIME, vHoraFimDisponibilidade TIME, vEmailCuidador VARCHAR(200))
BEGIN
	DELETE FROM
		disponibilidade
	WHERE
		dt_disponibilidade = vDataDisponibilidade 
	AND 
		hr_inicio_disponibilidade = vHoraInicioDisponibilidade
	AND
		hr_fim_disponibilidade = vHoraFimDisponibilidade
	AND
		nm_email_usuario = vEmailCuidador;
END$$

/* Procedure criada para buscar a disponibilidade de um cuidador referente ao mês */

DROP PROCEDURE IF EXISTS disponibilidadePorMes$$

CREATE PROCEDURE disponibilidadePorMes(vEmailCuidador VARCHAR(200), vMes INT)
BEGIN
	SELECT
		day(dt_disponibilidade), hr_inicio_disponibilidade, hr_fim_disponibilidade
	FROM
		disponibilidade
	WHERE
		nm_email_usuario = vEmailCuidador
	AND
		MONTH(dt_disponibilidade) = vMes
	ORDER BY
		hr_inicio_disponibilidade;
END$$


DROP PROCEDURE IF EXISTS listarNecessidades$$

CREATE PROCEDURE listarNecessidades()
BEGIN

	SELECT 
		cd_tipo_necessidade_paciente, nm_tipo_necessidade_paciente 
	FROM 
		tipo_necessidade_paciente;

END$$


DROP PROCEDURE IF EXISTS deletarNecessidadesPaciente$$

CREATE PROCEDURE deletarNecessidadesPaciente(vCdPaciente INT)

BEGIN

	delete from 
		necessidade_paciente 
	where 
		cd_paciente = vCdPaciente; 

END$$

DROP PROCEDURE IF EXISTS listarUltimoCodigoPaciente$$

CREATE PROCEDURE listarUltimoCodigoPaciente()
BEGIN

	select max(cd_paciente) from paciente;

END$$

DROP PROCEDURE IF EXISTS excluirPaciente$$

CREATE PROCEDURE excluirPaciente(vCdPaciente INT)

BEGIN

	delete from 
		necessidade_paciente
	where
		cd_paciente = vCdPaciente;

	delete from 
		paciente 
	where 
		cd_paciente = vCdPaciente;

END$$

/* Procedure criada para buscar os agendados de um cuidador referente ao mês */

DROP PROCEDURE IF EXISTS buscarServicoAgendadoCuidadorMes$$

CREATE PROCEDURE buscarServicoAgendadoCuidadorMes(vEmailCuidador VARCHAR(200), vMes INT)
BEGIN
	SELECT
		day(dt_inicio_servico), cd_servico, hr_inicio_servico
	FROM
		servico
	WHERE
		nm_email_usuario_cuidador = vEmailCuidador
	AND
		MONTH(dt_inicio_servico) = vMes
	AND
		cd_status_servico = 2
	ORDER BY
		hr_inicio_servico;
END$$

DROP PROCEDURE IF EXISTS editarDadosCuidador$$

CREATE PROCEDURE editarDadosCuidador(vCdGenero INT, vExperienciaCuidador TEXT, vDescricaoCuidador TEXT,vLinkCurriculo TEXT, vValorHora DECIMAL(10,2),vImgUsuario LONGBLOB, vEmailUsuario VARCHAR(200), vNomeCuidador VARCHAR(200), vCpfCuidador VARCHAR(15), vTelefoneCuidador VARCHAR(15))
BEGIN

update 
	usuario 
set 
	nm_usuario = vNomeCuidador, cd_CPF = vCpfCuidador, cd_telefone = vTelefoneCuidador, img_usuario = vImgUsuario, vl_hora_trabalho = vValorHora, 
	cd_link_curriculo = vLinkCurriculo, ds_experiencia_usuario = vExperienciaCuidador, ds_usuario = vDescricaoCuidador, cd_genero = vCdGenero 
where 
	nm_email_usuario = vEmailUsuario;


END$$

/* Procedure será usada pra listar os serviços pendentes em ordem crescente com data específica */

DROP PROCEDURE IF EXISTS listarServicosDia$$

CREATE PROCEDURE listarServicosDia(vEmailCuidador VARCHAR(200), vDataServico DATE)
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
        s.nm_email_usuario_cuidador = vEmailCuidador 
    AND 
        s.cd_status_servico = 2
    AND
        s.dt_inicio_servico = vDataServico
    GROUP BY
        s.cd_servico
    ORDER BY 
        s.dt_inicio_servico, s.hr_inicio_servico; 
END$$

DROP PROCEDURE IF EXISTS buscarDadosCliente$$

CREATE PROCEDURE buscarDadosCliente(vEmailCliente VARCHAR(200))
BEGIN

	select 
		nm_usuario, cd_CPF, cd_telefone 
	from 
		usuario 
	where 
		nm_email_usuario = vEmailCliente;

END$$

DROP PROCEDURE IF EXISTS atualizarDadosCliente$$

CREATE PROCEDURE atualizarDadosCliente(vEmailUsuario VARCHAR(200), vNomeUsuario VARCHAR(200), vCpfUsuario VARCHAR(15), vTelefoneUsuario VARCHAR(15))
BEGIN

	update 
		usuario 
	set 
		nm_usuario = vNomeUsuario, cd_CPF = vCpfUsuario, cd_telefone = vTelefoneUsuario
	where
		nm_email_usuario = vEmailUsuario;

END$$

DROP PROCEDURE IF EXISTS codigoRecuperarSenha$$

CREATE PROCEDURE codigoRecuperarSenha(vEmailUsuario VARCHAR(200))
BEGIN

	select 
		cd_auth_recover 
	from 
		auth_recover 
	where 
		nm_email_usuario = vEmailUsuario;

END$$

DROP PROCEDURE IF EXISTS verificarCodigoRecuperacao$$

CREATE PROCEDURE verificarCodigoRecuperacao(vEmailUsuario VARCHAR(200), vCdRecuperacao INT)
BEGIN

	select 
		cd_auth_recover 
	from 
		auth_recover 
	where 
		nm_email_usuario = vEmailUsuario 
	AND 
		cd_auth_recover = vCdRecuperacao;

END$$

DROP PROCEDURE IF EXISTS inserirAuthRecover$$

CREATE PROCEDURE inserirAuthRecover(vEmailUsuario VARCHAR(200), vCodigoAuthRecover INT)
BEGIN

	insert into 
		auth_recover 
	values 
		(vCodigoAuthRecover, current_time(), current_date(), vEmailUsuario);


END$$

DROP PROCEDURE IF EXISTS deletarAuthRecover$$

CREATE PROCEDURE deletarAuthRecover(vCodigoAuthRecover INT, vEmailUsuario VARCHAR(200))

BEGIN

	delete from 
		auth_recover 
	where 
		cd_auth_recover = vCodigoAuthRecover 
	AND 
		nm_email_usuario = vEmailUsuario;

END$$

DROP PROCEDURE IF EXISTS listarAvaliacoes$$

CREATE PROCEDURE listarAvaliacoes(vEmailUsuario VARCHAR(200))
BEGIN

	select 
		cd_avaliacao 
	from 
		servico 
	where 
		nm_email_usuario_cuidador = vEmailUsuario;

END$$


DELIMITER ;