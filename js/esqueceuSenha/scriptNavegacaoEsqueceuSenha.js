import scriptEnviarEmailUsuario from './scriptEnviarEmailUsuario.js';
import scriptEnviarCodigoRecuperacao from './scriptEnviarCodigoRecuperacao.js';
import scriptAlterarSenha from './scriptAlterarSenha.js';

$(document).ready(function(){

	function alertIonic(text) {

        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

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
			alertIonic('Digite um e-mail!');
		}
		
	});

	$('#btnEnviarCodigoRecuperacao').click(function(){

		if ($("#txtCodigoRecuperacao").val() != "") 
		{
			scriptEnviarCodigoRecuperacao($("#txtCodigoRecuperacao").val(), localStorage.getItem('emailUsuario'));
		}
		else
		{
			alertIonic('Digite um código!');
		}

	});

	$('#btnEnviarNovaSenhaRecuperacao').click(function(){

		scriptAlterarSenha();

	});

});