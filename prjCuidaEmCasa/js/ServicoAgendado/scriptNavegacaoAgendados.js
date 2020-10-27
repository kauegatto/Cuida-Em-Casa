import scriptServicoAgendado from "./scriptServicoAgendado.js";

$(document).ready(function () {

    scriptServicoAgendado();

    $(".iconeVoltar").click(function () {
        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });
    });

    $("#wrapper-ServicoAgendado").addClass("visivel");
    $('#headerComum').addClass("visivel");

});