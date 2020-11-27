$(document).ready(function () {

    $.post("../../../lib/libServicosCuidadorAdm.aspx", { emailCuidador: localStorage.getItem("emailCuidador") }, function (retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }
        else {
            $('.conteudoCuidador').html(retorno);
        }
    });

});