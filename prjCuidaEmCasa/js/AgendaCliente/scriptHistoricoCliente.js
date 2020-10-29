export default function scriptHistoricoClienteAgendado() {

	$.post("../../lib/libAgendadosHistoricoCliente.aspx", { e: localStorage.getItem("usuarioLogado")}, function(retorno) {

		if (retorno == "erro") 
		{
			console.log("deu erro");
		}
		else
		{
			console.log('deu certo historico');

			$("#listaHistorico").html(retorno);
			$(".areaDadosAgendados").each(function (i, obj) {
				var url = "data:image/svg+xml;base64," + $(this).children('.invi').html();
                $(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });

		}

	});

}