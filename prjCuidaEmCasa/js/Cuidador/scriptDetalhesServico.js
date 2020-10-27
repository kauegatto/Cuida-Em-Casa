export default function scriptDetalhesServico(cd_servico_selecionado){

    $.post("../../lib/libDetalhesServico.aspx", { cdServico: cd_servico_selecionado }, function (retorno) {
        if (!retorno) {
            console.log("Erro");
        }

        $('#wrapper-detalhesServico').html(retorno);

        $(".dadosHistorico").each(function (i, obj) {
                var url = "data:image/svg+xml;base64," + $(this).children(".invi").html();
                $(this).children(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
        });
    });

}