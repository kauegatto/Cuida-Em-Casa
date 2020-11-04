DROP SCHEMA IF EXISTS prjcuidaemcasa;

CREATE SCHEMA prjcuidaemcasa;
use prjcuidaemcasa;

CREATE TABLE tipo_especializacao
(
	cd_tipo_especializacao INT,
	nm_tipo_especializacao VARCHAR(100),
	CONSTRAINT pk_tipo_especializacao PRIMARY KEY (cd_tipo_especializacao)
); 

insert into tipo_especializacao values(1,'Cuidador');
insert into tipo_especializacao values(2,'Fisioterapia');
insert into tipo_especializacao values(3,'Psicologia');
insert into tipo_especializacao values(4,'Enfermagem');


CREATE TABLE tipo_usuario
(
	cd_tipo_usuario INT,
	nm_tipo_usuario VARCHAR(100),
	CONSTRAINT pk_tipo_usuario PRIMARY KEY (cd_tipo_usuario)
);

insert into tipo_usuario values(1,'Adiministrador');
insert into tipo_usuario values(2,'Cliente');
insert into tipo_usuario values(3,'Cuidador');

CREATE TABLE auth_recover
(
	cd_auth_recover VARCHAR (100),
	hr_criacao_auth_recover TIME,
	dt_criacao_auth_recover DATE,
	CONSTRAINT pk_auth_recover PRIMARY KEY (cd_auth_recover)
);

insert into auth_recover values('123','10:12:08','2020-01-14');
insert into auth_recover values('234','12:30:34','2020-02-12');
insert into auth_recover values('345','09:34:09','2020-04-10');
insert into auth_recover values('456','13:23:45','2020-07-11');

CREATE TABLE tipo_genero 
(
	cd_genero INT,
	nm_genero VARCHAR (45),
	CONSTRAINT pk_genero PRIMARY KEY (cd_genero)
);

insert into tipo_genero values (1, 'Masculino');
insert into tipo_genero values (2, 'Feminino');
insert into tipo_genero values (3, 'Outro');

CREATE TABLE tipo_situacao_usuario
(
	cd_situacao_usuario INT,
	nm_situacao_usuario VARCHAR(100),
	CONSTRAINT pk_tipo_situacao_usuario PRIMARY KEY (cd_situacao_usuario)
);

insert into tipo_situacao_usuario values (1, 'Contratado');
insert into tipo_situacao_usuario values (2, 'Em análise');
insert into tipo_situacao_usuario values (3, 'Em advertência');
insert into tipo_situacao_usuario values (4, 'Demitido');

