import scriptCriarContaClinte from './scriptCriarContaClinte.js';

$(document).ready(function(){

	$(document).on("click", "#btnProximo", function(){

		// criar validacao

		localStorage.setItem("nomeCliente", $("#txtNomeCliente").val());
		localStorage.setItem("emailCliente", $("#txtEmailCliente").val());
		localStorage.setItem("telefoneCliente", $("#txtTelefoneCliente").val());

		$("#wrapper-CadastroPrimeiro").css("display","none");

        $("#wrapper-CadastroSegundo").addClass("visivel");
	});

	$(document).on("click", "#btnCadastrar", function(){

		localStorage.setItem("cpfCliente", $("#txtCPF").val());
		localStorage.setItem("senhaCliente", $("#txtSenha").val());
		localStorage.setItem("confirmarSenhaCliente", $("#txtConfirmarSenha").val());

		scriptCriarContaCliente();

		window.location.href = "../../pages/cliente/atendimento.html";

	});


});