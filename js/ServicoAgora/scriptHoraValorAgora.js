export default function scriptHoraValorAgora() {
        
        var txt_duracao = $("#duracao").val();
        var time = new Date();
        var horaAtual = time.getHours() + ":" + time.getMinutes();
        var diaAtual = time.getFullYear() + "-" + time.getMonth() + "-" + time.getDate();
        console.log(horaAtual + " hora de agora");
        console.log(diaAtual + " dia de hoje");
        var valorMaximo = $("#valorHora").val();

        var horaIni = horaAtual.split(':');
        var horaSom = txt_duracao.split(':');
        var horasTotal = parseInt(horaIni[0], 10) + parseInt(horaSom[0], 10);
        var minutosTotal = parseInt(horaIni[1], 10) + parseInt(horaSom[1], 10);

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
        var horaFinal = horasTotal + ":" + minutosTotal;

        localStorage.setItem("duracaoAgora", txt_duracao);
        localStorage.setItem("horaAtual", horaAtual);
        localStorage.setItem("horaFinal", horaFinal);
        localStorage.setItem("valorMaximo", valorMaximo);
        localStorage.setItem("data", diaAtual);

        $.post("http://3.96.217.5/lib/libBuscarServicoAgora.aspx", { du: localStorage.getItem("duracaoAgora"), ha: localStorage.getItem("horaAtual"), da: diaAtual, hf: localStorage.getItem("horaFinal") }, function (retorno) {
            localStorage.setItem("dataFim", retorno);
        });
}