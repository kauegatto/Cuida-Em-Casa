export default function scriptCancelarServicoAgora() {

	$.post("http://3.96.217.5/lib/libCancelarServicoAgora.aspx", { codigoServico: localStorage.getItem("cdServico") }, function(retorno) {

		if (retorno == "false") 
		{
			console.log("deu erro");
		}
		else
		{
			console.log("servico cancelado");
            window.location.href = "../../pages/cliente/atendimento.html";

		}

	});

};