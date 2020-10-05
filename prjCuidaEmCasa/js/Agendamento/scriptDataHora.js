$(document).ready(function () {

    function dadosDataHora(horaInicio, horaSomada) {
        var txt_data = $("#data").val();
        var txt_horaInicio = $("#horaInicio").val();
        var txt_qtdHoras = $("#horaFim").val();

        horaIni = horaInicio.split(':');
        horaSom = horaSomada.split(':');
        horasTotal = parseInt(horaIni[0], 10) + parseInt(horaSom[0], 10);
        minutosTotal = parseInt(horaIni[1], 10) + parseInt(horaSom[1], 10);

        if (minutosTotal >= 60) {
            minutosTotal -= 60; horasTotal += 1;
        }
        if (horasTotal > 24) {
            horasTotal -= 24;
            if (horasTotal < 10) {
                horasTotal = "0" + horasTotal;
            }
        }
        if (minutosTotal < 10) {
            minutosTotal = "0" + minutosTotal;
        }
        horaFinal = horasTotal + ":" + minutosTotal;

        localStorage.setItem("data", txt_data);
        localStorage.setItem("horaInicio", txt_horaInicio);
        localStorage.setItem("horaFim", horaFinal);
        localStorage.setItem("qtdHoras", txt_qtdHoras);
        $.post("../../lib/libDadosAgendamento.aspx", { d: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), hf: localStorage.getItem("horaFim"), qtd: localStorage.getItem("qtdHoras") }, function (retorno) {
            localStorage.setItem("dataFim", retorno);
        });
    }

    $(".btnProximo").click(function () {
        dadosDataHora($("#horaInicio").val(), $("#horaFim").val());

        window.location.href = "escolherCuidador.aspx";
        return false;
    });



});