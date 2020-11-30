export default function scriptSituacaoServico () {

    $.post("../../lib/libVerificarAceitouServicoAgora.aspx", { codigoServico: localStorage.getItem("cdServico") }, function(retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }else {
            if (retorno == "1") {
            	alert("desculpa amigo vai se redirect");
                window.location.href = "../../pages/cliente/servicoAtual.html";
            }
        }
    });

};