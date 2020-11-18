export default function scriptServicoAgora(){

    $.post("../../lib/libServicoAtual.aspx", { cdServico: localStorage.getItem("cdServico") }, function (retorno) {
        if (!retorno) {
            console.log("deu errado");
        }

        $('#wrapper-infoServico').html(retorno);

        $(".areaInfoPaciente").each(function (i, obj) {
			var url = "data:image/png;base64," + $(this).children('.invi').html();
            $(this).children(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
        });

    });

};