CREATE TABLE usuario
(
	nm_email_usuario VARCHAR(100),
	nm_usuario VARCHAR(200),
	cd_CPF VARCHAR(15),
	cd_telefone VARCHAR(15),
	nm_senha VARCHAR(128),
	img_usuario LONGBLOB,
	vl_hora_trabalho DECIMAL(10, 2),
	cd_link_curriculo TEXT,
	ic_ativo BOOl,
	ds_experiencia_usuario TEXT,
	ds_usuario TEXT,
	cd_avaliacao DECIMAL(10, 2),
	cd_tipo_usuario INT,
	cd_auth_recover VARCHAR (100),
	cd_genero INT,
	cd_situacao_usuario INT,
	CONSTRAINT pk_usuario PRIMARY KEY (nm_email_usuario),
	CONSTRAINT fk_usuario_tipo_usuario FOREIGN KEY (cd_tipo_usuario)
	REFERENCES tipo_especializacao (cd_tipo_especializacao),
	CONSTRAINT fk_usuario_auth_recover FOREIGN KEY (cd_auth_recover)
	REFERENCES auth_recover (cd_auth_recover),
	CONSTRAINT fk_usuario_genero FOREIGN KEY (cd_genero)
	REFERENCES tipo_genero (cd_genero),
	CONSTRAINT fk_usuario_tipo_situacao_usuario FOREIGN KEY (cd_situacao_usuario)
	REFERENCES tipo_situacao_usuario (cd_situacao_usuario)
);
/*Adiministradores*/
insert into usuario values('thiagofranciscojosefigueiredo-75@adiministrador.com','Thiago Francisco José Figueiredo','264.346.238-60','(13)98292-8428',md5('123'),null,null,null,null,null,null,null,1,null,null,null);
insert into usuario values('giovannaisabelleisabelamoura-86@adiministrador.com','Giovanna Isabelle Isabela Moura','307.335.868-48','(13)99576-6640',md5('123'),null,null,null,null,null,null,null,1,null,null,null);
/*Clientes*/
insert into usuario values('jenniferevelyngomes@gmail.com','Jennifer Evelyn Gomes','546.433.708-31','(13)98377-3877',md5('123'),null,null,null,null,null,null,null,2,123,null,null);
insert into usuario values('flaviapriscilamarianasilveira@gmail.com','Flávia Priscila Mariana Silveira','585.753.038-56','(13)99525-1833',md5('123'),null,null,null,null,null,null,null,2,234,null,null);
insert into usuario values('oosvaldocarlosdarosa@live.ie','Osvaldo Carlos da Rosa','797.113.308-14','(13)99906-6970',md5('123'),null,null,null,null,null,null,null,2,345,null,null);
insert into usuario values('hadassabetinaviana-80@scuderiagwr.com.br','Hadassa Betina Viana','853.819.898-06','(13)99812-4922',md5('123'),null,null,null,null,null,null,null,2,456,null,null);
insert into usuario values('emilyantoniadaianearagao@gmail.com','Emily Antônia Daiane Aragão','099.801.308-06','(13)99308-2893',md5('123'),null,null,null,null,null,null,null,2,null,null,null);
insert into usuario values('raquelAurelia@gmail.com','Raquel Aureliana Souza','233.319.868-23','(13)99342-4872',md5('123'),null,null,null,null,null,null,null,2,null,null,null);
insert into usuario values('mauriciorodolfo@gamil.com','Mauricio Rodolfo Santos','578.345.335-16','(13)99456-2123',md5('123'),null,null,null,null,null,null,null,2,null,null,null);
/*Cuidadores*/
insert into usuario values('oliverbrunoluccanunes@gmail.com','Oliver Bruno Lucca Nunes','629.105.768-92','(13)99751-0239',md5('123'),null,7.5,'https://CurriculoDoOliver.com.br', true,'3 anos no hospital','Olá meu nome é Oliver e eu amo exercer o meu trabalho',4,3,null,1,1);
insert into usuario values('brunastellaflaviadepaula@gmail.com','Bruna Stella Flávia de Paula','311.072.008-65','(13)98838-6063',md5('123'),null,7.5,'https://CurriculoDaBruna.com.br',true,'Autônomo há 4 anos','Me chamo Bruna e adoro cuidar de outras pessoas',5,3,null,2,1);
insert into usuario values('verabarbarajoanaaparicio@gmail.com','Vera Bárbara Joana Aparício','896.735.338-30','(13)98445-2141',md5('123'),null,7.5,'https://CurriculoDaVera.com.br', true,'2 anos na SAIDSP','Sou a Vera e amo ajudar pessoas que precisam de cuidados especiais',2.4,3,null,2,1);
insert into usuario values('rayssaelainevanessacosta-84@.com','Rayssa Elaine Vanessa Costa','018.471.618-71','(13)99643-0218',md5('123'),null,30.0,'https://CurriculoDaRayssa.com.br',true,'6 meses na HomeAngels','Me chamo Rayssa e tenho muita disposição para ajudar idosos',4.5,3,null,2,1);
insert into usuario values('flaviabeneditamilenamelo@gmail.com','Flávia Benedita Milena Melo','516.150.178-28','(13)99611-4631',md5('123'),null,50.0,'https://CurriculoDaFlavia.com.br',true,'Trabalhei por 3 meses na Vidas Home Care','Estou iniciando na área e com a experiência que eu tenho posso dizer que amo o que faço',3.0,3,null,2,1);
insert into usuario values('matheusraimundofarias@gmail.com','Matheus Raimundo Farias','829.441.818-82','(13)98375-6008',md5('123'),null,45.0,'https://CurriculoDoMatheus.com.br',true,'1 ano na Union HomeCare','Gosto bastante de trabalhar como cuidador de idosos',3.5,3,null,1,1);
insert into usuario values('sarahelainealiciaribeiro@gmail.com','Sarah Elaine Alícia Ribeiro','426.701.408-66','(13)98279-0959',md5('123'),null,50.0,'https://CurriculoDaSarah.com.br',true,'5 anos no Hospital Guilherme Alvaro','Olá me chamo Sarah e carrego uma bagagem muito vasta como cuidadora de idosos e posso dizer que eu amo trabalhar nesta área',1.5,3,null,2,1);

