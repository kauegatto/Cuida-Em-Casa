import scriptBuscarDadosCliente from './scriptBuscarDadosCliente.js';

export default function scriptAtualizarDadosCliente(){

	var nmCliente = $('#txtAlterarNomeCliente').val();
	var telCliente = $('#txtAlterarTelefoneCliente').val();
	var cpf = $('#txtAlterarCpfCliente').val();

	$.post("../../lib/libAtualizarDadosCliente.aspx", { nomeCliente: nmCliente, telefoneCliente: telCliente, cpfCliente: cpf, emailCliente: localStorage.getItem('usuarioLogado')}, function(retorno){

		if (retorno == "erro") 
		{
			console.log('deu erro na lib atualizar dados');
		}
		else
		{
			console.log('deu certo alterou dados');
			alert('Dados alterado com sucesso!');
			scriptBuscarDadosCliente();
			$('.iconeVoltar').click();
		}


	});

}