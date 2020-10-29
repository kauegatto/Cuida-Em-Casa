$(document).ready(function() {
    var retorno;
    $.post("../../lib/libPacientesEmServico.aspx", { usuarioLogado: localStorage.getItem("usuarioLogado") }, function (retorno) {

        if (!retorno) {
            $('#wrapper-pacienteServico').html("ERRO NO RETORNO");
        }

        else if (retorno == "") {
            $('#wrapper-pacienteServico').html("Nenhum de seus clientes está em serviço!");
            return;
        }
        else if (retorno == "usuarioIncorreto") { window.location.href = "../index.html" }
        else {
            var btnProx = "";
            $('#listaPacientes').append(retorno);
            $('#wrapper-pacienteServico').append(btnProx);
            $(".areaPaciente").each(function (i, obj) {
                var url = "data:image/png;base64," + $(this).children().eq(3).html();
                $(this).children(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });
        }
    });
});