CREATE TABLE especializacao_usuario
(
	cd_tipo_especializacao INT,
	nm_email_usuario VARCHAR(100),
	CONSTRAINT pk_especializacao_usuario PRIMARY KEY (cd_tipo_especializacao, nm_email_usuario),
	CONSTRAINT fk_especializacao_usuario_tipo_especializacao FOREIGN KEY (cd_tipo_especializacao)
	REFERENCES tipo_especializacao (cd_tipo_especializacao),
	CONSTRAINT fk_especializacao_usuario_usuario FOREIGN KEY (nm_email_usuario)
	REFERENCES usuario (nm_email_usuario)
);

insert into especializacao_usuario values (1, 'oliverbrunoluccanunes@gmail.com');
insert into especializacao_usuario values (1, 'brunastellaflaviadepaula@gmail.com');
insert into especializacao_usuario values (1, 'verabarbarajoanaaparicio@gmail.com');
insert into especializacao_usuario values (1, 'rayssaelainevanessacosta-84@.com');
insert into especializacao_usuario values (1, 'flaviabeneditamilenamelo@gmail.com');
insert into especializacao_usuario values (1, 'matheusraimundofarias@gmail.com');
insert into especializacao_usuario values (1, 'sarahelainealiciaribeiro@gmail.com');
insert into especializacao_usuario values (2, 'oliverbrunoluccanunes@gmail.com');
insert into especializacao_usuario values (3, 'brunastellaflaviadepaula@gmail.com');
insert into especializacao_usuario values (3, 'flaviabeneditamilenamelo@gmail.com');
insert into especializacao_usuario values (4, 'verabarbarajoanaaparicio@gmail.com');

CREATE TABLE disponibilidade
(
	dt_disponibilidade DATE,
	hr_inicio_disponibilidade TIME,
	hr_fim_disponibilidade TIME,
	nm_email_usuario VARCHAR(100),
	CONSTRAINT pk_disponibildiade PRIMARY KEY (dt_disponibilidade, hr_inicio_disponibilidade, hr_fim_disponibilidade),
	CONSTRAINT fk_disponibilidade_usuario FOREIGN KEY (nm_email_usuario)
	REFERENCES usuario (nm_email_usuario)
);

insert into disponibilidade values('2020-08-20','08:00:00','18:00:00','oliverbrunoluccanunes@gmail.com');
insert into disponibilidade values('2020-07-16','07:00:00','19:00:00','oliverbrunoluccanunes@gmail.com');

insert into disponibilidade values('2020-08-20','09:00:00','16:00:00','brunastellaflaviadepaula@gmail.com');
insert into disponibilidade values('2020-07-12','20:00:00','07:00:00','brunastellaflaviadepaula@gmail.com');

insert into disponibilidade values('2020-08-20','07:00:00','20:00:00','verabarbarajoanaaparicio@gmail.com');
insert into disponibilidade values('2020-07-22','07:00:00','20:00:00','verabarbarajoanaaparicio@gmail.com');

insert into disponibilidade values('2020-08-20','18:00:00','23:59:00','rayssaelainevanessacosta-84@.com');
insert into disponibilidade values('2020-08-21','00:00:00','02:00:00','rayssaelainevanessacosta-84@.com');

insert into disponibilidade values('2020-08-20','14:00:00','22:00:00','flaviabeneditamilenamelo@gmail.com');
insert into disponibilidade values('2020-07-13','10:00:00','20:00:00','flaviabeneditamilenamelo@gmail.com');
insert into disponibilidade values('2020-11-03','10:00:00','22:00:00','flaviabeneditamilenamelo@gmail.com');

