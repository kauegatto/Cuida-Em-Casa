export default function carregarFinalizarServico() {

    var imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
    var data = localStorage.getItem("data");
    var data_formatada;
    var horaInicio = localStorage.getItem("horaInicio");
    var horaSomada = localStorage.getItem("qtdHoras");
    var valorFinal;

    function formatarData(data) {
        var split = data.split('-');
        if (localStorage.getItem("dataFim") != "erro" && localStorage.getItem("dataFim") != null) {
            var dataFimFormatada = localStorage.getItem("dataFim").split('/');
            if (parseInt(dataFimFormatada[0]) < 10) { dataFimFormatada[0] = "0" + dataFimFormatada[0] }
            if (parseInt(dataFimFormatada[1]) < 10) { dataFimFormatada[1] = "0" + dataFimFormatada[1] }
            data_formatada = split[2] + "/" + split[1];
        }
        else {
            data_formatada = split[2] + "/" + split[1];

        }
        $('#dataFinal').html(data_formatada);
        return;
    }

    function somaHoraValorFinal() {

        $('#horaFinal').html(localStorage.getItem("horaInicio") + " - " + localStorage.getItem("horaFim"));

        //Saber vavlor / hora
        var horaSom = horaSomada.split(':');
        horaSom[0] *= 60;
        var horaMinuto = parseInt(horaSom[0]) + parseInt(horaSom[1]);
        var valorFinal = horaMinuto * (parseInt(localStorage.getItem("valorHora")) / 60);
        localStorage.setItem("precoServico",valorFinal);
        $('#valorFinal').html(valorFinal.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }));
        return;
    }

    somaHoraValorFinal();

    formatarData(data);

    $('#nomeCuidador').html(localStorage.getItem("nomeCuidador"));
    if (localStorage.getItem("nomeComplemento") != "") {
        $('#endereco').html(localStorage.getItem("nomeRua") + " - " + localStorage.getItem("numEndereco") + ", " + localStorage.getItem("nomeComplemento") + ", " + localStorage.getItem("nomeBairro") + ", " + localStorage.getItem("nomeCidade") + " - " + localStorage.getItem("nomeEstado"));
    }
    else {
        $('#endereco').html(localStorage.getItem("nomeRua") + " - " + localStorage.getItem("numEndereco") + ", " + localStorage.getItem("nomeBairro") + ", " + localStorage.getItem("nomeCidade") + " - " + localStorage.getItem("nomeEstado"));
    }

    if (localStorage.getItem('imagemCuidador') == imgPadrao) 
    {
        var url = "data:image/svg+xml;base64," + localStorage.getItem("imagemCuidador");
        $(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
    }
    else
    {
        var url = "data:image/jpeg;base64," + localStorage.getItem("imagemCuidador");
        $(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
    }

};
