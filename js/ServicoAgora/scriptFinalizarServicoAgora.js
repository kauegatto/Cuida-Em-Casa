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
    var data = new Date();
    var dia = data.getDate(), mes = (data.getMonth() + 1), ano = data.getFullYear();
    var dataAtual = ano + "-" + mes + "-" + dia
    var hora = data.getHours(), minutos = data.getMinutes(), segundos = data.getSeconds();
    var horaAtual = hora + ":" + minutos + ":" + segundos;
    localStorage.setItem("controle", 0);

    $.post("http://3.96.217.5/lib/libFinalizarServicoAgora.aspx", { diaAtual: dataAtual, horaFim: localStorage.getItem("horaFinal"), horaAtual: horaAtual, control: localStorage.getItem("controle")}, function (retorno)
    {
        localStorage.setItem("dataFinal", retorno);
        localStorage.setItem("controle", 1);
   
        $.post("http://3.96.217.5/lib/libFinalizarServicoAgora.aspx", { diaAtual: dataAtual, control: localStorage.getItem("controle"), dataFinal: localStorage.getItem("dataFinal"), horaFim: localStorage.getItem("horaFinal"), cep: localStorage.getItem("cepEndereco"), cidade: localStorage.getItem("nomeCidade"), bairro: localStorage.getItem("nomeBairro"), rua: localStorage.getItem("nomeRua"), num: localStorage.getItem("numEndereco"), estado: localStorage.getItem("nomeEstado"), comp: localStorage.getItem("nomeComplemento"), cliente: localStorage.getItem("usuarioLogado"), cdPaciente: localStorage.getItem("cdPaciente"), valorMaximo: localStorage.getItem("valorMaximo") }, function (retorno)
        {
            retorno = retorno.split("|");
            if (!retorno[0]) {
                //console.log("erro na hora de cadastrar serviço");
                alertIonic("Houve um erro na hora de cadastrar um serviço!");
            }

            localStorage.setItem("cdServico", retorno[1]);
        });
    });
   
};