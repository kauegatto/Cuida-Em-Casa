export default function scriptDenunciarCuidador(emailCuidador, txtDenuncia) {

	$.post("../../lib/libDenunciarCuidador.aspx", { e: emailCuidador, d: txtDenuncia}, function(retorno) {

		if (retorno == "erro") 
		{
			console.log("deu erro");
		}
		else
		{
			console.log("denunciado otario kkkkkkk");
		}

	});

}