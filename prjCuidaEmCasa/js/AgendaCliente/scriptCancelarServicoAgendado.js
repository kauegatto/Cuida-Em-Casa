export default function scriptCancelarServicoAgendado() {

	function presentAlert() {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'teste';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = 'O serviço foi cancelado com sucesso!';
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

	$.post("../../lib/libCancelarServicoAgendado.aspx", { codigoServico: localStorage.getItem("cdServico")}, function(retorno) {

		if (retorno == "false") 
		{
			console.log("deu erro");
		}
		else
		{
			console.log("servico cancelado");
			presentAlert();
			$('.iconeVoltar').click();
		}

	});

}