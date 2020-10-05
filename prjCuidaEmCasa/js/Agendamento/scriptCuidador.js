export default function scriptCuidador () {

    $.post("../../lib/libBuscarCuidador.aspx", { d: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), hf: localStorage.getItem("horaFim"), qtd: localStorage.getItem("qtdHoras") }, function (retorno) {
        if (!retorno) {
            $('#wrapper-cuidador').append("ERRO NO RETORNO");
        }
        retorno = retorno.split("|");
        console.log(retorno);
        $('#wrapper-cuidador').append(retorno[0]);

        $(".areaCuidador").each(function (i, obj) {
            var url = "data:image/svg+xml;base64," + $(this).children().eq(2).html();
            console.log(url);
            $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
        });

        $(".areaCuidador").click(function (e) {
            $(".areaCuidador").removeClass("selecionado");
            $(this).addClass("selecionado");
        });
    });

}
