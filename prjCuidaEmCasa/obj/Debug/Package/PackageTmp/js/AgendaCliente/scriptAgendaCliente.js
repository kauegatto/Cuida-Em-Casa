export default function scriptAgendaClienteAgendado() {

	$.post("../../lib/libAgendadosAgendaCliente.aspx", { e: localStorage.getItem("usuarioLogado")}, function(retorno) {

		if (retorno == "erro") 
		{
			console.log("deu erro");
		}
		else
		{
			console.log('deu certo agenda');
			$("#listaAgenda").html(retorno);
			$(".areaDadosAgendados").each(function (i, obj) {
				var url = "data:image/svg+xml;base64," + $(this).children('.invi').html();
                $(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });

		}

	});

}