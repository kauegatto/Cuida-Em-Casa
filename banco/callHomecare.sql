/* PROCEDURES GERAIS */

call verificarLogin('flaviapriscilamarianasilveira@gmail.com', '123');
call alterarSenha('123', 'renanStopa@gmail.com');
call gerarOcorrencia(3, 'O cuidador agrediu o paciente', 'reinaldosouza@gmail.com', 5, 2);
call verificarSenha('mauriciorodolfo@gamil.com','123');
call cadastroCuidador('renanstopa@gmail.com', 'Renan Lopes Stopa', '(13) 99618-5415', '525.481.918.93', '123', 'data:image/jpeg;base64,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',
1, 'https://curriculodorenan.com', 'Meu nome é Renan e cuidar dos outros é minha paixão', '10.00', 'Cursei fisioterapia por 5 anos da Unisantos');
call codigoRecuperarSenha('mauriciorodolfo@gamil.com');
call verificarCodigoRecuperacao('dougreisrrs@gmail.com', 999);
call inserirAuthRecover('brunastellaflaviadepaula@gmail.com',1233);

/* PROCEDURES DO CLIENTE */

call buscarPacientes('flaviapriscilamarianasilveira@gmail.com');
call buscarEnderecoPaciente(3);
call alterarEnderecoPaciente('11330-560', 'São Vicente', 'Vila Margarida', 'R. José Vicente de Barros', '549', 'SP', null, 3);
call buscarCuidadores('2020-12-14', '16:00:00', '17:00:00');
call buscarCuidadoresVirarDia('2020-07-12', '22:00:00', '02:00:00');
call filtrarCuidadores('2020-12-14','12:00:00','14:00:00', 1, 0, 0, 0, 1, null, null, null);
call filtrarCuidadoresVirarDia('2020-07-12','20:00:00','06:00:00', 0, 0, 0, 0, null, null, null, null);
call cuidadorEscolhido('flaviabeneditamilenamelo@gmail.com');
call agendarServico(29,'2020-11-20','14:00:00','19:00:00','11533-040','Cubatão', 'Jardim Casqueiro', 'R. Estados Unidos', '530', 'SP', null, 'oosvaldocarlosdarosa@live.ie','flaviapriscilamarianasilveira@gmail.com',4);
call agendarServicoVirarDia(33,'2020-06-19','07:00:00','12:00:00','11533-040','Cubatão', 'Jardim Casqueiro', 'R. Estados Unidos', '530', 'SP', null, 'oosvaldocarlosdarosa@live.ie','verabarbarajoanaaparicio@gmail.com',4);
call agendarServicoAgora(24,'16:00:00', '11533-040','Cubatão', 'Jardim Casqueiro', 'R. Estados Unidos', '530', 'SP', null, 'mauriciorodolfo@gamil.com', 8, 60);
call agendarServicoAgoraVirarDia(29,'02:00:00', '11533-040','Cubatão', 'Jardim Casqueiro', 'R. Estados Unidos', '530', 'SP', null, 'oosvaldocarlosdarosa@live.ie', 8, 10);
call buscarCuidadoresAgora(10.00);
call servicoParaAgora();
call aceitarServicoAgora(26, 'brunastellaflaviadepaula@gmail.com');
call infoServicoAtualCuidador(50);
call listarServicos('oosvaldocarlosdarosa@live.ie', 1);
call proxCodigo();
call proxCodigoOcorrencia();
call buscarPacienteServicoEmAndamento('hadassabetinaviana-80@scuderiagwr.com.br');
call infoServicoAtual(50);
call buscarPacienteServicoEmAndamento(6);
call listarAgendaClienteNaoFoi('flaviapriscilamarianasilveira@gmail.com');
call listarAgendaClienteNaoFoiSelecionado(10);
call listarAgendaClienteJaFoi('flaviapriscilamarianasilveira@gmail.com');
call listarAgendaClienteJaFoiSelecionado(13);
call buscarPacienteServicoEmAndamento('hadassabetinaviana-80@scuderiagwr.com.br');
call infoServicoAtual(50);
call buscarPacienteServicoEmAndamento(6);
call listarAgendaClienteNaoFoi('mauriciorodolfo@gamil.com');
call listarAgendaClienteJaFoi('mauriciorodolfo@gamil.com');
call listarNecessidades();
call atualizarNecessidadesPaciente(2,1);
call deletarNecessidadesPaciente(2);
call listarUltimoCodigoPaciente();
call excluirPaciente(10);
call buscarDadosCliente('mauriciorodolfo@gamil.com');
call atualizarDadosCliente('mauriciorodolfo@gamil.com', 'Douglas Reis', '526.013.418-40', '(13) 33631503');
call verificarPacienteServico(8, '2020-07-16', '08:00:00', '10:00:00');

