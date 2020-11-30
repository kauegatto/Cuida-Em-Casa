export default function scriptDenunciarServico(emailCliente, txtDenuncia, cdServico, cdTipoDenuncia) {

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

	$.post("http://3.96.217.5/lib/libDenunciarCuidador.aspx", { e: emailCliente, d: txtDenuncia, c: cdServico, cd: cdTipoDenuncia}, function(retorno) {

		if (retorno == "erro") 
		{
			//console.log("deu erro");
			alertIonic('Houve um erro na denuncia <br> <br> Por favor preencha novamente os dados');
		}
		else
		{
			//console.log("denunciado");
			alertIonic('O Cliente foi denunciado com sucesso!');
			$('.iconeVoltar').click();
		}

	});

};