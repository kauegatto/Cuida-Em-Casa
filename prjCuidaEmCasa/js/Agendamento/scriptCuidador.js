$(document).ready(function () {
    
    $(".areaCuidador").each(function (i, obj) {
        url = "data:image/svg+xml;base64," + $(this).children().eq(2).html();

        $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
    });

    $(".areaCuidador").click(function (e) {
        $(".areaCuidador").removeClass("selecionado");
        $(this).addClass("selecionado");
    });

    $(".btnProximo").click(function () {
        var classes = $(".selecionado").attr("class").split(/\s+/);
        localStorage.setItem("emailCuidador", classes[1]);
    });



});  