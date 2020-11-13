export default function scriptBuscarCuidadorAgora() {

    $.post("../../lib/libBuscarCuidadorAgora.aspx", { usuario: localStorage.getItem("usuarioLogado"), cdUsado: localStorage.getItem("cdUsado"), indice: localStorage.getItem("indice") }, function(retorno){
            
        var indice = 1;

        if (retorno == "erro") {
            console.log("deu errado no usuario");
        }

        retorno = retorno.split("|");
        if (retorno[0] == "") {
            $(".areaServicoEncontrado").css("display", "none");
        }  
        else {
            $(".areaServicoEncontrado").html(retorno[0]);
            localStorage.setItem("cdUsado", retorno[1]);
            localStorage.setItem("indice", parseInt(localStorage.getItem("indice")) + indice);
            console.log("tá contando");
            console.log(retorno[1]);
        }
    });
};