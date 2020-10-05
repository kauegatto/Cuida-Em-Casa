$(document).ready(function () {
    var indexPage = 1;
    $(".navBtn").click(function () {
        indexPage++;
        console.log(indexPage);
        $(this).parents("div.wrapper").css({ "display": "none" });
        $(this).parents("div.conteudogeral").children().eq(indexPage).css({ "display": "block" });

    });

    $(".finalizarBtn").click(function () {
        window.location.href = "pedidos.html";
    });
});    