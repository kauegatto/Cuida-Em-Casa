export default function finalizarServicoAgora() {
    
    $.post("../../lib/libFinalizarServicoAgora.aspx", { dtInicioServico: localStorage.getItem("data"), horaInicio: localStorage.getItem("horaAtual"), horaFim: localStorage.getItem("horaFinal"), cep: localStorage.getItem("cepEndereco"), cidade: localStorage.getItem("nomeCidade"), bairro: localStorage.getItem("nomeBairro"), rua: localStorage.getItem("nomeRua"), num: localStorage.getItem("numEndereco"), estado: localStorage.getItem("nomeEstado"), comp: localStorage.getItem("nomeComplemento"), cliente: localStorage.getItem("usuarioLogado"), cdPaciente: localStorage.getItem("cdPaciente"), valorMaximo: localStorage.getItem("valorMaximo") }, function (retorno)
    {
        if (!retorno) {
            console.log("erro na hora de cadastrar serviço");
        }
    });
};