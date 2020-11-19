export default function EnviarFinalizarServico(){

    $.post("../../lib/libFinalizarServico.aspx", { dtInicioServico: localStorage.getItem("data"), horaInicio: localStorage.getItem("horaInicio"), horaFim: localStorage.getItem("horaFim"), cep: localStorage.getItem("cepEndereco"), cidade: localStorage.getItem("nomeCidade"), bairro: localStorage.getItem("nomeBairro"), rua: localStorage.getItem("nomeRua"), num: localStorage.getItem("numEndereco"), estado: localStorage.getItem("nomeEstado"), comp: localStorage.getItem("nomeComplemento"), cliente: localStorage.getItem("usuarioLogado"), cuidador: localStorage.getItem("emailCuidador"), cdPaciente: localStorage.getItem("cdPaciente")}, function (retorno)
    {
        retorno = retorno.split("|");
        if (!retorno[0]) {
            alert("erro na hora de cadastrar serviço");
        }
        else {
            localStorage.setItem("cdServico",retorno[1]);
            
            window.location.href = "../../pages/pagamento.html";
        }
    });
};