call alterarSenha('123', 'renanStopa@gmail.com');
call gerarOcorrencia('O cuidador agrediu o paciente', 'jenniferevelyngomes@gmail.com', 5, 1);
call buscarPacientes('flaviapriscilamarianasilveira@gmail.com');
call buscarEnderecoPaciente(3);
call alterarEnderecoPaciente('11330-560', 'São Vicente', 'Vila Margarida', 'R. José Vicente de Barros', '549', 'SP', null, 3);
call buscarCuidadores('2020-08-30', '11:00:00', '16:59:00');
call buscarCuidadoresVirarDia('2020-07-12', '22:00:00', '02:00:00');
call filtrarCuidadores('2020-08-20','09:00:00','16:00:00', true, false, false, true, 1, null, null, 2);
call filtrarCuidadoresVirarDia('2020-07-12','20:00:00','06:00:00', true, false, false, true, 1, null, null, 2);
call cuidadorEscolhido('matheusraimundofarias@gmail.com');
call agendarServico(32,'2020-06-19','07:00:00','12:00:00','11533-040','Cubatão', 'Jardim Casqueiro', 'R. Estados Unidos', '530', 'SP', null, 'oosvaldocarlosdarosa@live.ie','verabarbarajoanaaparicio@gmail.com',4);
call agendarServicoVirarDia(33,'2020-06-19','07:00:00','12:00:00','11533-040','Cubatão', 'Jardim Casqueiro', 'R. Estados Unidos', '530', 'SP', null, 'oosvaldocarlosdarosa@live.ie','verabarbarajoanaaparicio@gmail.com',4);
call listarServicos('oosvaldocarlosdarosa@live.ie', 1);
call proxCodigo();
call proxCodigoOcorrencia();
call cadastrarCuidador('renanstopa@gmail.com', 'Renan Lopes Stopa', '625.615.345-93', '(13)99654-1367', md5('123'), 15.00, 
'https://CurriculoDoRenan.com.br', '5 anos de trabalho de cuidadoria na Santa Casa de Santos', 
'Me chamo Renan, estou nessa trabalho de cuidadoria a bastante tempo e faço isso com muita paixão', 1);
call cadastrarEspecializacoes(2, 'renanstopa@gmail.com');
call listarServicosFuturos('flaviabeneditamilenamelo@gmail.com');
call listarServicosProximos('flaviabeneditamilenamelo@gmail.com');
call listarServicosFinalizadosAntigos('flaviabeneditamilenamelo@gmail.com');
call listarServicosFinalizadosRecentes('flaviabeneditamilenamelo@gmail.com');
call servicoSelecionado(5);



