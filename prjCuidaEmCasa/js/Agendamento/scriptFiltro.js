export default function scriptFiltro(){	

        var imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
        var filtroEspecializacao = $('.cbxEspecializacao').val();
        var filtroPreco = $('.cbxPreco').val().replace('Até R$', '').trim(); var intFiltroPreco; var intAvaliacao;
        var filtroGenero = $('.cbxGenero').val(); var infoGenero
        var filtroAvaliacao = $('.cbxAvaliacao').val().replace('Maior que:', '').trim();
        var vE,vP,vG,vA;

        if (filtroEspecializacao == "0") {vE = "false";}
      	else{vE = "true";}

    	if (filtroPreco == "") {
	    	vP = "false"; 
	    }
        else {
	        vP = "true";
	        intFiltroPreco = filtroPreco;
	    }

    	if (filtroGenero == "Selecione") {vG = "false";}
        else{vG = "true"; infoGenero = filtroGenero}

    	if (filtroAvaliacao == "") {vA = "false";}
        else{vA = "true"; intAvaliacao = filtroAvaliacao}

	  	$.post("../../lib/libBuscarCuidador.aspx", { d: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), hf: localStorage.getItem("horaFim"), filtro: "true", vA: vA, vP: vP, vG: vG, vE: vE,vEspecializacao: filtroEspecializacao, vPreco: intFiltroPreco,vAvaliacao: intAvaliacao,vGenero:infoGenero}, function (retorno) {
	       	console.log(retorno);
            var botao = "<button class='btnProximo' id='btnCuidador'>Próximo</button>";
	        if (retorno == "" || retorno == null){
                $('#wrapper-cuidador').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Erro no retorno</h2>");
	        }
	        else if (retorno == "false") {
	            $('#wrapper-cuidador').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Desculpe, mas não encontramos cuidadores nessas especificações</h2>");
	        }
            else {
                retorno = retorno.split("|");

	            $('#wrapper-cuidador').html(retorno[0] + botao);

                if ($('.invi').html() == imgPadrao) 
                {
                    $(".areaCuidador").each(function (i, obj) {
                        var url = "data:image/svg+xml;base64," + $(this).children("div.invi").html();
                        $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
                    });
                }
                else
                {
                    $(".areaCuidador").each(function (i, obj) {
                        var url = "data:image/jpeg;base64," + $(this).children("div.invi").html();
                        $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')"); 
                    });
                }

	            $(".areaCuidador").click(function (e) {
                    $(".areaCuidador").removeClass("selecionado");
                    $(this).addClass("selecionado");
                });
            }
	    });
}
