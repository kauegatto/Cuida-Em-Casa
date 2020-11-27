export default function scriptDetalhesServicoAgora(cd_servico_selecionado){

    $.post("http://3.96.217.5/lib/libDetalhesServicoAgora.aspx", { cdServico: cd_servico_selecionado }, function (retorno) {
        if (!retorno) {
            console.log("Erro");
        }

        $('#wrapper-detalhesServico').html(retorno);
        //console.log(retorno);
        var url = "data:image/svg+xml;base64," + $(".invi").html();
        $(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
    });

}