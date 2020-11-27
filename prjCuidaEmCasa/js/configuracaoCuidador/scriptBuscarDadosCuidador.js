export default function scriptBuscarDadosCuidador(){

	function alertIonic(text) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

	var imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

	$('#txtAlterarTelefone').mask('(00) 00000-0000');
	$('#txtAlterarCPF').mask('000.000.000-00');

	$.post("../../lib/libEspecializacaoCuidador.aspx", function(retorno){

		if (retorno == "erro") 
		{
			//console.log('deu erro na libEspecializacaoCuidador');
			alertIonic('Houve um erro');
		}
		else
		{
			$('#especializacoesCuidador').html(retorno);
		}

	});

	$.post("../../lib/dadosEmailCuidador.aspx", { e: localStorage.getItem('usuarioLogado')}, function(retorno){

		if (retorno == "erro") 
		{
			//console.log('deu erro na lib buscar dados cuidador');
			alertIonic('Houve um erro!');
		}
		else
		{
			//console.log('trouxe os dados do cuidador');
			retorno = retorno.split('|');
			console.log(retorno);

			$('#txtAlterarValorHora').val(retorno[0]);
			$('#txtAlterarNomeCuidador').val(retorno[1]);

			if (retorno[3] == "Masculino") 
			{
				$('#generoMasculino').prop('selected',true);
			}
			else
			{
				if (retorno[3] == "Feminino") 
				{
					$('#generoFeminino').prop('selected',true);
				}
				else
				{
					$('#generoOutro').prop('selected',true);
				}
			}

			$('#txtDescricaoEspecializacao').val(retorno[4]);
			$('#txtDescricaoCuidador').val(retorno[5]);

			$('.invi').html(retorno[6]);

			if ($('.invi').html() == imgPadrao) 
			{
				$(".areaInfoDadosPaciente").each(function (i, obj) {

	            	var url = "data:image/svg+xml;base64," + $(this).children(".invi").html();
	            	$(this).children(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
	                  
	            });
			}
			else
			{
				$(".areaInfoDadosPaciente").each(function (i, obj) {

	                var url = "data:image/jpeg;base64," + $(this).children(".invi").html();
	                $(this).children(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
	                  
	            });
			}

			$('#txtAlterarCPF').val(retorno[7]);
			$('#txtAlterarTelefone').val(retorno[8]);
			$('#txtAlterarLinkCurriculo').val(retorno[9]);

		}


	});

}