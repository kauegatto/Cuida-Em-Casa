export default function scriptVerificarPacienteServico(){
    
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

    $.post("http://3.96.217.5/lib/libVerificarPacienteServico.aspx", { cdPaciente: localStorage.getItem("cdPaciente"), data: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), hf: localStorage.getItem("horaFim") }, function (retorno) {
        if (retorno == "false") {
           //console.log("deu erro na lib");
        }          
        else {
            if (retorno == "tem") {
                alertIonic("Este paciente já está em serviço");
                $('.iconeVoltar').click();
            }
        }
    });

};