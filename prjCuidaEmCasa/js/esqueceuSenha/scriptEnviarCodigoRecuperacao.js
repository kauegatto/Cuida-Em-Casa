export default function scriptEnviarCodigoRecuperacao(codigo, email){

	$.post("http://3.96.217.5/lib/libEnviarCodigoRecuperacao.aspx", { codigoRecuperacao: codigo, emailUsuario: email}, function(retorno){

		if (retorno == "erro") 
		{
			console.log("deu erro na lib enviar codigo de recuperacao");
			alert('Codigo de recuperação errado');
		}
		else
		{
			$('#wrapper-CodigoRecuperarSenha').css('display', 'none');
			$('#wrapper-AlterarSenhaRecuperacao').css('display', 'block');
			localStorage.setItem('cdRecuperacao', codigo);
		}


	});

}