insert into disponibilidade values('2020-08-20','05:00:00','22:00:00','matheusraimundofarias@gmail.com');
insert into disponibilidade values('2020-11-03','07:00:00','17:00:00','matheusraimundofarias@gmail.com');
insert into disponibilidade values('2020-11-02','07:00:00','17:00:00','matheusraimundofarias@gmail.com');

insert into disponibilidade values('2020-08-20','13:30:00','22:00:00','sarahelainealiciaribeiro@gmail.com');
insert into disponibilidade values('2020-08-20','08:00:00','20:00:00','sarahelainealiciaribeiro@gmail.com');

CREATE TABLE tipo_advertencia
(
	cd_tipo_advertencia INT,
	nm_tipo_advertencia VARCHAR(150),
	CONSTRAINT pk_tipo_advertencia PRIMARY KEY (cd_tipo_advertencia)
);

insert into tipo_advertencia values (1, 'Agressão');
insert into tipo_advertencia values (2, 'Roubo');
insert into tipo_advertencia values (3, 'Atraso Recorrente'); 

CREATE TABLE advertencia
(
	cd_advertencia INT,
	ds_advertencia TEXT,
	dt_inicio_advertencia DATE,
	dt_fim_advertencia DATE,
	nm_email_usuario VARCHAR(100),
	nm_email_usuario_admin VARCHAR(100),
	cd_tipo_advertencia INT,
	CONSTRAINT pk_advertencia PRIMARY KEY (cd_advertencia),
	CONSTRAINT fk_advertencia_tipo_advertencia FOREIGN KEY (cd_tipo_advertencia)
	REFERENCES tipo_advertencia (cd_tipo_advertencia),
	CONSTRAINT fk_advertencia_usuario FOREIGN KEY (nm_email_usuario)
	REFERENCES usuario (nm_email_usuario),
	CONSTRAINT fk_advertencia_admin FOREIGN KEY (nm_email_usuario)
	REFERENCES usuario (nm_email_usuario)
);

insert into advertencia values (1, 'Houve várias reclamações de agressão','2020-08-11', '2020-08-12','oliverbrunoluccanunes@gmail.com', 'thiagofranciscojosefigueiredo-75@adiministrador.com',1);
insert into advertencia values (2, 'Houve reclamações de roubo','2020-08-11', '2020-08-12','brunastellaflaviadepaula@gmail.com', 'thiagofranciscojosefigueiredo-75@adiministrador.com',2);
insert into advertencia values (3, 'Houve várias reclamções de atrasos recorrentes','2020-08-20', '2020-08-27','brunastellaflaviadepaula@gmail.com', 'giovannaisabelleisabelamoura-86@adiministrador.com',3);

CREATE TABLE tipo_necessidade_paciente
(
	cd_tipo_necessidade_paciente INT,
	nm_tipo_necessidade_paciente VARCHAR(45),
	ds_tipo_necessidade_paciente TEXT,
	CONSTRAINT pk_tipo_necessidade_paciente PRIMARY KEY (cd_tipo_necessidade_paciente)
);

insert into tipo_necessidade_paciente values(1,'Medicação','O idoso precisa receber medicações periodicas');
insert into tipo_necessidade_paciente values(2,'Banho','O idoso não consegue toamr banho sozinho e precisa de um acompanhante');

CREATE TABLE paciente
(
	cd_paciente INT,
	nm_paciente VARCHAR(200),
	ds_paciente TEXT,
	cd_CEP_paciente VARCHAR(12),
	nm_cidade_paciente VARCHAR(200),
	nm_bairro_cidade VARCHAR(200),
	nm_rua_paciente VARCHAR(200),
	cd_num_paciente INT,
	nm_uf_paciente VARCHAR(200),
	nm_complemento_paciente VARCHAR(100),
	nm_email_usuario VARCHAR(100),
	img_paciente LONGBLOB,
	CONSTRAINT pk_paciente PRIMARY KEY (cd_paciente),
	CONSTRAINT fk_paciente_usuario FOREIGN KEY (nm_email_usuario)
	REFERENCES usuario (nm_email_usuario)
);

