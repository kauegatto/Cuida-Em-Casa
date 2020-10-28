﻿import scriptFiltroServico from "./scriptFiltroServico.js";
import scriptHistoricoServico from "./scriptHistoricoServico.js";
import scriptDetalhesServico from "./scriptDetalhesServico.js";

$(document).ready(function () {

    if(!localStorage.getItem("tipoUsuario") == 3){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    }

    scriptHistoricoServico();


 	$(".iconeVoltar").click(function () {

    	$(".visivel").each(function (i, obj) {
	       $(this).removeClass("visivel");
	    });
        
        $("#wrapper-detalhesServico").css("display","none");


	    $("#wrapper-historicoServico").addClass("visivel");
	    $('#headerComum').addClass("visivel");

        scriptHistoricoServico();

    });

    $(document).on("click", ".areaHistorico", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        var classes = $(this).attr("class").split(/\s+/);

        scriptDetalhesServico(classes[1]);
      
        $("#wrapper-historicoServico").css("display","none");
        $('#headerComum').css("display","none");
        $(".areaFiltro").css("display","none");


        $("#wrapper-detalhesServico").addClass("visivel");
        $('#headerNav').addClass("visivel");
        $('#tituloGeral-Nav').html("Informações do serviço");

    });

    $("#btnFiltroServico").click(function () {
        scriptFiltroServico();
    });

});