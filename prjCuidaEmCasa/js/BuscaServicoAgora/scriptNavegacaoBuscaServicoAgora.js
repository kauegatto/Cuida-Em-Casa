import scriptBuscarCuidadorAgora from "./scriptBuscarCuidadorAgora.js";
import scriptDetalhesServicoAgora from "./scriptDetalhesServicoAgora.js";
import scriptAceitarServico from "./scriptAceitarServico.js";
import scriptDisponibilidadeCuidador from "./scriptDisponibilidadeCuidador.js";


$(document).ready(function () {

    if(!localStorage.getItem("tipoUsuario") == 3){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    }

    localStorage.setItem("indice", "0");

    $(document).on("click", ".btnVerMaisServicoEncontrado", function(){
        
        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        var classes = $(this).attr("class").split(/\s+/);

        scriptDetalhesServicoAgora(classes[1]);
        localStorage.setItem('cdServico', classes[1]);

        $(".areaServicoEncontrado").css("display","none");
        $(".areaDisponibilidade").css("display","none");
        $('#headerComum').css("display","none");


        $("#wrapper-detalhesServico").addClass("visivel");
        $('#headerNav').addClass("visivel");
        $('#tituloGeral-Nav').html("Informações do serviço");

    });

    $(document).on("click", ".btnConfirmar", function(){

        scriptAceitarServico();

    });

    $(document).on("click", ".btnRecusar", function(){
        
        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        $("#wrapper-detalhesServico").css("display","none");

        $(".areaServicoEncontrado").addClass("visivel");
        $(".areaDisponibilidade").addClass("visivel");
        $('#tituloGeral-Nav').html("Buscar Serviço");

        scriptBuscarCuidadorAgora();

    });

    $(document).on("click", ".areaDisponibilidade", function(){

    	var classes = $(this).attr("class").split(/\s+/);

        scriptDisponibilidadeCuidador(classes[1]);

        scriptBuscarCuidadorAgora();

        setInterval(scriptBuscarCuidadorAgora, 10000);
    	
    });
    
});