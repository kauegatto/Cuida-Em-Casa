﻿export default function scriptDetalheHistoricoCliente(cdServico) {

	var imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

	$.post("../../lib/libDetalheHistoricoCliente.aspx", { codigoServico: cdServico}, function(retorno) {

		if (retorno == "erro") 
		{
			console.log("deu erro");
		}
		else
		{
			var dados;
			dados = retorno.split(';');
			console.log(dados[17]);

			$('.invi').html(dados[0])

			if( dados[0]  == imgPadrao)
			{
				$(".areaInformacoesCuidador").each(function (i, obj) {
					var url = "data:image/svg+xml;base64," + $(this).children('.invi').html();
                	$(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            	});
			} 
			else
			{
				$(".areaInformacoesCuidador").each(function (i, obj) {
					var url = "data:image/jpeg+jpg;base64," + $(this).children('.invi').html();
                	$(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            	});
			}
			$('#nomeCuidador').html(dados[1]);
			if (dados[2] != "" && dados[3] != "") 
			{
				$('#estrela').html(dados[2] + " " + dados[3]);
			}
			else
			{
				$('#estrela').html();
			}
			$('#especializacao').html(dados[4]);
			$('#generoCuidador').html(dados[5]);
			$('#descricaoCuidador').html(dados[6]);
			$('#enderecoServico').html(dados[7] + " - " + dados[8] + " - " + dados[9]  + " - " +  dados[10]  + " - " + dados[11] + " - " + dados[12]);
			$('#horarioServico').html(dados[13] + " - " + dados[14]);
            if (dados[17] == "4") {
                $('#valorTotal').html("Nenhum valor recebido");
            }
            else {
                $('#valorTotal').html(dados[15] + " Reais");
            }
			localStorage.setItem('emailCuidador', dados[16]);
		}

	});

}