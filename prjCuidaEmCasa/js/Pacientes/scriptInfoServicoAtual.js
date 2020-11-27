export default function scriptInfoServicoAtual(cdServico) {

    var imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
    var retorno;
    var map = document.getElementById('map');
    var img = document.createElement('img'); 
    $.post("../../lib/libInfoServicoAtual.aspx", { cdServico: cdServico}, function (retorno) {

        if (!retorno) {
            $('#wrapper-ServicoAtual').html("ERRO NO RETORNO");
        }
        else {

            $('#wrapper-ServicoAtual').html(retorno);

            $(".areaDadosBuscandoCuidadores").each(function (i, obj) {
                
                if ($('.invi').html() == imgPadrao) 
                {
                    var url = "data:image/svg+xml;base64," + $(this).children('.invi').html();
                    $(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
                }
                else
                {
                    var url = "data:image/jpeg;base64," + $(this).children('.invi').html();
                    $(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
                }

                var endereco =  $("#informacoesEndereco").html();
                var apimaps = "";
                img.src =  'https://maps.googleapis.com/maps/api/staticmap?center='+ endereco+'&zoom=13&size=300x300&maptype=roadmap&markers=color:blue|label:k|'+endereco+'&key='+ apimaps;
                $("#map").html("");
                document.getElementById('map').appendChild(img); 

            });
        }
    });

}