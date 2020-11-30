export default function scriptServicoAgora(){
    var map = document.getElementById('map');
    var img = document.createElement('img'); 

    function alertErro(text) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }
   
    $.post("../../lib/libServicoAtual.aspx", { cdServico: localStorage.getItem("cdServico") }, function (retorno) {
        if (!retorno) {
            //console.log("deu errado");
            alertErro('Houve um erro');
            return;
        }

        $('#wrapper-infoServico').html(retorno);
 
		var url = "data:image/png;base64," + $('.invi').html();
        $(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
        console.log('vai se fude caue kaule');
        var endereco =  $("#informacoesEndereco").html();
        var apimaps = "";
        img.src =  'https://maps.googleapis.com/maps/api/staticmap?center='+ endereco+'&zoom=13&size=300x300&maptype=roadmap&markers=color:blue|label:k|'+endereco+'&key='+ apimaps;
        $("#map").html("");
        document.getElementById('map').appendChild(img); 
    });

};