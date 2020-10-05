<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="alterarEndereco.aspx.cs" Inherits="prjCuidaEmCasa.pages.Agendamento.alterarEndereco" %>

<!DOCTYPE html>
<html>
<head>
	<title>Cuida em Casa</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" type="text/css" href="../../css/estiloGeral.css">
	<link rel="stylesheet" type="text/css" href="../../css/agendamento/estiloConfirmacaoEndereco.css">
	<link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Archivo:wght@400;700&display=swap" rel="stylesheet">
    <script src="../../js/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="../../js/scriptAlterarEndereco.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="estruturaGeral">
		<header class="header">
			<div class="areaLogo">
				<a href="confirmarEndereco.aspx"><img src="../../img/icones/iconeVoltar.png" class="iconeVoltar"></a>
			</div>
			<div class="areaTituloGeral">
				<h1 class="tituloGeral" style="text-align: center; margin-left: 0px;">Confirmação de Endereço</h1>
			</div>
		</header>
		<main class="conteudoGeral">
			<div class="areaIconeCasa">
				<img src="../../img/icones/endereco/iconeCasa.png" class="iconeCasa">
			</div>
			<div class="areaFormulario">
				<div class="areaDados">
					<span class="tituloDados">CEP:</span>
					<input type="text" name="CEP" id="cep" class="txtDados" style="width: 42%;">
					<span class="tituloDados" style="margin-left: 10px;">UF:</span>
					<select class="txtDados" id="uf" name="UF" style="width: 15%; margin-left: 0px;">
                        <option value=""></option>
					    <option value="SP">SP</option>
					    <option value="SC">SC</option>
					    <option value="RJ">RJ</option>
					    <option value="MG">MG</option>
					</select>
				</div>
				<div class="areaDados">
					<span class="tituloDados">Rua:</span>
					<input type="text" name="Rua" id="rua" class="txtDados" style="margin-left: 23.5px;">
				</div>
				<div class="areaDados" >
					<span class="tituloDados">Nº</span>
					<input type="text" name="Numero" id="num" class="txtDados" style="width:60px; margin-left: 42px;">
					<span class="tituloDados" style="margin-left: 10px;">Comp:</span>
					<input type="text" name="Complemento" id="comp" class="txtDados" style="width: 89px; margin-left: 5px;">
				</div>
				<div class="areaDados">
					<span class="tituloDados">Bairro:</span>
					<input type="text" name="Bairro" id="bairro" class="txtDados" style="margin-left: 7px;">
				</div>
				<div class="areaDados">
					<span class="tituloDados" >Cidade:</span>
					<input type="text" name="Cidade" id="cidade" class="txtDados" style="margin-left: 0px;">
				</div>
				<a href="agendamento.html">
					<button class="btnConfirmar"><a href="escolherDataServico.aspx">Confirmar</a></button>
				</a>
			</div>
		</main>
		<footer class="footer">
			<nav>
				<div class="menuGeral">
					<div class="areaIcone">
						<img src="../../img/icones/iconeCalendario.png">
					</div>
					<span style="margin-left: 20px;">Agendar</span>
				</div>
				<div class="menuGeral">
					<div class="areaIcone">
						<img src="../../img/icones/iconeServico.png">
					</div>
					<span style="margin-left: 18px;">Serviços</span>
				</div>
				<div class="menuGeral">
					<div class="areaIcone">
						<img src="../../img/icones/iconePaciente.png">
					</div>
					<span style="margin-left: 19px;">Pacientes</span>
				</div>
				<div class="menuGeral">
					<div class="areaIcone">
						<img src="../../img/icones/iconeConfiguracoes.png">
					</div>
					<span style="margin-left: 7px; ">Configuração</span>
				</div>
			</nav>
		</footer>
	</div>
    </form>
</body>
</html>
