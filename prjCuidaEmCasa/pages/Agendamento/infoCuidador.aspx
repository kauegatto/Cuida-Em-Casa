<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="infoCuidador.aspx.cs" Inherits="prjCuidaEmCasa.pages.Agendamento.infoCuidador" %>

<!DOCTYPE html>
<html>
<head>
	<title>Cuida em Casa</title>
	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link href="../../css/estiloGeral.css" rel="stylesheet" type="text/css" >
	<link rel="stylesheet" type="text/css" href="../../css/agendamento/estiloInfoCuidador.css>
	<link rel="stylesheet" type="text/css" href="../../css/agendamento/estiloCuidador.css">
	<link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Archivo:wght@400;700&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script src="../../js/scriptInfoCuidador.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="estruturaGeral">

		<header class="header" style="margin-bottom: 14px;">
			<div class="areaLogo">
				<a href="escolherCuidador.aspx"><img src="../../img/icones/iconeVoltar.png" class="iconeVoltar"></a>
			</div>
			<div class="areaTituloGeral">
				<h1 class="tituloGeral" style="margin-left: 5px; margin-top: 45px; width: 223px;">Cuidador Escolhido</h1>
			</div>
		</header>
		<main class="conteudoGeral">
			<h3 class="tituloConteudo" style="width: 231px; margin-left: 80px;">Informações do Cuidador</h3>
			<div class="areaCuidador">
				<div class="areaImagemCuidador" style="background-image: url('../../img/imgCuidador1.jfif');"></div>
				<div class="areaInfoCuidador">
					<h3 id="nm_cuidador">Marcelo Castro</h3>
					<div class="hora">
						<img src="../../img/icones/cuidador/iconeCifrao.png" class="iconeCifrao">
						<span style="margin-left: 9px;" id="vl_hora_cuidador">70 / Hora</span>
					</div>
					<div class="especializacao">
						<img src="../../img/icones/cuidador/iconeMaleta.png" class="iconeMaleta">
						<span id="nm_tipo_especializacao_cuidador">Fisioterapeuta</span>
					</div>
				</div>
                <div class="invi">PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+</div>
			</div>
			<div class="areaInfoDados">
				<div class="areaInfoDetalhes">
					<div class="tituloInformacao">Experiência</div><div class="btnExpandir">-</div>
					<div class="detalheInformacao"  id="nm_experiencia_cuidador"></div>
				</div>
			</div>
			<div class="areaInfoDados">
				<div class="areaInfoDetalhes">
					<div class="tituloInformacao">Gênero</div><div class="btnExpandir">-</div>
					<div class="detalheInformacao" id="nm_genero_cuidador"></div>
				</div>
			</div>
			<div class="areaInfoDados">
				<div class="areaInfoDetalhes">
					<div class="tituloInformacao">Sobre mim</div><div class="btnExpandir">-</div>
					<div class="detalheInformacao" id="ds_cuidador"></div>
				</div>
			</div>
			<button class="btnProximo" style="left: 27.5%"><a href="finalizarServico.aspx">Próximo</a></button>
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
