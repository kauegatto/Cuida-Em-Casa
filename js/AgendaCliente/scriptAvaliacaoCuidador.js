export default function scriptAvaliacaoCuidador(notaAvaliacao, emailCuidador) {

	function presentAlert() {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = 'O cuidador foi avaliado com sucesso !';
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

	$.post("http://3.96.217.5/lib/libAvaliacaoCuidador.aspx", { na: notaAvaliacao, ec: emailCuidador }, function(retorno){

		if (retorno == "erro") {
			console.log('deu erro na estrela mano arruma ai slc');
		}
		else
		{
			presentAlert();
		}

	});


}