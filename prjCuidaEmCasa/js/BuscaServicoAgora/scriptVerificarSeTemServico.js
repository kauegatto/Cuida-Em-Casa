export default function scriptVerificarSeTemServico(){

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

    $.post("../../lib/libVerificarSeTemServico.aspx", { emailCuidador: localStorage.getItem("usuarioLogado") }, function (retorno) {
        retorno = retorno.replace("</html>", "").trim();
        console.log(retorno);
        if (retorno == "erro") {
            //console.log("deu errado");
            alertErro('Houve um erro');
        }
        
        if (retorno == "false") {
            $('.areaDisponibilidade').css("display", "block");
        }  
        else {
            $('#body').css('background', '#FFF');
            retorno = retorno.split("&");
            $('.areaDisponibilidade').css("display", "none");
            $('#wrapper-infoServico').addClass("visivel");
            $('#wrapper-infoServico').css("display", "block");
            $('#wrapper-infoServico').html(retorno[0]);
            localStorage.setItem("cdServico", retorno[1])
            var url = "data:image/png;base64," + $('.invi').html();
            $(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            var map = document.getElementById('map');
            var img = document.createElement('img'); 
            var enderecoCompleto = $("#enderecoCompleto").html();
            var apimaps = "";

            img.src =  'https://maps.googleapis.com/maps/api/staticmap?center='+ enderecoCompleto +'&zoom=13&size=300x300&maptype=roadmap&markers=color:blue|label:k|'+endereco+'&key='+ apimaps;
            img.alt = 'mapa que mostra localização do endereço do servico';
            document.getElementById('map').appendChild(img); 
        }         
    });

};