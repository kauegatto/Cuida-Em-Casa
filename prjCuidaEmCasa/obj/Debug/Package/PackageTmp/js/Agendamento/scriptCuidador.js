export default function scriptCuidador () {

    $.post("../../lib/libBuscarCuidador.aspx", { d: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), hf: localStorage.getItem("horaFim"), qtd: localStorage.getItem("qtdHoras") }, function (retorno) {
        var botao = "<button class='btnProximo' id='btnCuidador'>Próximo</button>";
        
        retorno = retorno.split("|");
        
        //console.log(retorno);
        
        if (retorno[0] == "" || retorno[0] == null){
            $('#wrapper-cuidador').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Desculpe, mas não encontramos cuidadores nesse horário</h2>");
        }

        else if (!retorno[0]) {
            $('#wrapper-cuidador').html("ERRO NO RETORNO");
        }


        $('#wrapper-cuidador').html(retorno[0] + botao);

        $(".areaCuidador").each(function (i, obj) {
            var tinhaImg = $(this).children("div.invi").html().split("#");
            if (tinhaImg[1] == "true" ){var url = "data:image/png;base64," + tinhaImg[0];}
            else{ var url = "data:image/svg+xml;base64," +tinhaImg[0]; }
            
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
