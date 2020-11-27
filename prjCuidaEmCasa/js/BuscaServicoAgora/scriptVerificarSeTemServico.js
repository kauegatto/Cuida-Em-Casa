export default function scriptVerificarSeTemServico(){

    $.post("../../lib/libVerificarSeTemServico.aspx", { emailCuidador: localStorage.getItem("usuarioLogado") }, function (retorno) {
        retorno = retorno.replace("</html>", "").trim();
        console.log(retorno);
        if (retorno == "erro") {
            console.log("deu errado");
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