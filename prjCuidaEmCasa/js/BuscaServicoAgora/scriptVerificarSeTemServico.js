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
            retorno = retorno.split("&");
            $('.areaDisponibilidade').css("display", "none");
            $('#wrapper-infoServico').addClass("visivel");
            $('#wrapper-infoServico').css("display", "block");
            $('#wrapper-infoServico').html(retorno[0]);
            localStorage.setItem("cdServico", retorno[1])
        }         
    });

};