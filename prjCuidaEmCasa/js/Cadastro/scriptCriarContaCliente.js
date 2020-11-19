export default function scriptCriarContaCliente(){

	$.post("../../lib/libCriarContaCliente", { nomeCliente: localStorage.getItem("nomeCliente"), emailCliente: localStorage.getItem("emailCliente"), telefoneCliente: localStorage.getItemI('telefoneCliente'), cpfCliente: localStorage.getItem('cpfCliente'), senhaCliente: localStorage.getItem('senhaCliente')}, function(retorno){

		if (retorno == "") {
			console.log('deu erro');
		}
		else
		{
			console.log('cliente cadastrado');
		}

	});

}