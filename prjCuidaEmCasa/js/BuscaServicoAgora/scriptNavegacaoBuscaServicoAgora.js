import scriptBuscarCuidadorAgora from "./scriptBuscarCuidadorAgora.js";

$(document).ready(function () {

    if(!localStorage.getItem("tipoUsuario") == 3){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    }

    localStorage.setItem("cdUsado", "0"); 

    scriptBuscarCuidadorAgora();

    setInterval(scriptBuscarCuidadorAgora, 2000);
    
});