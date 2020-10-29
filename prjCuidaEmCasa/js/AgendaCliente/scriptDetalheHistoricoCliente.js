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

			console.log(dados)

			$('.invi').html(dados[0]);
			$(".areaInformacoesCuidador").each(function (i, obj) {
				var url = "data:image/svg+xml;base64," + $(this).children('.invi').html();
                $(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });
			$('#nomeCuidador').html(dados[1]);

		}

	});

}