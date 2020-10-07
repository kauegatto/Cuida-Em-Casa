export default function EnviarFinalizarServico(){

    $.post("../../lib/libFinalizarServico.aspx", { dtInicioServico: localStorage.getItem("data"), horaInicio: localStorage.getItem("horaInicio"), horaFim: localStorage.getItem("horaFim"), cep: localStorage.getItem("cepEndereco"), cidade: localStorage.getItem("nomeCidade"), bairro: localStorage.getItem("nomeBairro"), rua: localStorage.getItem("nomeRua"), num: localStorage.getItem("numEndereco"), estado: localStorage.getItem("nomeEstado"), comp: localStorage.getItem("nomeComplemento"), cliente: "flaviapriscilamarianasilveira@gmail.com", cuidador: localStorage.getItem("emailCuidador"), cdPaciente: localStorage.getItem("cdPaciente")}, function (retorno)
    {
        if (!retorno) {
            alert("erro na hora de cadastrar serviço");
        }
        else {
            console.log("passou pra página");
            window.location.href = "../../pages/pedidos.html";
        }
    });
};