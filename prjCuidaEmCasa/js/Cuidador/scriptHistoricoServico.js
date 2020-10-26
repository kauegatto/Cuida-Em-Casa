$(document).ready(function () {

    $.post("../../lib/libHistoricoServico.aspx", { email: "flaviabeneditamilenamelo@gmail.com" }, function (retorno) {
        if (retorno == "" || retorno == null) {
            $('#wrapper-historicoServico').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Desculpe, mas você não tem serviços finalizados</h2>");
        }

        else if (!retorno[0]) {
            $('#wrapper-historicoServico').html("ERRO NO RETORNO");
        }

        $('#wrapper-historicoServico').html(retorno);

        $(".areaHistorico").each(function (i, obj) {
            var url = "data:image/png;base64," + $(this).children().eq(3).html();
            $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
        });

        $(".areaHistorico").click(function (e) {
            $(".areaHistorico").removeClass("selecionado");
            $(this).addClass("selecionado");
        });

        $(".areaFiltro").click(function (e) {
            $(".infoFiltro").toggleClass("visivel");
        });
    });
});