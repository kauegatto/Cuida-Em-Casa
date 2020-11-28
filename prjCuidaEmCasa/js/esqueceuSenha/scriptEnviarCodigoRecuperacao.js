export default function scriptEnviarCodigoRecuperacao(codigo, email){

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

	$.post("../../lib/libEnviarCodigoRecuperacao.aspx", { codigoRecuperacao: codigo, emailUsuario: email}, function(retorno){

		if (retorno == "erro") 
		{
			//console.log("deu erro na lib enviar codigo de recuperacao");
			alertIonic('Código de recuperação errado');
		}
		else
		{
			$('#wrapper-CodigoRecuperarSenha').css('display', 'none');
			$('#wrapper-AlterarSenhaRecuperacao').css('display', 'block');
			localStorage.setItem('cdRecuperacao', codigo);
		}


	});

}