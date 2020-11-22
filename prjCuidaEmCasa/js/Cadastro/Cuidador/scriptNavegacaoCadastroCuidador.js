import scriptCriarContaCuidador from './scriptCriarContaCuidador.js';

$(document).ready(function(){

	var imgCuidador;

	$.post("../../lib/libEspecializacaoCuidador.aspx", function(retorno){

		if (retorno == "erro") 
		{
			console.log('deu erro na libEspecializacaoCuidador');
		}
		else
		{
			$('#especializacaoCuidador').html(retorno);
		}

	});

	$('#txtTelefoneCuidador').mask('(00) 00000-0000');
	$('#txtCPFCuidador').mask('000.000.000-00');

	$(document).on("click", "#btnProximo1", function(){

		if ($('#txtNomeCuidador').val() != "") {
			localStorage.setItem('nomeCuidador', $('#txtNomeCuidador').val());	
		}
		else
		{
			alert('digite o seu nome');
			return;
		}

		if ($('#txtEmailCuidador').val() != "") {
			localStorage.setItem('emailCuidador', $('#txtEmailCuidador').val());
		}
		else
		{
			alert('digite o seu email');
			return;
		}

		if ($('#txtTelefoneCuidador').val() != "") {
			localStorage.setItem('telefoneCuidador', $('#txtTelefoneCuidador').val());
		}
		else
		{
			alert('digite o seu telefone');
			return;
		}

		$("#wrapper-PrimeiroCadastroCuidador").css("display", "none");
		$("#wrapper-SegundoCadastroCuidador").css("display", "block");
		
	});

	$(document).on("click", "#btnProximo2", function(){

		if ($('#txtCPFCuidador').val() != "") {

			localStorage.setItem('cpfCuidador', $('#txtCPFCuidador').val());
		}
		else
		{
			alert('digite o seu cpf');
			return;
		}

		if ($('#txtSenha').val() != "" && $('#txtConfirmarSenha').val() != "") 
		{
			if ($('txtSenha').val() == $('txtConfirmarSenha').val()) 
			{
				localStorage.setItem('senhaCuidador', $('#txtSenha').val());
			}
			else
			{
				alert('as senhas estao diferentes');
				return;
			}
		}
		else
		{
			alert('digite a senha !');
			return;
		}

		$("#wrapper-SegundoCadastroCuidador").css("display", "none");
		$("#wrapper-TerceiroCadastroCuidador").css("display", "block");

	});


	$(document).on("click", "#btnProximo3", function(){

		if ($('#uploadImg').val() != "") 
		{
			var input = document.getElementById("uploadImg");
			var fReader = new FileReader();
			fReader.readAsDataURL(input.files[0]);
			fReader.onloadend = function(event){
			   //console.log(event.target.result);
			   imgCuidador = event.target.result;
			   localStorage.setItem('imgCuidador', imgCuidador);
			}		
		}
		else
		{
			alert('coloca img pf ae mano');
			return;
		}

		if ($('#generoCuidador').val() != "") 
		{
			localStorage.setItem('generoCuidador', $('#generoCuidador').val());
		}
		else
		{
			alert('selecione um genero');
			return;
		}

		if ($('#txtCurriculo').val() != "") 
		{
			localStorage.setItem('linkCurriculo', $('#txtCurriculo').val());
		}
		else
		{
			alert('digite um curriculo');
			return;
		}

		if ($('#txtDescricao').val() != "") 
		{
			localStorage.setItem('descricaoCuidador', $('#txtDescricao').val());	
		}
		else
		{
			alert('Digite uma descrição');
			return;
		}

		$("#wrapper-TerceiroCadastroCuidador").css("display", "none");
		$("#wrapper-QuartoCadastroCuidador").css("display", "block");
	
	});

	$(document).on("click", "#btnCadastrar", function(){

		if ($('#especializacaoCuidador'.val() != "")) 
		{
			localStorage.setItem('especializacaoCuidador', $('#especializacaoCuidador').val());
		}
		else
		{
			alert('selecione uma especializacao');
			return;
		}

		if ($('#txtValorHora').val() != "") 
		{
			localStorage.setItem('valorHora', $('#txtValorHora').val());
		}
		else
		{
			alert('digite um valor hora');
			return;
		}

		if ($('#txtDescricaoEspecializacao').val() != "") 
		{
			localStorage.setItem('descricaoEspecializacao', $('#txtDescricaoEspecializacao').val());
		}
		else
		{
			alert('digite uma descricao para sua especializacao');
			return;
		}

		scriptCriarContaCuidador();

		//localStorage.setItem('usuarioLogado', $('#txtEmailCuidador').val());
		//window.location.href = "";
		
	});


});