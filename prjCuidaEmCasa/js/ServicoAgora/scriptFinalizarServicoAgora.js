export default function finalizarServicoAgora() {
    
    $.post("../../lib/libFinalizarServicoAgora.aspx", { dtInicioServico: localStorage.getItem("data"), horaInicio: localStorage.getItem("horaAtual"), horaFim: localStorage.getItem("horaFinal"), cep: localStorage.getItem("cepEndereco"), cidade: localStorage.getItem("nomeCidade"), bairro: localStorage.getItem("nomeBairro"), rua: localStorage.getItem("nomeRua"), num: localStorage.getItem("numEndereco"), estado: localStorage.getItem("nomeEstado"), comp: localStorage.getItem("nomeComplemento"), cliente: localStorage.getItem("usuarioLogado"), cdPaciente: localStorage.getItem("cdPaciente")}, function (retorno)
    {
        retorno = retorno.split("|");
        if (!retorno[0]) {
            alert("erro na hora de cadastrar serviço");
        }
        localStorage.setItem("cdServicoAgora", retorno[1].toString());
    });

    $.post("../../lib/libBuscarCuidadorAgora.aspx", { vl: $("#valorHora").val(), cd: localStorage.getitem("cdServicoAgora") }, function(retorno){
        if (retorno == "erro") {
            console.log("deu errado o valor");
        }
        console.log("passou o valor máximo");
    })

};