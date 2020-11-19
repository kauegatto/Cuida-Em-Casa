$(document).ready(function () {
    var retorno;
    $.post("../../lib/libInfoServicoAtual.aspx", function (retorno) {

        if (!retorno) {
            $('#wrapper-ServicoAtual').html("ERRO NO RETORNO");
        }

        else if (retorno == "") {
            $('#wrapper-ServicoAtual').html("Nenhum de seus clientes está em serviço!");
            return;
        }
        else {
            $('#wrapper-ServicoAtual').html(retorno);

            $(".areaDadosBuscandoCuidadores").each(function (i, obj) {
                var url = "data:image/svg+xml;base64," + $(this).children('.invi').html();
                $(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });
        }
    });
});