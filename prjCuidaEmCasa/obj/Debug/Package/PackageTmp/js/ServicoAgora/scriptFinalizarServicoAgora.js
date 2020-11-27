﻿export default function finalizarServicoAgora() {
    
    $.post("http://3.96.217.5/lib/libFinalizarServicoAgora.aspx", { dtInicioServico: localStorage.getItem("data"), horaInicio: localStorage.getItem("horaAtual"), horaFim: localStorage.getItem("horaFinal"), cep: localStorage.getItem("cepEndereco"), cidade: localStorage.getItem("nomeCidade"), bairro: localStorage.getItem("nomeBairro"), rua: localStorage.getItem("nomeRua"), num: localStorage.getItem("numEndereco"), estado: localStorage.getItem("nomeEstado"), comp: localStorage.getItem("nomeComplemento"), cliente: localStorage.getItem("usuarioLogado"), cdPaciente: localStorage.getItem("cdPaciente"), valorMaximo: localStorage.getItem("valorMaximo") }, function (retorno)
    {
        retorno = retorno.split("|");
        if (!retorno[0]) {
            console.log("erro na hora de cadastrar serviço");
        }

        localStorage.setItem("cdServico", retorno[1]);
    });
};