$(document).ready(function () {

    var botao = 0;
    $.post("../../../lib/libListarCuidadoresAdm.aspx", { control: botao }, function (retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }
        else {
            $('.listaCuidadores').html(retorno);
        }
    });

    $(document).on("click", ".iconeInformacao", function () {
        var classes = $(this).attr("class").split(/\s+/);
        localStorage.setItem("emailCuidador", classes[1]);
    });

    $(document).on("click", "#buscar_filtro", function () {
        var botao = 1;
        var vE, vS, vP, vA, vEm, vG;
        var filtroEspecializacao = $('.cbxEspecializacao').val();
        var filtroStatus = $('.cbxStatus').val();
        var filtroPreco = $('.cbxPreco').val();
        var filtroAvaliacao = $('.cbxAvaliacao').val();
        var filtroEmail = $('.emailCuidador').val() + "%";
        var filtroGenero = $('.cbxGenero').val();
        if (filtroEspecializacao == "0") { vE = "false"; }
        else { vE = "true"; }

        if (filtroStatus == "0") { vS = "false"; }
        else { vS = "true"; }

        if (filtroPreco == "0") { vP = "false"; }
        else { vP = "true"; }

        if (filtroAvaliacao == "0") { vA = "false"; }
        else { vA = "true"; }

        if (filtroEmail == "%") { vEm = "false"; }
        else { vEm = "true"; }

        if (filtroGenero == "0") { vG = "false"; }
        else { vG = "true"; }

        $.post("../../../lib/libListarCuidadoresAdm.aspx", { vE: vE, vS: vS, vP: vP, vA: vA, vEm: vEm, vG: vG, especializacao: filtroEspecializacao, status: filtroStatus, preco: filtroPreco, avaliacao: filtroAvaliacao, emailCuidador: filtroEmail, genero: filtroGenero, control: botao }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else {
                $('.listaCuidadores').html(retorno);
            }
        });
    });

});