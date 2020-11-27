export default function scriptEditarDadosCuidador(){

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

		try
		{
			let file = document.getElementById('uploadImgUsuario').files[0];

			let resultado = await readFileAsync(file);

			console.log(resultado);

			var nomeCuidador = $('#txtAlterarNomeCuidador').val();
			//var especializacoesCuidador = localStorage.getItem('especializacoesCuidador');
			var generoCuidador = $('#generoCuidador').val();
			var descricaoCuidador = $('#txtDescricaoCuidador').val()
			var descricaoEspecializacao = $('#txtDescricaoEspecializacao').val();
			var telefoneCuidador = $('#txtAlterarTelefone').val();
			var cpfCuidador = $('#txtAlterarCPF').val();
			var linkCurriculo = $('#txtAlterarLinkCurriculo').val();
			var valorHora = $('#txtAlterarValorHora').val();

			if ($('#txtEspecializacoesCuidador').html() == "") 
			{
				localStorage.setItem('especializacoesCuidador', $('#especializacoesCuidador').val())
			}

			$.post('http://3.96.217.5/lib/libEditarDadosCuidador.aspx', { emailCuidador: localStorage.getItem('usuarioLogado'), imagemCuidador: resultado, nmCuidador: nomeCuidador, especializacoes: localStorage.getItem('especializacoesCuidador'), genero: generoCuidador, dsCuidador: descricaoCuidador, dsEspecializacao: descricaoEspecializacao,telCuidador: telefoneCuidador, cpf: cpfCuidador, link: linkCurriculo, vlHora: valorHora }, function(retorno){

				if (retorno == "erro") 
				{
					console.log('deu erro na lib editar dados Cuidador');
				}
				else
				{
					console.log('deu certo alterou os dados');
					alert('dados alterado com sucesso !');
					$('#iconeVoltarNav').click();
				}

			});
		}
		catch(err)
		{
			console.log(err);
		}
	}
	
	processFile();

}