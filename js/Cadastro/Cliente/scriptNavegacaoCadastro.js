import scriptCriarContaCliente from './scriptCriarContaCliente.js';

$(document).ready(function(){

	$('#txtTelefoneCliente').mask('(00) 00000-0000');
	$('#txtCPF').mask('000.000.000-00');

    function alertaFofo(textoAlerta) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'teste';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = textoAlerta;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

	$(document).on("click", "#btnProximo", function(){

		if ($('#txtNomeCliente').val() == "") 
		{
			alertaFofo('digite o seu nome');
			return;
		}
		else
		{
			localStorage.setItem("nomeCliente", $("#txtNomeCliente").val());
		}

		if ($('#txtEmailCliente').val() == "")
		{
			alertaFofo('digite o seu email');
			return;
		}
		else
		{
			localStorage.setItem("emailCliente", $("#txtEmailCliente").val());
		}
		
		if ($("#txtTelefoneCliente").val() == "") 
		{
			alertaFofo('digite o seu telefone');
			return;
		}
		else
		{
			localStorage.setItem("telefoneCliente", $("#txtTelefoneCliente").val());
		}

		$("#wrapper-CadastroPrimeiro").css("display","none");

        $("#wrapper-CadastroSegundo").addClass("visivel");

	});

	$(document).on("click", "#btnCadastrar", function(){


		if ($("#txtCPF").val() == "") 
		{
			alertaFofo('Digite o seu cpf');
			return;
		}
		else
		{
			localStorage.setItem("cpfCliente", $("#txtCPF").val());
		}

		if ($("#txtSenha").val() == "") 
		{
			alertaFofo('Digite a sua senha');
			return;
		}
		else
		{
			if ($('#txtConfirmarSenha').val() == "") 
			{
				alertaFofo('digite o algo no confirmar senha');
				return;
			}
			else
			{
				if ($('#txtSenha').val() == $('#txtConfirmarSenha').val()) 
				{
					localStorage.setItem("senhaCliente", $("#txtSenha").val());
				}
				else
				{
					alertaFofo('as senhas estao diferentes');
					return;
				}
			}
		}

		scriptCriarContaCliente();
		localStorage.setItem('usuarioLogado', $('#txtEmailCliente').val());

	});


});