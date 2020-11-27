$(document).ready(function () {

    $.post("http://3.96.217.5/lib/libListarCuidadoresAdm.aspx", function (retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }
        else {
            $('.listaCuidadores').html(retorno);
        }
    });

    $(document).on("click", ".iconeInformacao", function () {
        var classes = $(this).attr("class").split(/\s+/);
        localStorage.setItem("emailCuidador", classes[1]);
    });

});