$(document).ready(function () {

    var imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

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

            if (retorno[13] == "0") {
                $('.btnServicos').prop("disabled", true);
            }
            else {
                $('.btnServicos').prop("disabled", false);
            }

            if (retorno[0] == imgPadrao) {
                var url = "data:image/svg+xml;base64," + retorno[0];
                $("#img_cuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            }
            else {
                var url = "data:image/png;base64," + retorno[0];
                $("#img_cuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            }
        }
    });

});