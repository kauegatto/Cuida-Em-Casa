$(document).ready(function () {

    var filtro = $('.cbxEspecializacao').val();
    var recente;

    if (filtroEspecializacao == "Selecione" || filtroEspecializacao == "Mais Recente") { recente = "true"; }
    else { recente = "false"; }

    $.post("../../lib/libHistoricoServico.aspx", { filtro: recente }, function (retorno) {

});