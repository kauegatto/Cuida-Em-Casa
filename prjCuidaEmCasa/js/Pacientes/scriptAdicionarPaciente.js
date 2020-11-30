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

    function readFileAsync(file){

		return new Promise((resolve, reject) => {

			var fReader = new FileReader();

			fReader.onloadend = () => {
				resolve(fReader.result);
			};

			fReader.onerror = reject; 

			fReader.readAsDataURL(file);

		})

	}

	async function processFile(){

		let resultado;

		try{

			let file = document.getElementById('uploadImgUsuario').files[0];

			resultado = await readFileAsync(file);

		}
		catch(err)
		{
			console.log('Tinha que ter selecionado a imagem mas tudo bem');
			console.log(resultado);
			//scriptPacientes();
		}

		var retorno;
		var imgPaciente;

		if (resultado == "" || resultado == undefined) 
		{
			imgPaciente = null;
		}
		else
		{
			imgPaciente = resultado;
		}

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

	    $.post("../../lib/libAdicionarPaciente.aspx",  { cdNecessidade: localStorage.getItem('necessidadeEscolhida'), imagemPaciente: imgPaciente, usuarioLogado : usuarioLogado,nome:nome, uf:uf, descricao: descricao, CEP:CEP, cidade : cidade,bairro: bairro,rua:rua, numero:numero, complemento:complemento  }, function (retorno) {
	       
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


	}

	processFile();

};