insert into paciente values(1,'Nicole Sebastiana Malu Moraes', 'Nicole adora passar o tempo conversando', '11510-310', 'Cubatão', 'Vila Couto', 'Av. Dr. Fernando Costa', '264', 'SP', null, 'jenniferevelyngomes@gmail.com', null);
insert into paciente values(2,'Márcia Nina Rafaela Duarte', 'A Márcia ama jogar truco para se distrair', '11510-310', 'Cubatão', 'Vila Couto', 'Av. Dr. Fernando Costa', '273', 'SP', null, 'jenniferevelyngomes@gmail.com', null);
insert into paciente values(3,'Tânia Rita Sophie Ferreira', 'Tânia gosta de assistir televisão', '11330-560', 'São Vicente', 'Vila Margarida', 'R. José Vicente de Barros', '549', 'SP', null, 'flaviapriscilamarianasilveira@gmail.com', null);
insert into paciente values(4,'Luzia Fabiana Jéssica de Paula', 'Luiza não é muito de conversar', '11050-230', 'Santos', 'Encruzilhada', 'R. Dr. Guedes Coelho', '1028', 'SP', null, 'oosvaldocarlosdarosa@live.ie', null);
insert into paciente values(5,'Rebeca Giovana Vera Almada', 'Rebeca se recusa a tomar rémedio', '11070-180', 'Santos', 'Vila Belmiro', 'R. Delfino Stockler de Lima', '127', 'SP', 'Fundos', 'emilyantoniadaianearagao@gmail.com', null);
insert into paciente values(6,'André Nathan Souza', 'André gosta de assistir futebol', '11525-050', 'Cubatão', 'Vila Nova', 'Praça Francisco da Silva Cardoso', '50', 'SP', 'Sobrado', 'hadassabetinaviana-80@scuderiagwr.com.br', null);
insert into paciente values(7,'Marcia Maria Dolores', 'Marcia não gosta de tomar banho', '11050-260', 'Santos', 'Encruzilhada', 'R. Dr. Leôncio Rezende Filho', '789', 'SP', 'Apartamento 24', 'raquelAurelia@gmail.com', null);
insert into paciente values(8,'Jenivalda Radelia', 'Jenivalda gosta de conversar', '11370-530', 'São Vicente', 'Jardim Guassu', 'R. Francisco Silva Santos', '164', 'SP', 'Apartamento 12', 'mauriciorodolfo@gamil.com', null);
insert into paciente values(9,'Astolfo Rodrigues da Silva', 'Astolfo gosta de assistir Silvio Santos', '11330-560', 'São Vicente', 'Vila Margarida', 'R. José Vicente de Barros', '548', 'SP', null, 'flaviapriscilamarianasilveira@gmail.com', null);

CREATE TABLE necessidade_paciente
(
	cd_paciente INT,
	cd_tipo_necessidade_paciente INT,
	CONSTRAINT pk_necessidade_paciente PRIMARY KEY (cd_paciente, cd_tipo_necessidade_paciente),
	CONSTRAINT fk_necessidade_paciente_paciente FOREIGN KEY (cd_paciente)
	REFERENCES paciente (cd_paciente),
	CONSTRAINT fk_necessidade_paciente_tipo_necessidade_paciente FOREIGN KEY (cd_tipo_necessidade_paciente)
	REFERENCES tipo_necessidade_paciente (cd_tipo_necessidade_paciente)
);

insert into necessidade_paciente values(1,1);
insert into necessidade_paciente values(1,2);
insert into necessidade_paciente values(2,1);
insert into necessidade_paciente values(2,2);
insert into necessidade_paciente values(3,1);
insert into necessidade_paciente values(4,2);
insert into necessidade_paciente values(5,1);
insert into necessidade_paciente values(6,2);
insert into necessidade_paciente values(7,1);
insert into necessidade_paciente values(8,2);
insert into necessidade_paciente values(9,1);

CREATE TABLE tipo_status_servico
(
	cd_status_servico INT,
	nm_status_servico VARCHAR(45),
	CONSTRAINT pk_tipo_status_servico PRIMARY KEY (cd_status_servico)
);

