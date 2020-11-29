export default function scriptSituacaoServico () {

    $.post("../../lib/libVerificarAceitouServicoAgora.aspx", { codigoServico: localStorage.getItem("cdServico") }, function(retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }else {
            if (retorno == "1") {
                window.location.href = "../../pages/cliente/servicoAtual.html";
            }
        }
    });

};