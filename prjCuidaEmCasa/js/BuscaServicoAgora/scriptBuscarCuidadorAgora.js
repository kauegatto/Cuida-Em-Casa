export default function scriptBuscarCuidadorAgora() {


        
    $.post("../../lib/libBuscarCuidadorAgora.aspx", { usuario: localStorage.getItem("usuarioLogado"), cdUsado: localStorage.getItem("cdUsado") }, function(retorno){
        if (retorno == "erro") {
            console.log("deu errado no usuario");
        }

        retorno = retorno.split("|");
        if (retorno[0] == "") {
            $(".areaServicoEncontrado").css("display", "none");
        }  
        $(".areaServicoEncontrado").html(retorno[0]);
        localStorage.setItem("cdUsado", retorno[1]);
        console.log("tá contando");
    })

};