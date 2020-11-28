export default function scriptVerificarPacienteServico(){

    $.post("../../lib/libVerificarPacienteServico.aspx", { cdPaciente: localStorage.getItem("cdPaciente"), data: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), hf: localStorage.getItem("horaFim") }, function (retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }          
        else {
            if (retorno == "tem") {
                console.log("tá com serviço já");
                $('.iconeVoltar').click();
            }
        }
    });

};