export default function scriptEditarDadosCuidador(){

	var imgCuidador;
	var input = document.getElementById("uploadImgUsuario");
	var fReader = new FileReader();
	fReader.readAsDataURL(input.files[0]);
	fReader.onloadend = function(event){
		console.log(event.target.result);
		imgCuidador = event.target.result;
		localStorage.setItem('imagemCuidador', imgCuidador);
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

	$.post('../../lib/libEditarDadosCuidador.aspx', { emailCuidador: localStorage.getItem('usuarioLogado'), imagemCuidador: localStorage.getItem('imagemCuidador'), nmCuidador: nomeCuidador, especializacoes: localStorage.getItem('especializacoesCuidador'), genero: generoCuidador, dsCuidador: descricaoCuidador, dsEspecializacao: descricaoEspecializacao,telCuidador: telefoneCuidador, cpf: cpfCuidador, link: linkCurriculo, vlHora: valorHora }, function(retorno){

		if (retorno == "erro") 
		{
			console.log('deu erro na lib editar dados Cuidador');
		}
		else
		{
			console.log('deu certo alterou os dados');
		}

	});

}