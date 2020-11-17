import scriptBuscarCuidadorAgora from "./scriptBuscarCuidadorAgora.js";
import scriptDisponibilidadeCuidador from "./scriptDisponibilidadeCuidador.js";

$(document).ready(function () {

    if(!localStorage.getItem("tipoUsuario") == 3){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    }

    localStorage.setItem("indice", "0");

    scriptBuscarCuidadorAgora();

    setInterval(scriptBuscarCuidadorAgora, 10000);


    $(document).on("click", ".areaDisponibilidade", function(){

    	var classes = $(this).attr("class").split(/\s+/);

        scriptDisponibilidadeCuidador(classes[1]);
    	
    });
    
});