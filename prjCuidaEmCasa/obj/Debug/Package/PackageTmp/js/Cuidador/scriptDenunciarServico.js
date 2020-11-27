export default function scriptDenunciarServico(emailCliente, txtDenuncia, cdServico, cdTipoDenuncia) {

	$.post("http://3.96.217.5/lib/libDenunciarCuidador.aspx", { e: emailCliente, d: txtDenuncia, c: cdServico, cd: cdTipoDenuncia}, function(retorno) {

		if (retorno == "erro") 
		{
			console.log("deu erro");
		}
		else
		{
			console.log("denunciado");
		}

	});

};