insert into tipo_status_servico values(1,'Em Andamento');
insert into tipo_status_servico values(2,'Pendente');
insert into tipo_status_servico values(3,'Finalizado');
insert into tipo_status_servico values(4,'Cancelado');
insert into tipo_status_servico values(5,'Confirmado');

CREATE TABLE avaliacao
(
	cd_avaliacao INT,
	nm_avaliacao VARCHAR(45),
	CONSTRAINT pk_avaliacao PRIMARY KEY (cd_avaliacao)
);

insert into avaliacao values(1,'Excelente');
insert into avaliacao values(2,'Bom');
insert into avaliacao values(3,'Regular');
insert into avaliacao values(4,'Ruim');
insert into avaliacao values(5,'Pessimo');

CREATE TABLE servico
(
	cd_servico INT,
	dt_inicio_servico DATE,
	hr_inicio_servico TIME,
	dt_fim_servico DATE,
	hr_fim_servico TIME,
	cd_CEP_servico VARCHAR(12),
	nm_cidade_servico VARCHAR(200),
	nm_bairro_servico VARCHAR(200),
	nm_rua_servico VARCHAR(200),
	cd_num_servico INT,
	nm_uf_servico VARCHAR(200),
	nm_complemento_servico VARCHAR(100),
	hr_checkin_servico TIME,
	dt_checkin_servico DATE,
	hr_checkout_servico TIME,
	dt_checkout_servico DATE,
	cd_geolocalizacao_entrada VARCHAR(200),
	nm_email_usuario VARCHAR(100),
	nm_email_usuario_cuidador VARCHAR(100),
	cd_avaliacao INT,
	cd_status_servico INT,
	cd_paciente INT,
	CONSTRAINT pk_servico PRIMARY KEY (cd_servico),
	CONSTRAINT fk_servico_usuario FOREIGN KEY (nm_email_usuario)
	REFERENCES usuario (nm_email_usuario),
	CONSTRAINT fk_servico_usuario_cuidador FOREIGN KEY (nm_email_usuario_cuidador)
	REFERENCES usuario (nm_email_usuario),
	CONSTRAINT fk_servico_avaliacao FOREIGN KEY (cd_avaliacao)
	REFERENCES avaliacao (cd_avaliacao),
	CONSTRAINT fk_servico_tipo_status_servico FOREIGN KEY (cd_status_servico)
	REFERENCES tipo_status_servico (cd_status_servico), 
	CONSTRAINT fk_servico_paciente FOREIGN KEY (cd_paciente)
	REFERENCES paciente (cd_paciente)
);

