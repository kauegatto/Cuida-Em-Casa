export default function scriptCancelarServicoAgendado() {

	$.post("../../lib/libCancelarServicoAgendado.aspx", { codigoServico: localStorage.getItem("cdServico")}, function(retorno) {

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