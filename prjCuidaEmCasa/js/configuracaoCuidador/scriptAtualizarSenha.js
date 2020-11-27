export default function scriptAtualizarSenha(senhaAtual, novaSenha, confirmarSenha, emailUsuario) {

	$.post("http://3.96.217.5/lib/libAtualizarSenha.aspx", { sa: senhaAtual, ns: novaSenha, cs: confirmarSenha, eu: emailUsuario}, function(retorno) {

		if (retorno == "erro") 
		{
			console.log("deu erro");
		}
		else
		{
			if (retorno == "senhaAtualDiferente") {
				console.log('senha atual diferente');
			}
			else
			{
				if (retorno == "senhaDiferente") 
				{
					console.log('nova senha e confirmar senha diferente');
				}
				else
				{
					console.log('deu certo trocou a senha');
				}
			}
		}

	});

}