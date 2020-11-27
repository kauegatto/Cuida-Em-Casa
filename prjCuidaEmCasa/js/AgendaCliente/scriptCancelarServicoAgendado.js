export default function scriptCancelarServicoAgendado() {

	$.post("http://3.96.217.5/lib/libCancelarServicoAgendado.aspx", { codigoServico: localStorage.getItem("cdServico")}, function(retorno) {

		if (retorno == "false") 
		{
			console.log("deu erro");
		}
		else
		{
			console.log("servico cancelado");
		}

	});

}