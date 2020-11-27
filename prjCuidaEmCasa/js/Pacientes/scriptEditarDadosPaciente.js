import scriptPacientes from './scriptPacientes.js';

export default function scriptEditarDadosPaciente() {

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

	async function processFile() {

		try{

			let file = document.getElementById('uploadImgUsuario').files[0];

			let resultado = await readFileAsync(file);

			console.log(resultado);

			var descricao = $('#txtAlterarDescricaoPaciente').val();
			var CEP =  $('#txtAlterarCEPPaciente').val();
			var cidade =  $('#txtAlterarCidadePaciente').val();
			var bairro = $('#txtAlterarBairroPaciente').val();
			var rua = $('#txtAlterarRuaPaciente').val();
			var nome = $('#txtAlterarNomePaciente').val();
			var uf = "SP";
			var numero = $('#txtAlterarNumeroPaciente').val();
			var complemento = $('#txtAlterarComplementoPaciente').val();
			var cdPaciente = localStorage.getItem("cdPaciente");
			var cdNecessidades;

			if (localStorage.getItem('necessidadeEscolhida') == "") 
			{
				cdNecessidades = $('#txtAlterarNecessidadePaciente').val();
			}
			else
			{
				cdNecessidades = localStorage.getItem('necessidadeEscolhida');
			}

			$('#necessidadeEscolhida').html("");

			$.post("../../lib/libAtualizarDadosPaciente.aspx",  { necessidadesPaciente: cdNecessidades, imagem: resultado, cd: cdPaciente, nome: nome, uf: uf, descricao: descricao, CEP: CEP, cidade: cidade, bairro: bairro, rua:rua, numero:numero, complemento:complemento }, function (retorno) {

				if (!retorno) {
					$('#wrapper-paciente').html("ERRO NO RETORNO");
					console.log(retorno);
				}
				else if (retorno == "") {
					$('#wrapper-paciente').html("Você ainda não tem pacientes cadastrados!");
					return;
					console.log(retorno);
				}
				else if (retorno == "usuarioIncorreto"){window.location.href = "../index.html"}
				else{
					console.log(retorno);	
					scriptPacientes();      
					//alert("Os dados do(a) cliente "+nome+" foram alterados com sucesso!");
				}
			});

		}
		catch(err) { 
			console.log(err);
		}

	} 

	processFile();

};
