
export default function scriptAtualizarDadosCliente(){

	var nmCliente = $('#txtAlterarNomeCliente').val();
	var telCliente = $('#txtAlterarTelefoneCliente').val();
	var cpf = $('#txtAlterarCpfCliente').val();

	$.post("../../lib/libAtualizarDadosCliente", { nomeCliente: nmCliente, telefoneCliente: telCliente, cpfCliente: cpf}, function(retorno){

		if (retorno == "erro") 
		{
			console.log('deu erro na lib atualizar dados');
		}
		else
		{
			console.log('deu certo alterou dados');
		}


	});

}