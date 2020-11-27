export default function scriptDenunciarServico(emailCliente, txtDenuncia, cdServico, cdTipoDenuncia) {

	$.post("../../lib/libDenunciarCuidador.aspx", { e: emailCliente, d: txtDenuncia, c: cdServico, cd: cdTipoDenuncia}, function(retorno) {

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