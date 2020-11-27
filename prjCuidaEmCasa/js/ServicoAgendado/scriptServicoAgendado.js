export default function scriptServicoAgendado() {

    $.post("http://3.96.217.5/lib/libListarServicosAgendados.aspx", { e: localStorage.getItem("usuarioLogado"),diaSelecionado:localStorage.getItem("diaSelecionado") }, function (retorno) {

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
