export default function scriptServicoAgora(){

    $.post("../../lib/libServicoAtual.aspx", { cdServico: localStorage.getItem("cdServico") }, function (retorno) {
        if (!retorno) {
            console.log("deu errado");
        }

        $('#wrapper-infoServico').html(retorno);
    });

};