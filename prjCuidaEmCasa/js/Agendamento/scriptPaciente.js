$(document).ready(function () {

    $(".areaPaciente").each(function (i, obj) {
        url = "data:image/png;base64," + $(this).children().eq(3).html();
        $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
    });

    $(".areaPaciente").click(function (e) {
        $(".areaPaciente").removeClass("selecionado");
        $(this).addClass("selecionado");
    });

    $(".btnProximo").click(function () {
        var classes = $(".selecionado").attr("class").split(/\s+/);
        localStorage.setItem("cdPaciente", classes[1]);
        window.location.href = "confirmarEndereco.aspx"
    });



});