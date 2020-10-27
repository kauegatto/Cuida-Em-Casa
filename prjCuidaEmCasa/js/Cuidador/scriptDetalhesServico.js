$(document).ready(function () {
    $.post("../../lib/libDetalhesServico.aspx", { cdServico: "33" }, function (retorno) {
        if (!retorno) {
            console.log("Erro");
        }

        $('#wrapper-detalhesServico').html(retorno);
    });
});