export default function scriptDenunciarCuidador(emailCliente, txtDenuncia, cdServico, cdTipoDenuncia) {

    function presentAlert() {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = 'O cuidador foi denunciado com sucesso !';
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

    function alertErro() {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = 'Houve um erro na denuncia ! <br> <br> Por favor preencha novamente os dados.';
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

	$.post("../../lib/libDenunciarCuidador.aspx", { e: emailCliente, d: txtDenuncia, c: cdServico, cd: cdTipoDenuncia}, function(retorno) {

		if (retorno == "erro") 
		{
			alertErro();
		}
		else
		{
			presentAlert();
			$('.iconeVoltar').click();
		}

	});

}