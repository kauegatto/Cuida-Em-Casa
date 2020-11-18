export default function scriptAceitarServico(){

    $.post("../../lib/libAceitarServicoAgora.aspx", { cdServico: localStorage.getItem("cdServico"), emailCuidador: localStorage.getItem("usuarioLogado") }, function (retorno) {
        if (!retorno) {
            console.log("deu errado");
        }
    });

};