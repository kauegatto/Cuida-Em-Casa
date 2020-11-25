export default function scriptInfoServicoAtual(cdServico) {
    var retorno;
    var map = document.getElementById('map');
    var img = document.createElement('img'); 
    $.post("../../lib/libInfoServicoAtual.aspx", { cdServico: cdServico}, function (retorno) {

        if (!retorno) {
            $('#wrapper-ServicoAtual').html("ERRO NO RETORNO");
        }
        else {

            $('#wrapper-ServicoAtual').html(retorno);

            $(".areaDadosBuscandoCuidadores").each(function (i, obj) {
                var url = "data:image/svg+xml;base64," + $(this).children('.invi').html();
                $(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
                var endereco =  $("#informacoesEndereco").html();
                var apimaps = "";
                img.src =  'https://maps.googleapis.com/maps/api/staticmap?center='+ endereco+'&zoom=13&size=300x300&maptype=roadmap&markers=color:blue|label:k|'+endereco+'&key='+ apimaps;
                $("#map").html("");
                document.getElementById('map').appendChild(img); 

            });
        }
    });

}