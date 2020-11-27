import scriptPacientes from './scriptPacientes.js';

export default function scriptAdicionarPaciente() {

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

	var retorno;
	var imgPaciente;
	var descricao = $('#txtAdicionarDescricaoPaciente').val();
	var CEP =  $('#txtAdicionarCEPPaciente').val();
	var cidade =  $('#txtAdicionarCidadePaciente').val();
	var bairro = $('#txtAdicionarBairroPaciente').val();
	var rua = $('#txtAdicionarRuaPaciente').val();
	var nome = $('#txtAdicionarNomePaciente').val();
	var uf = "SP";
	var numero = $('#txtAdicionarNumeroPaciente').val();
	var complemento = $('#txtAdicionarComplementoPaciente').val();
	var usuarioLogado =  localStorage.getItem("usuarioLogado");
	
	var input = document.getElementById("uploadImgUsuario");
	var fReader = new FileReader();
	fReader.readAsDataURL(input.files[0]);
	fReader.onloadend = function(event){
		//console.log(event.target.result);
		imgPaciente = event.target.result;
		localStorage.setItem('imagemPaciente', imgPaciente);
		//$('.areaImagemPaciente').css('background-image', 'url(' + localStorage.getItem('imagemPaciente') + ')');
	}

    $.post("../../lib/libAdicionarPaciente.aspx",  { cdNecessidade: localStorage.getItem('necessidadeEscolhida'), imagemPaciente: localStorage.getItem('imagemPaciente'), usuarioLogado : usuarioLogado,nome:nome, uf:uf, descricao: descricao, CEP:CEP, cidade : cidade,bairro: bairro,rua:rua, numero:numero,complemento:complemento  }, function (retorno) {
       
        if (!retorno) {
        	//$('#wrapper-paciente').html("ERRO NO RETORNO");
        	alertIonic('Houve um erro!');
        }

		else if (retorno == "") {
			$('#wrapper-paciente').html("Você ainda não tem pacientes cadastrados!");
			return;
		}
        else if (retorno == "usuarioIncorreto"){window.location.href = "../index.html"}
		else{
	        alertIonic("O(a) cliente " + nome + " foi adicionado(a) com sucesso!");
	        //console.log(retorno);	
	        scriptPacientes();      
	    }
    });
};
