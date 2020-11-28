$(document).ready(function () {

    var imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

    var botao = 0;
    $.post("../../../lib/libListarCuidadoresAdm.aspx", { control: botao }, function (retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }
        else {

            $('.listaCuidadores').html(retorno);

            $(".areaCuidador").each(function (i, obj) {
                var tinhaImg = $(this).children("div.invi").html().split("#");
                if (tinhaImg[1] == "true" ){var url = "data:image/png;base64," + tinhaImg[0];}
                else{ var url = "data:image/svg+xml;base64," + tinhaImg[0]; }
            
                $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });
        }
    });

    $(document).on("click", ".iconeInformacao", function () {
        var classes = $(this).attr("class").split(/\s+/);
        localStorage.setItem("emailCuidador", classes[1]);
    });

    $(document).on("click", "#buscar_filtro", function () {
        var botao = 1;
        var vE, vS, vP, vA, vEm, vG;
        var filtroEspecializacao = $('.cbxEspecializacao').val();
        var filtroStatus = $('.cbxStatus').val();
        var filtroPreco = $('.cbxPreco').val();
        var filtroAvaliacao = $('.cbxAvaliacao').val();
        var filtroEmail = $('.emailCuidador').val() + "%";
        var filtroGenero = $('.cbxGenero').val();
        if (filtroEspecializacao == "0") { vE = "false"; }
        else { vE = "true"; }

        if (filtroStatus == "0") { vS = "false"; }
        else { vS = "true"; }

        if (filtroPreco == "0") { vP = "false"; }
        else { vP = "true"; }

        if (filtroAvaliacao == "0") { vA = "false"; }
        else { vA = "true"; }

        if (filtroEmail == "%") { vEm = "false"; }
        else { vEm = "true"; }

        if (filtroGenero == "0") { vG = "false"; }
        else { vG = "true"; }

        $.post("../../../lib/libListarCuidadoresAdm.aspx", { vE: vE, vS: vS, vP: vP, vA: vA, vEm: vEm, vG: vG, especializacao: filtroEspecializacao, status: filtroStatus, preco: filtroPreco, avaliacao: filtroAvaliacao, emailCuidador: filtroEmail, genero: filtroGenero, control: botao }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else 
            {
                $('.listaCuidadores').html(retorno);

                $(".areaCuidador").each(function (i, obj) {
                    var tinhaImg = $(this).children("div.invi").html().split("#");
                    if (tinhaImg[1] == "true" ){var url = "data:image/png;base64," + tinhaImg[0];}
                    else{ var url = "data:image/svg+xml;base64," + tinhaImg[0]; }
            
                    $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
                });
            }
        });
    });

});