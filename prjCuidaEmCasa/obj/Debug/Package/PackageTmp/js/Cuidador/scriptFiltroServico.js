export default function scriptFiltroServico(){
    
    var recente;
    var filtroEspecializacao = $('#filtroRecente').val();
    var filtroData = $('#filtroData').val();
    
    //console.log(filtroData + " essa é a data");
    
    if (filtroEspecializacao == "Selecione" || filtroEspecializacao == "Mais Recente") { recente = "true"; }
    else { recente = "false"; }
    
    //console.log(recente);
           
    $.post("../../lib/libHistoricoServico.aspx", { filtro: recente, email: localStorage.getItem("usuarioLogado"), data: filtroData }, function (retorno) {
            console.log(retorno);

            if (retorno == "" || retorno == null) {
                $('#wrapper-historicoServico').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Desculpe, mas você não tem nenhum serviço finalizado</h2>");
            }
            
            else if (!retorno || retorno == "false") {
                $('#wrapper-historicoServico').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Erro no retorno</h2>");
            }
            
            $('#wrapper-historicoServico').html(retorno);

            $(".dadosHistorico").each(function (i, obj) {
                var url = "data:image/svg+xml;base64," + $(this).children(".invi").html();
                $(this).children(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");

            });    
    });
}