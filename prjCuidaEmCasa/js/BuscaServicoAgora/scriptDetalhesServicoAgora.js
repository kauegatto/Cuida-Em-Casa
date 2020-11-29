export default function scriptDetalhesServicoAgora(cd_servico_selecionado){

	function alertCerto(text) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

   	function alertErro(text) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

    $.post("../../lib/libDetalhesServicoAgora.aspx", { cdServico: cd_servico_selecionado }, function (retorno) {
        if (!retorno) {
            alertErro('Houve um erro');
        }

        $('#wrapper-detalhesServico').html(retorno);
        //console.log(retorno);
        var url = "data:image/png;base64," + $(".invi").html();
        $(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
    });

}