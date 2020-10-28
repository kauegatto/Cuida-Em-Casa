export default function carregarFinalizarServico() {

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
        $('#valorFinal').html(valorFinal.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }));
        return;
    }

    $('.invi').html(localStorage.getItem("imagemCuidador"));
    $(".areaDadosServico").each(function (i, obj) {
        var url = "data:image/png;base64," + $(this).children('.invi').html();
        $(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
    });

    somaHoraValorFinal();
    formatarData(data);
    $('#nomeCuidador').html(localStorage.getItem("nomeCuidador"));
    if (localStorage.getItem("nomeComplemento") != "") {
        $('#endereco').html(localStorage.getItem("nomeRua") + " - " + localStorage.getItem("numEndereco") + ", " + localStorage.getItem("nomeComplemento") + ", " + localStorage.getItem("nomeBairro") + ", " + localStorage.getItem("nomeCidade") + " - " + localStorage.getItem("nomeEstado"));
    }
    else {
        $('#endereco').html(localStorage.getItem("nomeRua") + " - " + localStorage.getItem("numEndereco") + ", " + localStorage.getItem("nomeBairro") + ", " + localStorage.getItem("nomeCidade") + " - " + localStorage.getItem("nomeEstado"));
    }

    

};
