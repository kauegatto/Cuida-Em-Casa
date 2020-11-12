export default function scriptbuscarCuidadorAgora() {

    $.post("../../lib/libBuscarCuidadorAgora.aspx", { usuario: localStorage.getItem("usuarioLogado") }, function(retorno){
        if (retorno == "erro") {
            console.log("deu errado no usuario");
        }
        console.log("passou o usuario");

        $(".areaServicoEncontrado").html(retorno);
    })

};