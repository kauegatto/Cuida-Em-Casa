export default function scriptEnviarEmailUsuario(email)
{

	$.post('../../lib/libEnviarEmailUsuario.aspx', { emailUsuario: email }, function(retorno){

		if (retorno == "erro") 
		{
			console.log('deu erro na lib enviar email Usuario');
		}
		else
		{
			console.log('deu certo enviou o email p cara');
		}

	});

}