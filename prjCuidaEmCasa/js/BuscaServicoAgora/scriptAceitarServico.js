export default function scriptAceitarServico(){

    $.post("http://3.96.217.5/lib/libAceitarServicoAgora.aspx", { cdServico: localStorage.getItem("cdServico"), emailCuidador: localStorage.getItem("usuarioLogado") }, function (retorno) {
        
        if (!retorno) {
            console.log("deu errado");
        }
        
    });

};