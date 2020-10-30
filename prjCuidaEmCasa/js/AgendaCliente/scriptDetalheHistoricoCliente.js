export default function scriptDetalheHistoricoCliente(cdServico) {

	$.post("../../lib/libDetalheHistoricoCliente.aspx", { codigoServico: cdServico}, function(retorno) {

		if (retorno == "erro") 
		{
			console.log("deu erro");
		}
		else
		{
			var dados;

			dados = retorno.split(';');

			$('.invi').html(dados[0]);
			$(".areaInformacoesCuidador").each(function (i, obj) {
				var url = "data:image/svg+xml;base64," + $(this).children('.invi').html();
                $(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });
			$('#nomeCuidador').html(dados[1]);
			$('#notaAvaliacao').html(dados[2]);
			$('#especializacao').html(dados[3]);
			$('#genero').html(dados[4]);
			$('#descricao').html(dados[5]);
			$('#ruaServico').html(dados[6] + " - " + dados[7] + " - " + dados[8] + " - " + dados[9] + dados[10] + " - " + dados[11] );
			$('#horario').html(dados[12] + " - " + dados[13]);
			$('#valorTotal').html(dados[15] + " Reais");
		}

	});

}