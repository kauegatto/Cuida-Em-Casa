export default function scriptEnviarEmailUsuario(email)
{

	function alertIonic(text) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

	$.post('../../lib/libEnviarEmailUsuario.aspx', { emailUsuario: email }, function(retorno){

		if (retorno == "erro") 
		{
			//console.log('deu erro na lib enviar email Usuario');
			alertIonic('Houve um erro');
		}
		else
		{
			//console.log('deu certo enviou o email p cara');
		}

	});

}