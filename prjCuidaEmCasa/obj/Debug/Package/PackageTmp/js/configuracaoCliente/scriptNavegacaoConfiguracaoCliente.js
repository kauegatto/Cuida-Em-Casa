import scriptAtualizarSenha from './scriptAtualizarSenha.js'

$(document).ready(function () {

    $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
    });
    
	$('#headerComum').addClass("visivel");

	$('.emailUsuario').html(localStorage.getItem('usuarioLogado'));        

	$(document).on("click", "#conta", function(){

		$("#wrapper-ConfiguracaoInicial").css("display","none");

		$("#wrapper-LoginSeguranca").addClass("visivel");
		$('#headerComum').addClass("visivel");

		//scriptAgendaClienteAgendado();
	    $('.tituloGeral').html("Conta");

	    $('.emailUsuario').html('Login e Segurança');

	    $('.emailDadosConta').html(localStorage.getItem('usuarioLogado'));

	    $('#telefoneUsuario').html(localStorage.getItem('telefoneUsuario'));

	});

	$(document).on("click", "#alterarSenha", function(){

	    $(".visivel").each(function (i, obj) {
	           $(this).removeClass("visivel");
	    });

		$("#wrapper-LoginSeguranca").css("display","none");

		$("#wrapper-AtualizarSenha").addClass("visivel");
		$('#headerComum').addClass("visivel");

		$('.tituloGeral').html('Alterar Senha');

	});

	$('.btnAtualizarSenha').click(function(){

		scriptAtualizarSenha($('#txtSenhaAtual').val(),$('#txtNovaSenha').val(),$('#txtConfirmarSenha').val(), localStorage.getItem('usuarioLogado'));

	});

	$(document).on("click", "#sair", function(){
        localStorage.Clear();
		window.location.href = "../index.html";

	});

});