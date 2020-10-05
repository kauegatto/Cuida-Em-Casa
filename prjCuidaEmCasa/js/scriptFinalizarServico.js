$(document).ready(function () {

    var data = localStorage.getItem("data");
    var data_formatada;
    var horaInicio = localStorage.getItem("horaInicio");
    var horaSomada = localStorage.getItem("qtdHoras");
    var valorFinal;

    function formatarData(data) {
        var split = data.split('-');
        data_formatada = split[2] + "/" + split[1];
        $('#dataFinal').html(data_formatada);
        return;
    }

    function formatarDataVirarDia(data) {
        var split = data.split('-');
        data_formatada = split[2] + "/" + split[1] + " - " + (parseInt(split[2]) + 1) + "/" + split[1];
        $('#dataFinal').html(data_formatada);
        return;
    }

    //    function somaHoraValorFinal(horaInicio, horaSomada) {
    //        horaIni = horaInicio.split(':');
    //        horaSom = horaSomada.split(':');
    //        horasTotal = parseInt(horaIni[0], 10) + parseInt(horaSom[0], 10);
    //        minutosTotal = parseInt(horaIni[1], 10) + parseInt(horaSom[1], 10);

    //        if (minutosTotal >= 60) {
    //            minutosTotal -= 60; horasTotal += 1;
    //        }
    //        if (horasTotal > 24) {
    //            horasTotal -= 24;
    //            if (horasTotal < 10) {
    //                horasTotal = "0" + horasTotal;
    //            }
    //            formatarDataVirarDia(data);
    //        }
    //        else {
    //            formatarData(data);
    //        }
    //        if (minutosTotal < 10) {
    //            minutosTotal = "0" + minutosTotal;
    //        }
    //        horaFinal = horasTotal + ":" + minutosTotal;
    //        $('#horaFinal').html(localStorage.getItem("horaInicio") + " - " + horaFinal);

    //        //Saber vavlor / hora
    //        horaSom[0] *= 60;
    //        horaMinuto = parseInt(horaSom[0]) + parseInt(horaSom[1]);
    //        valorFinal = horaMinuto * (parseInt(localStorage.getItem("valorHora")) / 60);
    //        console.log(horaMinuto);
    //        $('#valorFinal').html(valorFinal.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }));
    //        return;
    //    }

    somaHoraValorFinal(horaInicio, horaSomada);
    $('#nomeCuidador').html(localStorage.getItem("nomeCuidador"));
    $('#endereco').html(localStorage.getItem("enderecoServico"));
});