$(document).ready(function () {

    $.post("../../../lib/libInfoCuidadoresAdm.aspx", { emailCuidador: localStorage.getItem("emailCuidador") }, function (retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }
        else {
            retorno = retorno.split("|");
            $('#nm_cuidador').html(retorno[1]);
            $('#genero_cuidador').html(retorno[2]);
            $('#tel_cuidador').html(retorno[3]);
            $('#cpf_cuidador').html(retorno[4]);
            $('#email_cuidador').html(retorno[5]);
            $('#ds_cuidador').html(retorno[6]);
            $('#especializacao_cuidador').html(retorno[7]);
            $('#vl_hora').html(retorno[8]);
            $('#curriculo_cuidador').html(retorno[9]);
            if (retorno[10] == "0") {
                $('.btnOcorrencias').prop("disabled", true);
            }
            else {
                $('.btnOcorrencias').prop("disabled", false);
            }
            $('#ocorrencia_cuidador').html(retorno[10]);
            if (retorno[11] == "0") {
                $('.btnAdvertencias').prop("disabled", true);
            }
            else {
                $('.btnAdvertencias').prop("disabled", false);
            }
            $('#advertencia_cuidador').html(retorno[11]);

            if (retorno[12] == "1") {
                $('#aplicar_suspensao').css("display", "inline");
                $('#banir_cuidador').css("display", "inline");
            }
            if (retorno[12] == "3") {
                $('#remover_suspensao').css("display", "inline");
                $('#banir_cuidador').css("display", "inline");
            }
            if (retorno[12] == "4") {
                $('#desbanir_cuidador').css("display", "inline");
            }

            var url = "data:image/svg+xml+jpeg+jpg;base64," + retorno[0];
            $("#img_cuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
        }
    });

});