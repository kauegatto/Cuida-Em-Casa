import scriptBuscarCuidadorAgora from "./scriptBuscarCuidadorAgora.js";
import scriptDetalhesServicoAgora from "./scriptDetalhesServicoAgora.js";
import scriptAceitarServico from "./scriptAceitarServico.js";
import scriptDisponibilidadeCuidador from "./scriptDisponibilidadeCuidador.js";
import scriptServicoAgora from "./scriptServicoAgora.js";
import scriptCheckinCheckout from "./scriptCheckinCheckout.js";
import scriptVerificarSeTemServico from "./scriptVerificarSeTemServico.js";

$(document).ready(function () {

    var interval;

    if(!localStorage.getItem("tipoUsuario") == 3){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    }

    localStorage.setItem("indice", "0");

    scriptVerificarSeTemServico();

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

        clearInterval(interval);
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
        $('#body').css("background", "rgba(41, 128, 185, 0.8)");
        interval = setInterval(scriptBuscarCuidadorAgora, 60000);

    });

    $(document).on("click", ".areaDisponibilidade", function(){

    	var classes = $(this).attr("class").split(/\s+/);

        scriptDisponibilidadeCuidador(classes[1]);

        scriptBuscarCuidadorAgora();

        interval = setInterval(scriptBuscarCuidadorAgora, 60000);
    	
    }); 

    $(document).on("click", ".btnCheckin", function(){

        var classes = $(this).attr("class").split(/\s+/);

        scriptCheckinCheckout(classes[1]);

        $(".btnCheckin").css("display", "none");
        $(".btnCheckout").css("display", "block");

    });

    $(document).on("click", ".btnCheckout", function(){

        var classes = $(this).attr("class").split(/\s+/);

        scriptCheckinCheckout(classes[1]);

        window.location.href = "../../pages/cuidador/historicoServico.html";

    });

    $(document).on("click", "#copiarEndereco", function(){
        const endereco = $("#informacoesEndereco").html();

        var dummy = document.createElement("textarea");
        document.body.appendChild(dummy);
        dummy.value = endereco;
        dummy.select();
        dummy.setSelectionRange(0, 99999);
        document.execCommand("copy");
        document.body.removeChild(dummy);
    
    });
});