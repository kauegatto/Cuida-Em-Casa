export default function scriptEditarDadosCuidador(){

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

		try
		{
			let file = document.getElementById('uploadImgUsuario').files[0];

			resultado = await readFileAsync(file);

			//console.log(resultado);

		}
		catch(err)
		{
			console.log(err);
		}

		var nomeCuidador = $('#txtAlterarNomeCuidador').val();
		//var especializacoesCuidador = localStorage.getItem('especializacoesCuidador');
		var generoCuidador = $('#generoCuidador').val();
		var descricaoCuidador = $('#txtDescricaoCuidador').val()
		var descricaoEspecializacao = $('#txtDescricaoEspecializacao').val();
		var telefoneCuidador = $('#txtAlterarTelefone').val();
		var cpfCuidador = $('#txtAlterarCPF').val();
		var linkCurriculo = $('#txtAlterarLinkCurriculo').val();
		var valorHora = $('#txtAlterarValorHora').val();
		var imgCuidador;

		if (resultado == "" || resultado == undefined) 
		{
			imgCuidador = null;
		}
		else
		{
			imgCuidador = resultado;
		}

		if ($('#txtEspecializacoesCuidador').html() == "") 
		{
			localStorage.setItem('especializacoesCuidador', $('#especializacoesCuidador').val())
		}

		$.post('http://3.96.217.5/lib/libEditarDadosCuidador.aspx', { emailCuidador: localStorage.getItem('usuarioLogado'), imagemCuidador: imgCuidador, nmCuidador: nomeCuidador, especializacoes: localStorage.getItem('especializacoesCuidador'), genero: generoCuidador, dsCuidador: descricaoCuidador, dsEspecializacao: descricaoEspecializacao,telCuidador: telefoneCuidador, cpf: cpfCuidador, link: linkCurriculo, vlHora: valorHora }, function(retorno){

			if (retorno == "erro") 
			{
				console.log('deu erro na lib editar dados Cuidador');
			}
			else
			{
				//console.log('deu certo alterou os dados');
				//alert('dados alterado com sucesso !');
				alertIonic('Dados alterado com sucesso!');
				$('#iconeVoltarNav').click();
			}

		});
	}
	
	processFile();

}