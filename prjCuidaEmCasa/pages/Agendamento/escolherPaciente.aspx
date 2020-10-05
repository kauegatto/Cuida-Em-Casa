<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="escolherPaciente.aspx.cs" Inherits="prjCuidaEmCasa.pages.Agendamento.AgendamentoMain" %>

<!DOCTYPE>

<html>
<head runat="server">
    <title>Cuida em Casa</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="../../css/estiloGeral.css" rel="stylesheet" type="text/css" />
    <link href="../../css/agendamento/estiloPaciente.css" rel="stylesheet" type="text/css" />
	<link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Archivo:wght@400;700&display=swap" rel="stylesheet">
    <script src="../../js/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="../../js/scriptPaciente.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
      <div class="estruturaGeral">
		<header class="header">
			<div class="areaLogo">
				<a href="#"><img src="../../img/logoSimples.png"  class="logo"></a>
			</div>
			<div class="areaTituloGeral">
				<h1 class="tituloGeral">Agendar</h1>
			</div>
		</header>
		<main class="conteudoGeral">
			<h3 class="tituloConteudo">Para qual paciente será esse serviço ?</h3>
            <div id="wrapper-paciente"></div>
			
				<a href="confirmarEndereco.aspx"><button class="btnProximo" type="button">Próximo</button></a>
			
		</main>
		<footer class="footer">
			<nav>
				<div class="menuGeral">
					<div class="areaIcone">
						<img src="../../img/icones/iconeCalendario.png">
					</div>
					<span style="margin-left: 20px; bottom: 20px;">Agendar</span>
				</div>
				<div class="menuGeral">
					<div class="areaIcone">
						<img src="../../img/icones/iconeServico.png">
					</div>
					<span style="margin-left: 18px; bottom: 20px;">Serviços</span>
				</div>
				<div class="menuGeral">
					<div class="areaIcone">
						<img src="../../img/icones/iconePaciente.png">
					</div>
					<span style="margin-left: 19px; bottom: 20px;">Pacientes</span>
				</div>
				<div class="menuGeral">
					<div class="areaIcone">
						<img src="../../img/icones/iconeConfiguracoes.png">
					</div>
					<span style="margin-left: 7px; bottom: 20px;">Configuração</span>
				</div>
			</nav>
		</footer>
	</div>
    </form>
</body>
</html>
