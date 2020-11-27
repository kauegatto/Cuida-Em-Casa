export default function scriptCancelarServicoAgora() {

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

	$.post("../../lib/libCancelarServicoAgora.aspx", { codigoServico: localStorage.getItem("cdServico") }, function(retorno) {

		if (retorno == "false") 
		{
			//console.log("deu erro");
			alertIonic('Houve um erro');
		}
		else
		{
			//console.log("servico cancelado");
			alertIonic('Servico cancelado com sucesso!');
            window.location.href = "../../pages/cliente/atendimento.html";

		}

	});

};