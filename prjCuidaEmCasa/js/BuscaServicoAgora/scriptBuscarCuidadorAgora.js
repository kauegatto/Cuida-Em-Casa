export default function scriptBuscarCuidadorAgora() {

    console.log('chamou o metodo');

    $.post("../../lib/libBuscarCuidadorAgora.aspx", { usuario: localStorage.getItem("usuarioLogado"), indice: localStorage.getItem("indice") }, function(retorno){
            
        if (retorno == "erro") {
            console.log("deu errado no usuario");
        }

        if (retorno == "") {
            $(".areaServicoEncontrado").html("");
            $(".areaServicoEncontrado").css("display", "none");
        }  
        else {
            $(".areaServicoEncontrado").html(retorno);
            $(".areaServicoEncontrado").css("display", "block");
            localStorage.setItem("indice", "1");
            console.log('ta contando');
        }
    });
};