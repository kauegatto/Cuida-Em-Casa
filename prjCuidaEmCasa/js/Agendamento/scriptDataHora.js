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

        var txt_data;
        var txt_horaInicio;
        var txt_qtdHoras;

        console.log($('#data').val());
        if ($("#data").val() != "") 
        {
            txt_data = $("#data").val();
        }
        else
        {
            alertIonic('Digite uma data!');
            $('.iconeVoltar').click();
            $('.areaFiltro').css('display', 'none');
            return;
        }

        if ($("#horaInicio").val() != "") 
        {
            txt_horaInicio = $("#horaInicio").val();
        }
        else
        {
            alertIonic('Digite uma hora de início do serviço!');
            $('.iconeVoltar').click();
            $('.areaFiltro').css('display', 'none');
            return;
        }

        if ($("#horaFim").val() != "") 
        {
            txt_qtdHoras = $("#horaFim").val();
        }
        else
        {
            alertIonic('Digite uma hora de fim serviço!');
            $('.iconeVoltar').click();
            $('.areaFiltro').css('display', 'none');
            return;
        }

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

        $.post("../../lib/libDadosAgendamento.aspx", { d: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), hf: localStorage.getItem("horaFim"), qtd: localStorage.getItem("qtdHoras") }, function (retorno) {
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
