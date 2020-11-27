export default function scriptServicoAgora(){
    var map = document.getElementById('map');
    var img = document.createElement('img'); 
   
    $.post("http://3.96.217.5/lib/libServicoAtual.aspx", { cdServico: localStorage.getItem("cdServico") }, function (retorno) {
        if (!retorno) {
            console.log("deu errado");
            return;
        }

        $('#wrapper-infoServico').html(retorno);

        $(".areaInfoPaciente").each(function (i, obj) {
			var url = "data:image/png;base64," + $(this).children('.invi').html();
            $(this).children(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
        });
        var endereco =  $("#informacoesEndereco").html();
        var apimaps = "";
        img.src =  'https://maps.googleapis.com/maps/api/staticmap?center='+ endereco+'&zoom=13&size=300x300&maptype=roadmap&markers=color:blue|label:k|'+endereco+'&key='+ apimaps;
        $("#map").html("");
        document.getElementById('map').appendChild(img); 
    });

};