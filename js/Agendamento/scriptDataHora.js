export default function scriptDataHora(horaInicio, horaSomada) {

        function alertIonic(texto) {
          const alert = document.createElement('ion-alert');
          alert.cssClass = 'alertBonito';
          alert.header = 'Atenção';
          alert.subHeader = '';
          alert.message = texto;
          alert.buttons = ['OK'];

          document.body.appendChild(alert);
          return alert.present();
        }

        var txt_data = $("#data").val();
        var txt_horaInicio = $("#horaInicio").val();
        var txt_qtdHoras = $("#horaFim").val();

        //console.log($('#data').val());

        var horaIni = horaInicio.split(':');
        var horaSom = horaSomada.split(':');
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

        console.log(horaFinal);
        localStorage.setItem("data", txt_data);
        localStorage.setItem("horaInicio", txt_horaInicio);
        localStorage.setItem("horaFim", horaFinal);
        localStorage.setItem("qtdHoras", txt_qtdHoras);

        $.post("http://3.96.217.5/lib/libDadosAgendamento.aspx", { d: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), hf: localStorage.getItem("horaFim"), qtd: localStorage.getItem("qtdHoras") }, function (retorno) {
            if (retorno == "erro") 
            {
                alertIonic('Houve um erro!');
            }
            else
            {
                localStorage.setItem("dataFim", retorno);
            }
        });
}
