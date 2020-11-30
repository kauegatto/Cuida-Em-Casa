export default function scriptInfoCuidador () {

    var imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";


    $(".areaInfoDetalhes").click(function () {
        $(this).toggleClass("fechado");
        if ($(this).hasClass("fechado")) {
            $(this).parent("height", "25px");
            var altura = $(this).children(":first").height();

            $(this).css("height", altura);
            $(this).parent().css("height", altura);
            $(this).children(".tituloInformacao").css("height", "100%");
            $(this).children(".tituloInformacao").css("border-bottom", "0px");
            $(this).children(".btnExpandir").css("height", "100%");
            $(this).children(".btnExpandir").css("border-bottom", "0px");
            $(this).children(".detalheInformacao").css("display", "none");
            $(this).css("height", "altura");
            $(this).children(".btnExpandir").html("+");

        }
        else {
            $(this).parent().css("height", "85px");
            var altura = $(this).parent().height();
            $(this).css("height", "100%");
            $(this).children(".tituloInformacao").css("height", "30%");
            $(this).children(".tituloInformacao").css("border-bottom", "1.3px solid #000");
            $(this).children(".btnExpandir").css("height", "30%");
            $(this).children(".btnExpandir").css("border-bottom", "1.3px solid #000");
            $(this).children(".detalheInformacao").css("display", "block");
            $(this).css("height", "altura");
            $(this).children(".btnExpandir").html("-");
        }
    }); //VAI SE F8UDE AJAVASCIRPT!!!
    $.post("http://3.96.217.5/lib/dadosEmailCuidador.aspx", { e: localStorage.getItem("emailCuidador") }, function (retorno) {
        if (!retorno) {
            alert("Ocorreu um erro na busca dos dados do cuidador!");
            window.location.href = "../index.html"
        }
        retorno = retorno.split("|");
        console.log(retorno);
        $('#vl_hora_cuidador').html(retorno[0] + " por hora");
        $('#nm_cuidador').html(retorno[1]);
        $('#nm_tipo_especializacao_cuidador').html(retorno[2]);
        $('#nm_genero_cuidador').html(retorno[3]);
        $('#nm_experiencia_cuidador').html(retorno[4]);
        $('#ds_cuidador').html(retorno[5]);
        localStorage.setItem("imagemCuidador", retorno[6]);
        localStorage.setItem("valorHora", retorno[0]);
        localStorage.setItem("nomeCuidador", retorno[1]);
        if (retorno[10] != "" && retorno[11] != "") 
        {
            $('#estrelaInfo').html(retorno[10] + " " + retorno[11]);
        }
        else
        {
            $('#estrelaInfo').html("");
        }

        if (localStorage.getItem('imagemCuidador') == imgPadrao) 
        {
            var url = "data:image/svg+xml;base64," + localStorage.getItem("imagemCuidador");
            $(".areaImagemCuidadorInfo").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
        }
        else
        {
            var url = "data:image/jpeg;base64," + localStorage.getItem("imagemCuidador");
            $(".areaImagemCuidadorInfo").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
        }

       
    });
};