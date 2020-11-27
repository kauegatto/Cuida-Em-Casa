export default function scriptCriarContaCliente(){

	$.post("http://3.96.217.5/lib/libCriarContaCliente.aspx", { nomeCliente: localStorage.getItem("nomeCliente"), emailCliente: localStorage.getItem("emailCliente"), telefoneCliente: localStorage.getItem('telefoneCliente'), cpfCliente: localStorage.getItem('cpfCliente'), senhaCliente: localStorage.getItem('senhaCliente')}, function(retorno){

		if (retorno == "erro") {
			console.log('deu erro');
		}
		else
		{
			console.log('cliente cadastrado');
			window.location.href = "../../pages/cliente/atendimento.html";
		}

	});

}