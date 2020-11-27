import scriptEnviarEmailUsuario from './scriptEnviarEmailUsuario.js';
import scriptEnviarCodigoRecuperacao from './scriptEnviarCodigoRecuperacao.js';
import scriptAlterarSenha from './scriptAlterarSenha.js';

$(document).ready(function(){

	$('#btnEnviarEmail').click(function(){

		$('#wrapper-EsqueceuSenhaInicio').css('display', 'none');
		$('#wrapper-CodigoRecuperarSenha').css('display', 'block');

		localStorage.setItem('emailUsuario', $('#txtEmailRecuperarSenha').val());

		if (localStorage.getItem('emailUsuario') != "") 
		{
			scriptEnviarEmailUsuario(localStorage.getItem('emailUsuario'));
		}
		else
		{
			alert('digite um email');
		}
		
	});

	$('#btnEnviarCodigoRecuperacao').click(function(){

		if ($("#txtCodigoRecuperacao").val() != "") 
		{
			scriptEnviarCodigoRecuperacao($("#txtCodigoRecuperacao").val(), localStorage.getItem('emailUsuario'));
		}
		else
		{
			alert('digite um codigo');
		}

	});

	$('#btnEnviarNovaSenhaRecuperacao').click(function(){

		scriptAlterarSenha();

	});

});