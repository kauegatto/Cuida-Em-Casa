export default function scriptDetalheAgendadosCliente(cdServico) {

	$.post("../../lib/libDetalheAgendaCliente.aspx", { codigoServico: cdServico}, function(retorno) {

		if (retorno == "erro") 
		{
			console.log("deu erro");
		}
		else
		{

			$('#listaDetalheAgenda').html(retorno);
			$(".areaInformacoesCuidador1").each(function (i, obj) {
				var url = "data:image/svg+xml;base64," + $(this).children('.invi').html();
                 $(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });
		}

	});

}