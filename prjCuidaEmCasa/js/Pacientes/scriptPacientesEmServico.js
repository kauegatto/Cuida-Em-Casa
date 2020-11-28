export default function scriptPacientesEmServico () {

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
    
    var retorno;
    $.post("../../lib/libPacientesEmServico.aspx", { usuarioLogado: localStorage.getItem("usuarioLogado") }, function (retorno) {

        if (retorno == "erro") {
           // $('#wrapper-pacienteServico').html("ERRO NO RETORNO");
           alertIonic("Houve um erro!");
        }

        else if (retorno == "") {
            $('#wrapper-pacienteServico').html("<span style='text-align:center;display:block;font-family:Rubik;font-weight:800;'>Nenhum de seus clientes está em serviço!</span>");
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

}