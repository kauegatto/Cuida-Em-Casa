var recente = "true";

$(document).ready(function () { 
    $(document).on("click", "#btnFiltroServico", function () {
        var filtroEspecializacao = $('.cbxEspecializacao').val();
        console.log(filtroEspecializacao);
        if (filtroEspecializacao == "Selecione" || filtroEspecializacao == "Mais Recente") { recente = "true"; }
        else { recente = "false"; }
        console.log(recente);
        $.post("../../lib/libHistoricoServico.aspx", { filtro: recente, email: "flaviabeneditamilenamelo@gmail.com" }, function (retorno) {
            if (retorno == "" || retorno == null) {
                $('#wrapper-historicoServico').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Desculpe, mas você não tem nenhum serviço finalizado</h2>");
            }
            else if (!retorno || retorno == "false") {
                $('#wrapper-historicoServico').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Erro no retorno</h2>");
            }
            $('#wrapper-historicoServico').html(retorno);

            $(".areaHistorico").each(function (i, obj) {
                var url = "data:image/svg+xml;base64," + $(this).children("div.invi").html();
                $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");

            });
        });
    });
});