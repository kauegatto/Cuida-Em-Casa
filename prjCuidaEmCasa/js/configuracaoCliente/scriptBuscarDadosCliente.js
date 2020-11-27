export default function scriptBuscarDadosCliente(){

	$.post("http://3.96.217.5/lib/libBuscarDadosCliente.aspx", { emailCliente: localStorage.getItem('usuarioLogado')}, function(retorno){

		if (retorno == "erro") 
		{
			console.log('deu erro na lib buscar dados cliente');
		}
		else
		{
			retorno = retorno.split("|");

			$('#txtAlterarNomeCliente').val(retorno[0]);
			$('#txtAlterarCpfCliente').val(retorno[1]);
			$('#txtAlterarTelefoneCliente').val(retorno[2]);

			console.log('trouxe os dados do cliente');
		}

	});


}