/* PROCEDURES GERAIS */

call verificarLogin('flaviapriscilamarianasilveira@gmail.com', '123');
call alterarSenha('123', 'renanStopa@gmail.com');
call gerarOcorrencia(3, 'O cuidador agrediu o paciente', 'reinaldosouza@gmail.com', 5, 2);
call verificarSenha('mauriciorodolfo@gamil.com','123');

/* PROCEDURES DO CLIENTE */

call buscarPacientes('flaviapriscilamarianasilveira@gmail.com');
call buscarEnderecoPaciente(3);
call alterarEnderecoPaciente('11330-560', 'São Vicente', 'Vila Margarida', 'R. José Vicente de Barros', '549', 'SP', null, 3);
call buscarCuidadores(definirAdvertencia, '11:00:00', '16:59:00');
call buscarCuidadoresVirarDia('2020-07-12', '22:00:00', '02:00:00');
call filtrarCuidadores('2020-08-20','09:00:00','16:00:00', 0, 0, 0, 1, 1, null, null, 'Masculino');
call filtrarCuidadoresVirarDia('2020-07-12','20:00:00','06:00:00', true, false, false, true, 1, null, null, 2);
call cuidadorEscolhido('matheusraimundofarias@gmail.com');
call agendarServico(33,'2020-06-19','07:00:00','12:00:00','11533-040','Cubatão', 'Jardim Casqueiro', 'R. Estados Unidos', '530', 'SP', null, 'oosvaldocarlosdarosa@live.ie',4);
call agendarServicoVirarDia(33,'2020-06-19','07:00:00','12:00:00','11533-040','Cubatão', 'Jardim Casqueiro', 'R. Estados Unidos', '530', 'SP', null, 'oosvaldocarlosdarosa@live.ie','verabarbarajoanaaparicio@gmail.com',4);
call agendarServicoAgora(23,'16:00:00', '11533-040','Cubatão', 'Jardim Casqueiro', 'R. Estados Unidos', '530', 'SP', null, 'oosvaldocarlosdarosa@live.ie',4);
call agendarServicoAgoraVirarDia(23,'02:00:00', '11533-040','Cubatão', 'Jardim Casqueiro', 'R. Estados Unidos', '530', 'SP', null, 'oosvaldocarlosdarosa@live.ie',4);
call buscarCuidadoresAgora(10.00);
call listarServicos('oosvaldocarlosdarosa@live.ie', 1);
call proxCodigo();
call proxCodigoOcorrencia();
call buscarPacienteServicoEmAndamento('hadassabetinaviana-80@scuderiagwr.com.br');
call infoServicoAtual(24);
call buscarPacienteServicoEmAndamento(6);
call listarAgendaClienteNaoFoi('flaviapriscilamarianasilveira@gmail.com');
call listarAgendaClienteNaoFoiSelecionado(10);
call listarAgendaClienteJaFoi('flaviapriscilamarianasilveira@gmail.com');
call listarAgendaClienteJaFoiSelecionado(13);
call buscarPacienteServicoEmAndamento('hadassabetinaviana-80@scuderiagwr.com.br');
call infoServicoAtual(24);
call buscarPacienteServicoEmAndamento(6);
call listarAgendaClienteNaoFoi('mauriciorodolfo@gamil.com');
call listarAgendaClienteJaFoi('mauriciorodolfo@gamil.com');

/* PROCEDURE DO CUIDADOR */

call cadastrarCuidador('reinaldosouza@gmail.com', 'Renan Lopes Stopa', '625.615.345-93', '(13)99654-1367', '123', 15.00, 
'https://CurriculoDoRenan.com.br', '5 anos de trabalho de cuidadoria na Santa Casa de Santos', 
'Me chamo Renan, estou nessa trabalho de cuidadoria a bastante tempo e faço isso com muita paixão', 2);
call cadastrarEspecializacoes(1, 'reinaldosouza@gmail.com');
call listarServicosAgendados('flaviabeneditamilenamelo@gmail.com');
call cancelarServicoAgendado(10);
call listarServicosFinalizadosAntigos('flaviabeneditamilenamelo@gmail.com');
call listarServicosFinalizadosRecentes('flaviabeneditamilenamelo@gmail.com');
call listarServicosFinalizadosData('flaviabeneditamilenamelo@gmail.com', '2020-06-11');
call servicoSelecionado(2);
call marcarCheckin(5);
call marcarCheckout(5);
call tornarDisponivel('flaviabeneditamilenamelo@gmail.com');
call tornarIndisponivel('reinaldosouza@gmail.com');

/* PROCEDURE DO ADMINISTRADOR */

call listarSituacaoCuidadores(3);
call verificarCuidador('reinaldosouza@gmail.com');
call contratarCuidador('reinaldosouza@gmail.com');
call listarOcorrencia();
call listarNumerosOcorrencia();
call situacaoAdvertencia('reinaldosouza@gmail.com');
call proxCodigoAdvertencia();
call definirAdvertencia(4, 'O cuidador Reinaldo recebeu uma advertência de 3 dias por roubo contínuo nos sserviços', '2020-08-12', '2020-08-15', 'reinaldosouza@gmail.com', 'thiagofranciscojosefigueiredo-75@adiministrador.com', 2);
call marcarDemissao('reinaldosouza@gmail.com');

select * from servico where cd_paciente = 6;

select * from servico where cd_servico = 33