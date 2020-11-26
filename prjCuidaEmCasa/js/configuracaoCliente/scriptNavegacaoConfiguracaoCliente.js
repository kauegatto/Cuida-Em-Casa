import scriptAtualizarSenha from './scriptAtualizarSenha.js';
import scriptAtualizarDadosCliente from './scriptAtualizarDadosCliente.js';
import scriptBuscarDadosCliente from './scriptBuscarDadosCliente.js';

$(document).ready(function () {

	$('#txtAlterarCpfCliente').mask('000.000.000-00');
	$('#txtAlterarTelfoneCliente').mask('(00) 00000-0000');

    $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
    });
    
	$('#headerComum').addClass("visivel");

	$('.emailUsuario').html(localStorage.getItem('usuarioLogado'));        

	$(document).on("click", "#conta", function(){

		$(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
   		});
    
		$("#wrapper-ConfiguracaoInicial").css("display","none");
		$("#wrapper-LoginSeguranca").addClass("visivel");
		
		$('#headerComum').removeClass("visivel"); $('#headerComum').css("display","none");

		$('#headerConta').addClass("visivel");
		//scriptAgendaClienteAgendado();

	    $('.emailUsuario').html('Login e Segurança');

	    $('.emailDadosConta').html(localStorage.getItem('usuarioLogado'));

	    $('#telefoneUsuario').html(localStorage.getItem('telefoneUsuario'));

	});

	$(document).on("click", "#headerConta .areaLogo", function(){

		$(".visivel").each(function (i, obj) {
	       $(this).removeClass("visivel");
	    });

		$("#wrapper-ConfiguracaoInicial").css("display","visivel");
		$("#wrapper-ConfiguracaoInicial").addClass("visivel");
		$('#headerComum').addClass("visivel");
		//scriptAgendaClienteAgendado();

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

		$('#headerSenha').addClass("visivel");


	});

	$(document).on("click", "#alterarDados", function(){

		$('#wrapper-LoginSeguranca').css('display', 'none');

		$('#wrapper-AlterarDados').addClass('visivel');

		scriptBuscarDadosCliente();

	});

	$(document).on("click", "#btnSalvarDadosCliente", function(){

		scriptAtualizarDadosCliente();

	});

	$(document).on("click", "#headerSenha .areaLogo", function(){

		$(".visivel").each(function (i, obj) {
	       $(this).removeClass("visivel");
	    });


		$("#wrapper-LoginSeguranca").addClass("visivel");
		
		$('#headerConta').addClass("visivel");

		
		$('#headerComum').removeClass("visivel"); $('#headerComum').css("display","none");

		$('#headerConta').addClass("visivel");
		//scriptAgendaClienteAgendado();

	    $('.emailUsuario').html('Login e Segurança');

	    $('.emailDadosConta').html(localStorage.getItem('usuarioLogado'));

	    $('#telefoneUsuario').html(localStorage.getItem('telefoneUsuario'));

	});

	$('.btnAtualizarSenha').click(function(){

		scriptAtualizarSenha($('#txtSenhaAtual').val(),$('#txtNovaSenha').val(),$('#txtConfirmarSenha').val(), localStorage.getItem('usuarioLogado'));

	});

	$(document).on("click", "#sair", function(){
        localStorage.clear();
		window.location.href = "../index.html";

	});

	
	$(document).on("click", "#alterarDados", function(){

		$('#wrapper-LoginSeguranca').removeClass('visivel');
		$('#wrapper-AlterarDados').addClass('visivel');

		
		

	});


});