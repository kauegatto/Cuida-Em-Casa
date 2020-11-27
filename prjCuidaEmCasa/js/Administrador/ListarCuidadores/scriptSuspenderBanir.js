$(document).ready(function () {

    $(document).on("click", "#aplicar_suspensao", function () {
        var botao = 0;

        $.post("../../../lib/libSuspenderBanir.aspx", { control: botao, emailCuidador: localStorage.getItem("emailCuidador") }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else {
                console.log("suspendeu o cara");
                $('#aplicar_suspensao').css("display", "none");
                $('#remover_suspensao').css("display", "inline");
            }
        });
    });

    $(document).on("click", "#remover_suspensao", function () {
        var botao = 1;

        $.post("../../../lib/libSuspenderBanir.aspx", { control: botao, emailCuidador: localStorage.getItem("emailCuidador") }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else {
                console.log("tirou a suspensão do cara");
                $('#remover_suspensao').css("display", "none");
                $('#aplicar_suspensao').css("display", "inline");
            }
        });
    });

    $(document).on("click", "#banir_cuidador", function () {
        var botao = 2;

        $.post("../../../lib/libSuspenderBanir.aspx", { control: botao, emailCuidador: localStorage.getItem("emailCuidador") }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else {
                console.log("baniu o cara");
                $('#banir_cuidador').css("display", "none");
                $('#aplicar_suspensao').css("display", "none");
                $('#remover_suspensao').css("display", "none");
                $('#desbanir_cuidador').css("display", "inline");
            }
        });
    });

    $(document).on("click", "#desbanir_cuidador", function () {
        var botao = 3;

        $.post("../../../lib/libSuspenderBanir.aspx", { control: botao, emailCuidador: localStorage.getItem("emailCuidador") }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else {
                console.log("desbaniu o cara");
                $('#desbanir_cuidador').css("display", "none");
                $('#aplicar_suspensao').css("display", "inline");
                $('#banir_cuidador').css("display", "inline");
            }
        });
    });

})