/*Serviços Finalizados*/
insert into servico values(1,'2020-07-12','06:00:00','2020-07-12','18:00:00','11510-310','Cubatão','Vila Couto','Av. Dr. Fernando Costa','264','SP',null,'06:00:00','2020-07-12','18:00:00','2020-07-12','-23.883080;-46.426811','jenniferevelyngomes@gmail.com','brunastellaflaviadepaula@gmail.com',1,3,1);
insert into servico values(2,'2020-07-13','10:30:00','2020-07-13','16:00:00','11050-260','São Vicente','Vila Margarida','R. Dr. Leôncio Rezende Filho','789','SP',null,'11:00:00','2020-07-13','16:00:00','2020-07-13','-23.969978;-46.404580','raquelAurelia@gmail.com','flaviabeneditamilenamelo@gmail.com',3,3,7);
insert into servico values(3,'2020-07-16','07:00:00','2020-07-16','18:00:00','11510-310','São Vicente','Esplanada dos Barreiros','R. Av. Dr. Fernando Costa','273','SP',null,'07:00:00','2020-07-16','18:00:00','2020-07-16','-23.962699;-46.408979','jenniferevelyngomes@gmail.com','oliverbrunoluccanunes@gmail.com',2,3,2);
insert into servico values(4,'2020-07-16','08:00:00','2020-07-16','20:00:00','11370-530','São Vicente','Jardim Guassu','R. Francisco Silva Santos','164','SP',null,'08:00:00','2020-07-16','20:00:00','2020:07:16','-23.951948;-46.374941','mauriciorodolfo@gamil.com','sarahelainealiciaribeiro@gmail.com',2,3,8);
insert into servico values(16,'2020-04-20','08:00:00','2020-08-20','17:00:00','05024-000','São Paulo','Pompeia','R. Barão do Bananal','1328','SP',null,'08:30:00','2020-08-20',null,null,'-23.535457;-46.690143','jenniferevelyngomes@gmail.com','oliverbrunoluccanunes@gmail.com',null,3,2);
insert into servico values(17,'2020-02-20','07:00:00','2020-08-20','19:00:00','01137-040','São Paulo','Barra Funda','R. Padre Luís Alves de Siqueira','21','SP',null,'07:00:00','2020-08-20',null,null,'-23.521763;-46.656568','flaviapriscilamarianasilveira@gmail.com','verabarbarajoanaaparicio@gmail.com',null,3,3);
insert into servico values(18,'2020-07-20','05:00:00','2020-08-20','17:00:00','11050-230','Santos','Encruzilhada','R. Dr. Guedes Coelho','1028','SP',null,'06:00:00','2020-08-20',null,null,'-23.954143;-46.330406','oosvaldocarlosdarosa@live.ie','matheusraimundofarias@gmail.com',null,3,4);
insert into servico values(19,'2020-01-20','12:00:00','2020-08-20','20:00:00','11070-180','Santos','Vila Belmiro','R. Delfino Stockler de Lima','127','SP',null,'12:00:00','2020-08-20',null,null,'-23.949846;-46.342424','emilyantoniadaianearagao@gmail.com','rayssaelainevanessacosta-84@.com',null,3,5);
insert into servico values(20,'2020-02-20','09:00:00','2020-08-20','16:00:00','11525-050','Cubatão','Vila Nova','Praça Francisco da Silva Cardoso','50','SP',null,'09:00:00','2020:08:20',null,null,'-23.893013;-46.429228','hadassabetinaviana-80@scuderiagwr.com.br','brunastellaflaviadepaula@gmail.com',null,3,6);
insert into servico values(21,'2020-06-11','15:20:00','2020-06-11','18:00:00','11533-040','Cubatão','Jardim Casqueiro','R. Estados Unidos','530','SP',null,'15:22:00','2020:06:11',null,null,'-23.893013;-46.429228','hadassabetinaviana-80@scuderiagwr.com.br','flaviabeneditamilenamelo@gmail.com',null,3,6);
insert into servico values(22,'2020-07-15','10:00:00','2020-07-15','14:30:00','11330-060','São Vicente','Parque Bitaru','R. Osvaldo Eduardo','49','SP',null,'10:01:00','2020:07:15',null,null,'-23.893013;-46.429228','emilyantoniadaianearagao@gmail.com','flaviabeneditamilenamelo@gmail.com',null,3,5);

