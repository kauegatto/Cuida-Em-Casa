export default function scriptCancelarServicoAgendado(cdServico) {

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

    var dados;
    $.post("../../lib/libCancelarServicoAgendado.aspx", { codigoServico: cdServico }, function (retorno) {
         if (retorno == "false") {
            //console.log("deu erro");
            alertIonic("Houve um erro");
        }
        else 
        {
            //console.log("deu certo");
            alertIonic("O serviço foi cancelado com sucesso!");
            $("#headerNav .areaTituloGeral").css('display','none');
            $("#headerNav .areaLogo").css('display','none');
        }
    });
};
