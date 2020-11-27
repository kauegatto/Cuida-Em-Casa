export default function scriptDetalhesServico(cd_servico_selecionado){

    $.post("../../lib/libDetalhesServico.aspx", { cdServico: cd_servico_selecionado }, function (retorno) {
        if (!retorno) {
            console.log("Erro");
        }

        $('#wrapper-detalhesServico').html(retorno);
        console.log(retorno);
        var url = "data:image/png;base64," + $(".invi").html();
        $(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
    });

}