/*Serviços Em Andamento*/
insert into servico values(5,'2020-08-20','08:00:00','2020-08-20','17:00:00','05024-000','São Paulo','Pompeia','R. Barão do Bananal','1328','SP',null,'08:30:00','2020-08-20',null,null,'-23.535457;-46.690143','jenniferevelyngomes@gmail.com','oliverbrunoluccanunes@gmail.com',null,1,2);
insert into servico values(6,'2020-08-20','07:00:00','2020-08-20','19:00:00','01137-040','São Paulo','Barra Funda','R. Padre Luís Alves de Siqueira','21','SP',null,'07:00:00','2020-08-20',null,null,'-23.521763;-46.656568','flaviapriscilamarianasilveira@gmail.com','verabarbarajoanaaparicio@gmail.com',null,1,3);
insert into servico values(7,'2020-08-20','05:00:00','2020-08-20','17:00:00','11050-230','Santos','Encruzilhada','R. Dr. Guedes Coelho','1028','SP',null,'06:00:00','2020-08-20',null,null,'-23.954143;-46.330406','oosvaldocarlosdarosa@live.ie','matheusraimundofarias@gmail.com',null,1,4);
insert into servico values(8,'2020-08-20','12:00:00','2020-08-20','20:00:00','11070-180','Santos','Vila Belmiro','R. Delfino Stockler de Lima','127','SP',null,'12:00:00','2020-08-20',null,null,'-23.949846;-46.342424','emilyantoniadaianearagao@gmail.com','rayssaelainevanessacosta-84@.com',null,1,5);
insert into servico values(9,'2020-08-20','09:00:00','2020-08-20','16:00:00','11525-050','Cubatão','Vila Nova','Praça Francisco da Silva Cardoso','50','SP',null,'09:00:00','2020-08-20',null,null,'-23.893013;-46.429228','hadassabetinaviana-80@scuderiagwr.com.br','brunastellaflaviadepaula@gmail.com',null,1,6);
/*Serviços Pendentes*/
insert into servico values(10,'2020-11-30','10:00:00','2020-08-30','22:00:00','11050-260','Santos','Encruzilhada','R. Dr. Leôncio Rezende Filho','789','SP',null,null,null,null,null,'-23.956151;-46.324515','raquelAurelia@gmail.com','flaviabeneditamilenamelo@gmail.com',null,2,7);
insert into servico values(11,'2020-11-30','07:00:00','2020-08-30','17:00:00','11310-210','São Vicente','Centro','R. do Colégio','485','SP',null,null,null,null,null,'-23.970107;-46.392474','oosvaldocarlosdarosa@live.ie','matheusraimundofarias@gmail.com',null,2,4);
insert into servico values(12,'2020-12-14','07:00:00','2020-10-14','10:00:00','11533-040','Cubatão','Jardim Casqueiro','Av. Brasil','500','SP',null,null,null,null,null,'-23.970107;-46.392474','oosvaldocarlosdarosa@live.ie','flaviabeneditamilenamelo@gmail.com',null,2,4);
insert into servico values(13,'2020-12-14','12:00:00','2020-10-14','15:00:00','11333-040','Cubatão','Jardim Casqueiro','Av. Brasil','505','SP',null,null,null,null,null,'-23.970107;-46.392474','oosvaldocarlosdarosa@live.ie','flaviabeneditamilenamelo@gmail.com',null,2,4);
insert into servico values(14,'2020-12-30','12:00:00','2020-10-30','15:00:00','11333-040','Cubatão','Jardim Casqueiro','Av. Brasil','505','SP',null,null,null,null,null,'-23.970107;-46.392474','oosvaldocarlosdarosa@live.ie','flaviabeneditamilenamelo@gmail.com',null,2,4);
/*Serviços Cancelados*/
insert into servico values(15,'2020-07-22','07:00:00','2020-07-22','20:00:00','11370-110','São Vicente','Vila Cascatinha','R. Ribeiro Júnior','96','SP',null,null,null,null,null,'-23.960448;-46.378629','oosvaldocarlosdarosa@live.ie','verabarbarajoanaaparicio@gmail.com',null,4,4);

CREATE TABLE tipo_ocorrencia
(
	cd_tipo_ocorrencia INT,
	nm_tipo_ocorrencia VARCHAR(45),
	CONSTRAINT pk_tipo_ocorrencia PRIMARY KEY (cd_tipo_ocorrencia)
);

insert into tipo_ocorrencia values (1, 'Agressão');
insert into tipo_ocorrencia values (2, 'Roubo');
insert into tipo_ocorrencia values (3, 'Atraso Recorrente');

CREATE TABLE ocorrencia 
(
	cd_ocorrencia INT,
	ds_ocorrencia TEXT,
	dt_ocorrencia DATE,
	nm_email_usuario VARCHAR(100),
	cd_servico INT,
	cd_tipo_ocorrencia INT,
	CONSTRAINT pk_ocorrencia PRIMARY KEY (cd_ocorrencia),
	CONSTRAINT fk_ocorrencia_usuario FOREIGN KEY (nm_email_usuario)
	REFERENCES usuario (nm_email_usuario),
	CONSTRAINT fk_ocorrencia_servico FOREIGN KEY (cd_servico)
	REFERENCES servico (cd_servico),
	CONSTRAINT fk_ocorrencia_tipo_ocorrencia FOREIGN KEY (cd_tipo_ocorrencia)
	REFERENCES tipo_ocorrencia (cd_tipo_ocorrencia)
);

insert into ocorrencia values (1, 'O Cuidador roubou meu dinheiro', current_date(), 'jenniferevelyngomes@gmail.com',1,2);
