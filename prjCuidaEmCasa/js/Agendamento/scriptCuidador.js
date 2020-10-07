export default function scriptCuidador () {

    $.post("../../lib/libBuscarCuidador.aspx", { d: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), hf: localStorage.getItem("horaFim"), qtd: localStorage.getItem("qtdHoras") }, function (retorno) {
        retorno = retorno.split("|");
        console.log(retorno);
        
        if (retorno[0] == "" || retorno[0] == null){
            $('#wrapper-cuidador').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Desculpe, mas não encontramos cuidadores nesse horário</h2>");
        }
        else if (!retorno[0]) {
            $('#wrapper-cuidador').append("ERRO NO RETORNO");
        }
        $('#wrapper-cuidador').append(retorno[0]);

        $(".areaCuidador").each(function (i, obj) {
            var url = "data:image/svg+xml;base64," + $(this).children("div.invi").html();
            $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
        });

        $(".areaCuidador").click(function (e) {
            $(".areaCuidador").removeClass("selecionado");
            $(this).addClass("selecionado");
        });

        $(".areaFiltro").click(function (e){
            $(".infoFiltro").toggleClass("visivel");
        });

    });

}
