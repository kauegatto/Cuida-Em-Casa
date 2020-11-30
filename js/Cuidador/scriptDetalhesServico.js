export default function scriptDetalhesServico(cd_servico_selecionado){

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

    $.post("http://3.96.217.5/lib/libDetalhesServico.aspx", { cdServico: cd_servico_selecionado }, function (retorno) {
        if (!retorno) {
            //console.log("Erro");
            alertIonic('Houve um erro!');
        }

        $('#wrapper-detalhesServico').html(retorno);
        //console.log(retorno);
        var url = "data:image/png;base64," + $(".invi").html();
        $(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
    });

}