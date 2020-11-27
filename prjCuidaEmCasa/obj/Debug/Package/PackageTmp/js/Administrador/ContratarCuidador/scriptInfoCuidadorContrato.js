$(document).ready(function () {

    $.post("../../../lib/libInfoCuidadorContrato.aspx", { emailCuidador: localStorage.getItem('emailCuidador') }, function (retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }
        else {
            $('.areaCuidador').html(retorno);
        }
    });

});