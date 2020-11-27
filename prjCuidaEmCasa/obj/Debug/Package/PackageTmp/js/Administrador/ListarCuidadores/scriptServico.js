$(document).ready(function () {

    $.post("http://3.96.217.5/lib/libServicosCuidadorAdm.aspx", { emailCuidador: localStorage.getItem("emailCuidador") }, function (retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }
        else {
            $('.conteudoCuidador').html(retorno);
        }
    });

});