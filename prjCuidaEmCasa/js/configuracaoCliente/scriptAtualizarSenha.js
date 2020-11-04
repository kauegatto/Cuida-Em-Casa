export default function scriptAtualizarSenha(senhaAtual, novaSenha, confirmarSenha) {

	$.post("../../lib/libAtualizarSenha.aspx", { sa: senhaAtual, ns: novaSenha, cs: confirmarSenha}, function(retorno) {

		if (retorno == "erro") 
		{
			console.log("deu erro");
		}
		else
		{
			
		}

	});

}