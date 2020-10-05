<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="escolherDataServico.aspx.cs" Inherits="prjCuidaEmCasa.pages.Agendamento.escolherDataServico" %>

<!DOCTYPE html>
<html>
<head>
	<title>Cuida em Casa</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" type="text/css" href="../../css/estiloGeral.css">
	<link rel="stylesheet" type="text/css" href="../../css/agendamento/estiloAgendamento.css">
	<link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap" rel="stylesheet"/>
	<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet"/>
	<link href="https://fonts.googleapis.com/css2?family=Archivo:wght@400;700&display=swap" rel="stylesheet"/>

    <script src="../../js/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="../../js/scriptDataHora.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="estruturaGeral">
		<header class="header" style="margin-bottom: 14px;">
			<div class="areaLogo">
				<a href="endereco.html"><img src="../../img/icones/iconeVoltar.png" class="iconeVoltar"></a>
			</div>
			<div class="areaTituloGeral">
				<h1 class="tituloGeral" style="text-align: center; margin-left: 5px; margin-top: 35px">Definição de data e horário</h1>
			</div>
		</header>
		<main class="conteudoGeral">
			
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
