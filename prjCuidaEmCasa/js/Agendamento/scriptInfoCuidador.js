$(document).ready(function () {
    $(".areaInfoDetalhes").click(function () {
        $(this).toggleClass("fechado");
        if ($(this).hasClass("fechado")) {
            $(this).parent("height", "25px");
            var altura = $(this).children(":first").height();

            $(this).css("height", altura);
            $(this).parent().css("height", altura);
            $(this).children(".tituloInformacao").css("height", "100%");
            $(this).children(".tituloInformacao").css("border-bottom", "0px");
            $(this).children(".btnExpandir").css("height", "100%");
            $(this).children(".btnExpandir").css("border-bottom", "0px");
            $(this).children(".detalheInformacao").css("display", "none");
            $(this).css("height", "altura");
            $(this).children(".btnExpandir").html("+");

        }
        else {
            $(this).parent().css("height", "85px");
            var altura = $(this).parent().height();
            $(this).css("height", "100%");
            $(this).children(".tituloInformacao").css("height", "30%");
            $(this).children(".tituloInformacao").css("border-bottom", "1.3px solid #000");
            $(this).children(".btnExpandir").css("height", "30%");
            $(this).children(".btnExpandir").css("border-bottom", "1.3px solid #000");
            $(this).children(".detalheInformacao").css("display", "block");
            $(this).css("height", "altura");
            $(this).children(".btnExpandir").html("-");
        }
    }); //VA I SE F8UDE AJAVASCIRPT!!!
    $.post("../../lib/dadosEmailCuidador.aspx", { e: localStorage.getItem("emailCuidador") }, function (retorno) {
        if (!retorno) {
            response.redirect('google.com');
        }
        retorno = retorno.split("/");
        console.log(retorno);
        $('#vl_hora_cuidador').html(retorno[0] + " por hora");
        $('#nm_cuidador').html(retorno[1]);
        $('#nm_tipo_especializacao_cuidador').html(retorno[2]);
        $('#nm_genero_cuidador').html(retorno[3]);
        $('#nm_experiencia_cuidador').html(retorno[4]);
        $('#ds_cuidador').html(retorno[5]);
        localStorage.setItem("valorHora", retorno[0]);
        localStorage.setItem("nomeCuidador", retorno[1]);
    });
});