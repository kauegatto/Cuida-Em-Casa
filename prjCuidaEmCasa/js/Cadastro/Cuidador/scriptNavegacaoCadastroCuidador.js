import scriptCriarContaCuidador from './scriptCriarContaCuidador.js';

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

	var imgCuidador;

	$.post("../../../lib/libEspecializacaoCuidador.aspx", function(retorno){

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
			alertIonic('Digite o seu nome!');
			return;
		}

		if ($('#txtEmailCuidador').val() != "") {
			localStorage.setItem('emailCuidador', $('#txtEmailCuidador').val());
		}
		else
		{
			alertIonic('Digite o seu email!');
			return;
		}

		if ($('#txtTelefoneCuidador').val() != "") {
			localStorage.setItem('telefoneCuidador', $('#txtTelefoneCuidador').val());
		}
		else
		{
			alertIonic('Digite o seu telefone!');
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
			alertIonic('Digite o seu CPF!')
			return;
		}

		if ($('#txtSenha').val() != "" && $('#txtConfirmarSenha').val() != "") 
		{
			if ($('#txtSenha').val() == $('#txtConfirmarSenha').val()) 
			{
				localStorage.setItem('senhaCuidador', $('#txtSenha').val());
			}
			else
			{
				alertIonic('As senhas estão diferentes!');
				return;
			}
		}
		else
		{
			alertIonic('Digite sua senha!');
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
			alertIonic('Selecione uma imagem!');
			return;
		}

		if ($('#generoCuidador').val() != "") 
		{
			localStorage.setItem('generoCuidador', $('#generoCuidador').val());
		}
		else
		{
			alertIonic('Selecione um genero!');
			return;
		}

		if ($('#txtCurriculo').val() != "") 
		{
			localStorage.setItem('linkCurriculo', $('#txtCurriculo').val());
		}
		else
		{
			alertIonic('Digite o seu link!');
			return;
		}

		if ($('#txtDescricao').val() != "") 
		{
			localStorage.setItem('descricaoCuidador', $('#txtDescricao').val());	
		}
		else
		{
			alertIonic('Digite uma descrição!');
			return;
		}

		$("#wrapper-TerceiroCadastroCuidador").css("display", "none");
		$("#wrapper-QuartoCadastroCuidador").css("display", "block");
	
	});

	var c = 0;
	var cdEspecializacao = "";
/*
	$('#especializacaoCuidador').change(function(){

		if (c > 0) {
			$('#especializacaoEscolhida').html($('#especializacaoEscolhida').html() + ", " + $('#especializacaoCuidador option:selected').html());
			$('#especializacaoCuidador').prop('disabled', true);			
  			cdEspecializacao += ";" + $('#especializacaoCuidador').val() ;
  			console.log(cdEspecializacao);
  			var id = $('#especializacaoCuidador').children(":selected").attr("id");
  			$("#"+id).prop('disabled',true);
		}
		else
		{
			c++;
			$('#especializacaoEscolhida').html($('#especializacaoCuidador option:selected').html());
			$('#especializacaoCuidador').prop('disabled', true);
  			cdEspecializacao += $('#especializacaoCuidador').val();
  			console.log(cdEspecializacao);
  			var id = $('#especializacaoCuidador').children(":selected").attr("id");
  			$("#"+id).prop('disabled',true);
		}
  			
  		localStorage.setItem('especializacaoCuidador', cdEspecializacao);
	

	});*/

	$(document).on("click", "#addEspecializacao", function(){

		if (c > 0) {
			$('#especializacaoEscolhida').html($('#especializacaoEscolhida').html() + ", " + $('#especializacaoCuidador option:selected').html());
			//$('#especializacaoCuidador').prop('disabled', true);			
  			cdEspecializacao += ";" + $('#especializacaoCuidador').val() ;
  			console.log(cdEspecializacao);
  			var id = $('#especializacaoCuidador').children(":selected").attr("id");
  			$("#"+id).prop('disabled',true);
		}
		else
		{
			c++;
			$('#especializacaoEscolhida').html($('#especializacaoCuidador option:selected').html());
			//$('#especializacaoCuidador').prop('disabled', true);
  			cdEspecializacao += $('#especializacaoCuidador').val();
  			console.log(cdEspecializacao);
  			var id = $('#especializacaoCuidador').children(":selected").attr("id");
  			$("#"+id).prop('disabled',true);
		}
  			
  		localStorage.setItem('especializacaoCuidador', cdEspecializacao);

	});

	$(document).on("click", "#btnCadastrar", function(){

		//if ($('#especializacaoCuidador'.val() != "")) 
		//{
			//localStorage.setItem('especializacaoCuidador', $('#especializacaoEscolhida').html());
		//}
		//else
		//{
		//	alert('selecione uma especializacao');
		//	return;
		//}

		if ($('#txtValorHora').val() != "") 
		{
			localStorage.setItem('valorHora', $('#txtValorHora').val());
		}
		else
		{
			alertIonic('Digite um valor hora!');
			return;
		}

		if ($('#txtDescricaoEspecializacao').val() != "") 
		{
			localStorage.setItem('descricaoEspecializacao', $('#txtDescricaoEspecializacao').val());
		}
		else
		{
			alertIonic('Digite uma descrição para sua especialização');
			return;
		}

		scriptCriarContaCuidador();

		//localStorage.setItem('usuarioLogado', $('#txtEmailCuidador').val());
		//window.location.href = "";

	});


});