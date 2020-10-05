<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="finalizarServico.aspx.cs" Inherits="prjCuidaEmCasa.pages.Agendamento.finalizarServico" %>

<!DOCTYPE html>
<html>
<head>
	<title>Cuida em Casa</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" type="text/css" href="../../css/estiloGeral.css">
	<link rel="stylesheet" type="text/css" href="../../css/agendamento/estiloConfirmacaoCuidador.css">
	<link rel="stylesheet" type="text/css" href="../../css/agendamento/estiloCuidador.css">
	<link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Archivo:wght@400;700&display=swap" rel="stylesheet">
    <script src="../../js/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="../../js/finalizarServico.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="estruturaGeral">
		<header class="header" style="margin-bottom: 14px;">
			<div class="areaLogo">
				<a href="infoCuidador.aspx"><img src="../../img/icones/iconeVoltar.png" class="iconeVoltar"></a>
			</div>
			<div class="areaTituloGeral">
				<h1 class="tituloGeral" style="margin-left: 5px; margin-top: 45px; width: 223px;">Cuidador Escolhido</h1>
			</div>
		</header>
		<main class="conteudoGeral">
			<h3 class="tituloConteudo" style="width: 72px; margin-left: 150px;">Resumo</h3>
			<div class="areaResumo">
				<div class="areaDadosServico">
					<div class="areaImagemCuidador" style="background-image: url('../../img/imgCuidador1.jfif'); margin-top: 8px;"></div>
					<h3 class="nomeCuidador" id="nomeCuidador"></h3>
				</div>
				<div class="areaDadosServico" style="height: 60px;">
					<img src="../../img/icones/agendamento/iconeCalendario.png" class="iconeCalendario">
					<span class="dataServico" id="dataFinal"></span>
				</div>
				<div class="areaDadosServico" style="height: 50px;">
					<img src="../../img/icones/agendamento/iconeRelogio.png" class="iconeRelogio">
					<span class="horaServico" id="horaFinal"></span>
				</div>
				<div class="areaDadosServico" style="height: 40px;">
					<img src="../../img/icones/cuidador/iconeCrifaoPequeno.png" class="iconeCifrao" >
					<span class="valorServico" id="valorFinal"></span>
				</div>
				<div class="areaDadosServico" style="height: 70px;">
					<img src="../../img/icones/endereco/iconeCasa.png" class="iconeCasa1" >
					<h3 class="enderecoServico" id="endereco"></h3>
				</div>
				
			</div>
			<button class="btnProximo" style="left: 27.5%">Finalizar</button>
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
