﻿import scriptCriarContaCuidador from './scriptCriarContaCuidador.js';

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

	$('#txtTelefoneCuidador').mask('(00) 0000-0000');
	$('#txtCPFCuidador').mask('000.000.000-00');

	$(document).on("click", "#btnProximo1", function(){

		$("#wrapper-PrimeiroCadastroCuidador").css("display", "none");
		$("#wrapper-SegundoCadastroCuidador").css("display", "block");

		localStorage.setItem('nomeCuidador', $('#txtNomeCuidador').val());
		localStorage.setItem('emailCuidador', $('#txtEmailCuidador').val());
		localStorage.setItem('telefoneCuidador', $('#txtTelefoneCuidador').val());
		
	});

	$(document).on("click", "#btnProximo2", function(){

		$("#wrapper-SegundoCadastroCuidador").css("display", "none");
		$("#wrapper-TerceiroCadastroCuidador").css("display", "block");

		localStorage.setItem('cpfCuidador', $('#txtTelefoneCuidador').val());
		localStorage.setItem('senhaCuidador', $('#txtSenha').val());

	});


	$(document).on("click", "#btnProximo3", function(){

		$("#wrapper-TerceiroCuidador").css("display", "none");
		$("#wrapper-QuartoCadastroCuidador").css("display", "block");

		if ($('#uploadImg').val() != "") 
		{
			var input = document.getElementById("uploadImg");
			var fReader = new FileReader();
			fReader.readAsDataURL(input.files[0]);
			fReader.onloadend = function(event){
			   // console.log(event.target.result);
			   imgCuidador = event.target.result;
			   localStorage.setItem('imgCuidador', imgCuidador);
			}
		}
		else
		{
			alert('coloca img pf ae mano');
			return;
		}

		localStorage.setItem('generoCuidador', $('#generoCuidador').val());
		localStorage.setItem('linkCurriculo', $('#txtCurriculo').val());
		localStorage.setItem('descricaoCuidador', $('#txtDescricao').val());
		
	});

	$(document).on("click", "#btnCadastrar", function(){

		localStorage.setItem('especializacaoCuidador', $('#especializacaoCuidador').val());
		localStorage.setItem('valorHora', $('#txtValorHora').val());
		localStorage.setItem('descricaoEspecializacao', $('#txtDescricaoEspecializacao').val());

		scriptCriarContaCuidador();

		//localStorage.setItem('usuarioLogado', $('#txtEmailCuidador').val());
		//window.location.href = "";
	});


});