export default function scriptServicoAgendado() {

    $.post("../../lib/libListarServicosAgendados.aspx", { e: localStorage.getItem("usuarioLogado") }, function (retorno) {

        if (retorno == "erro") {
            console.log("deu erro");
        }
        else 
        {
            console.log("salve");
            $("#listaServicosAgendados").html(retorno);
            
            $(".areaAgendaConteudo").each(function (i, obj) {
                var url = "data:image/png;base64," + $(this).children('.invi').html();
                $(this).children(".areaImagemPacienteAgendamento").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });
        }
    });
};
