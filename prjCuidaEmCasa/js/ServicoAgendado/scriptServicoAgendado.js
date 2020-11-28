export default function scriptServicoAgendado() {

    function alertIonic(text) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

    $.post("../../lib/libListarServicosAgendados.aspx", { e: localStorage.getItem("usuarioLogado"),diaSelecionado:localStorage.getItem("diaSelecionado") }, function (retorno) {

        if (retorno == "erro") {
            //console.log("deu erro");
            alertIonic('Houve um erro');
        }
        else 
        {
            $("#listaServicosAgendados").html(retorno);
            
            $(".areaAgendaConteudo").each(function (i, obj) {
                var url = "data:image/png;base64," + $(this).children('.invi').html();
                $(this).children(".areaImagemPacienteAgendamento").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });
        }
    });
};
