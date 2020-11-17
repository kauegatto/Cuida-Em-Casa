export default function scriptBuscarCuidadorAgora() {

    $.post("../../lib/libBuscarCuidadorAgora.aspx", { usuario: localStorage.getItem("usuarioLogado"), indice: localStorage.getItem("indice") }, function(retorno){
            

        if (retorno == "erro") {
            console.log("deu errado no usuario");
        }

        if (retorno == "") {
            $(".areaServicoEncontrado").css("display", "none");
        }  
        else {
            $(".areaServicoEncontrado").html(retorno);
            localStorage.setItem("indice", "1");
        }
    });
};