/* PROCEDURE DO CUIDADOR */

call cadastrarCuidador('renanstopa@gmail.com', 'Renan Lopes Stopa', '625.615.345-93', '(13)99654-1367', '123', 15.00, 
'https://CurriculoDoRenan.com.br', '5 anos de trabalho de cuidadoria na Santa Casa de Santos', 
'Me chamo Renan, estou nessa trabalho de cuidadoria a bastante tempo e faço isso com muita paixão', 2);
call listarServicosAgendados('flaviabeneditamilenamelo@gmail.com');
call cancelarServicoAgendado(10); 
call listarServicosFinalizadosAntigos('brunastellaflaviadepaula@gmail.com');
call listarServicosFinalizadosRecentes('flaviabeneditamilenamelo@gmail.com');
call listarServicosFinalizadosDataAntigos('flaviabeneditamilenamelo@gmail.com', '2020-06-11');
call listarServicosFinalizadosDataRecentes('flaviabeneditamilenamelo@gmail.com', '2020-06-11');
call servicoSelecionado(24);
call servicoSelecionadoAgora(24); 
call marcarCheckin(5);
call marcarCheckout(27);
call tornarDisponivel('flaviabeneditamilenamelo@gmail.com');
call tornarIndisponivel('flaviabeneditamilenamelo@gmail.com');
call listarAvaliacoes('matheusraimundofarias@gmail.com');
call verificarDisponibilidade('flaviabeneditamilenamelo@gmail.com');

/* Calendario / Agenda  */

call disponibilidadePorMes('flaviabeneditamilenamelo@gmail.com', 11);
call buscarServicoAgendadoCuidadorMes('flaviabeneditamilenamelo@gmail.com', 11);
call listarEspecializacao();
call deletarDisponibilidade('2020-11-22', '16:00:00', '19:00:00', 'flaviabeneditamilenamelo@gmail.com');
call disponibilidadePorMes('@gmail.com', 11);
call editarDadosCuidador();
call verificarHorarioDisponibilidade('2020-07-13', '15:00:00', '21:00:00', 'flaviabeneditamilenamelo@gmail.com');

/* PROCEDURE DO ADMINISTRADOR */

call verificarCuidador('renanstopa@gmail.com');
call contratarCuidador('reinaldosouza@gmail.com');
call recusarCuidador('renanstopa@gmail.com');
call listarNumerosOcorrencia();
call situacaoAdvertencia('reinaldosouza@gmail.com');
call definirAdvertencia(4, 'O cuidador Reinaldo recebeu uma advertência de 3 dias por roubo contínuo nos serviços', '2020-08-12', '2020-08-15', 'reinaldosouza@gmail.com', 'thiagofranciscojosefigueiredo-75@adiministrador.com', 2);
call marcarDemissao('reinaldosouza@gmail.com');
call listarCuidadoresContrato();
call infoCuidadorContrato('flaviabeneditamilenamelo@gmail.com');
call listarCuidadores();
call listarOcorrencia('flaviabeneditamilenamelo@gmail.com');
call listarAdvertencia('flaviabeneditamilenamelo@gmail.com');
call infoServicoCuidador('brunastellaflaviadepaula@gmail.com');
call listarOcorrenciaCuidador('flaviabeneditamilenamelo@gmail.com');
call proxCodigoAdvertencia();
call aplicarAdvertencia(4, 'Houve várias reclamções de atrasos recorrentes', 'flaviabeneditamilenamelo@gmail.com', 'giovannaisabelleisabelamoura-86@adiministrador.com',1);
call removerOcorrencia(2);
call listarAdvertenciaCuidador('oliverbrunoluccanunes@gmail.com');
call listarCuidadoresOcorrencia();
call suspenderCuidador('flaviabeneditamilenamelo@gmail.com');
call removerSuspensao('flaviabeneditamilenamelo@gmail.com');
call banirCuidador('flaviabeneditamilenamelo@gmail.com');
call desbanirCuidador('flaviabeneditamilenamelo@gmail.com');
call filtroAdmCuidadores(0, 0, 0, 0, 1, 1, null, null, null, 1.0, 'oli%', 'Masculino');