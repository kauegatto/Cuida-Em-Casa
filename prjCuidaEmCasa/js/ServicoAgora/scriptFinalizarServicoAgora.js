export default function finalizarServicoAgora() {

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
    
    $.post("../../lib/libFinalizarServicoAgora.aspx", { dtInicioServico: localStorage.getItem("data"), horaInicio: localStorage.getItem("horaAtual"), horaFim: localStorage.getItem("horaFinal"), cep: localStorage.getItem("cepEndereco"), cidade: localStorage.getItem("nomeCidade"), bairro: localStorage.getItem("nomeBairro"), rua: localStorage.getItem("nomeRua"), num: localStorage.getItem("numEndereco"), estado: localStorage.getItem("nomeEstado"), comp: localStorage.getItem("nomeComplemento"), cliente: localStorage.getItem("usuarioLogado"), cdPaciente: localStorage.getItem("cdPaciente"), valorMaximo: localStorage.getItem("valorMaximo") }, function (retorno)
    {
        retorno = retorno.split("|");
        if (!retorno[0]) {
            //console.log("erro na hora de cadastrar serviço");
            alertIonic("Houve um erro na hora de cadastrar um serviço!");
        }

        localStorage.setItem("cdServico", retorno[1]);
    });
};