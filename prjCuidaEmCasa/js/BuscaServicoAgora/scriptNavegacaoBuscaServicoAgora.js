import scriptBuscarCuidadorAgora from "./scriptBuscarCuidadorAgora.js";
import scriptDetalhesServicoAgora from "./scriptDetalhesServicoAgora.js";
import scriptAceitarServico from "./scriptAceitarServico.js";
import scriptDisponibilidadeCuidador from "./scriptDisponibilidadeCuidador.js";
import scriptServicoAgora from "./scriptServicoAgora.js";


$(document).ready(function () {

    var interval;

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
        $('#body').css("background", "#f3f3f3");
        clearInterval(interval);

    });

    $(document).on("click", ".btnConfirmar", function(){

        scriptAceitarServico();

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });
        $("#wrapper-detalhesServico").css("display","none");

        scriptServicoAgora();

        $("#wrapper-infoServico").addClass("visivel");

    });

    $(document).on("click", ".btnRecusar", function(){
        
        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        $("#wrapper-detalhesServico").css("display","none");

        $(".areaServicoEncontrado").css("display", "block");
        $(".areaDisponibilidade").addClass("visivel");
        $('#tituloGeral-Nav').html("Buscar Serviço");

        scriptBuscarCuidadorAgora();

        interval = setInterval(scriptBuscarCuidadorAgora, 10000);

    });

    $(document).on("click", ".areaDisponibilidade", function(){

    	var classes = $(this).attr("class").split(/\s+/);

        scriptDisponibilidadeCuidador(classes[1]);

        scriptBuscarCuidadorAgora();

        interval = setInterval(scriptBuscarCuidadorAgora, 10000);
    	
    });
});