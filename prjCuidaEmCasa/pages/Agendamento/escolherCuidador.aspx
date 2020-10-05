<%@ Page Language="C#"  CodeBehind="escolherCuidador.aspx.cs" AutoEventWireup="true" Inherits="prjCuidaEmCasa.pages.Agendamento.escolherCuidador" %>

<!DOCTYPE html>
<html>
<head>
	<title>Cuida em Casa</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" type="text/css" href="../../css/estiloGeral.css">
	<link rel="stylesheet" type="text/css" href="../../css/agendamento/estiloCuidador.css">
	<link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Archivo:wght@400;700&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <script src="../../js/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="../../js/scriptCuidador.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="estruturaGeral">
		<header class="header" style="height: 158px; z-index: 1;">
			<div class="areaLogo">
				<a href="#"><img src="../../img/icones/iconeVoltar.png" class="iconeVoltar"></a>
			</div>
			<div class="areaTituloGeral">
				<h1 class="tituloGeral" style="margin: 0 auto; margin-top: 45px; width: 100%;">Cuidadores Disponíveis</h1>
			</div>
			
		</header>
		<main class="conteudoGeral">
            <asp:Literal ID="litCuidadores" runat="server"></asp:Literal>
			<%--<div class="areaCuidador">
				<div class="areaImagemCuidador" style="background-image: url('../../img/imgCuidador1.jfif');"></div>
				<div class="areaInfoCuidador">
					<h3>Marcelo Castro</h3>
					<div class="hora">
						<img src="../../img/icones/cuidador/iconeCifrao.png" class="iconeCifrao">
						<span style="margin-left: 9px;">70 / Hora</span>
					</div>
					<div class="especializacao">
						<img src="../../img/icones/cuidador/iconeMaleta.png" class="iconeMaleta">
						<span>Fisioterapeuta</span>
					</div>
				</div>
			</div>
			<div class="areaCuidador">
				<div class="areaImagemCuidador" style="background-image: url('../../img/imgCuidador2.jpg');"></div>
				<div class="areaInfoCuidador">
					<h3>Daniel da Silva</h3>
					<div class="hora">
						<img src="../../img/icones/cuidador/iconeCifrao.png" class="iconeCifrao">
						<span style="margin-left: 9px;">50 / Hora</span>
					</div>
					<div class="especializacao">
						<img src="../../img/icones/cuidador/iconeMaleta.png" class="iconeMaleta">
						<span>Fisioterapeuta</span>
					</div>
				</div>
			</div>
			<div class="areaCuidador">
				<div class="areaImagemCuidador" style="background-image: url('../../img/imgCuidador3.jfif');"></div>
				<div class="areaInfoCuidador">
					<h3>Marcelly Santos</h3>
					<div class="hora">
						<img src="../../img/icones/cuidador/iconeCifrao.png" class="iconeCifrao">
						<span style="margin-left: 9px;">60 / Hora</span>
					</div>
					<div class="especializacao">
						<img src="../../img/icones/cuidador/iconeMaleta.png" class="iconeMaleta">
						<span>Fisioterapeuta</span>
					</div>
				</div>
			</div>
			<div class="areaCuidador">
				<div class="areaImagemCuidador" style="background-image: url('../../img/imgCuidador4.jpg');"></div>
				<div class="areaInfoCuidador">
					<h3>Wagner Freitas</h3>
					<div class="hora">
						<img src="../../img/icones/cuidador/iconeCifrao.png" class="iconeCifrao">
						<span style="margin-left: 9px;">60 / Hora</span>
					</div>
					<div class="especializacao">
						<img src="../../img/icones/cuidador/iconeMaleta.png" class="iconeMaleta">
						<span>Fisioterapeuta</span>
					</div>
				</div>
			</div>
			<div class="areaCuidador">
				<div class="areaImagemCuidador" style="background-image: url('../../img/imgCuidador5.jfif');"></div>
				<div class="areaInfoCuidador">
					<h3>Henrique Matias</h3>
					<div class="hora">
						<img src="../../img/icones/cuidador/iconeCifrao.png" class="iconeCifrao">
						<span style="margin-left: 9px;">55 / Hora</span>
					</div>
					<div class="especializacao">
						<img src="../../img/icones/cuidador/iconeMaleta.png" class="iconeMaleta">
						<span>Fisioterapeuta</span>
					</div>
				</div>
			</div>--%>

        <button class="btnProximo"> <a href="infoCuidador.aspx"> Próximo	</a> </button>
		
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
