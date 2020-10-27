﻿import scriptFiltroServico from "./scriptFiltroServico.js";
import scriptHistoricoServico from "./scriptHistoricoServico.js";
//import scriptBuscarDetalhesServico from "./scriptBuscarDetalhesServico.js";

$(document).ready(function () {

    scriptHistoricoServico();


 	$(".iconeVoltar").click(function () {
    	$(".visivel").each(function (i, obj) {
	       $(this).removeClass("visivel");
	    });

	    $("#wrapper-historicoServico").addClass("visivel");
	    $('#headerComum').addClass("visivel");
        scriptHistoricoServico();
    });

    $(document).on("click", ".areaHistorico", function(){

        //scriptBuscarDetalhesServico();
        
        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        var classes = $(this).parent().attr("class").split(/\s+/);
        localStorage.setItem("cdServico", classes[1]);

        $("#wrapper-AreaDadosPaciente").addClass("visivel");

        $('#headerNav').addClass("visivel");

        $('#tituloGeral-Nav').html("Informações do serviço");
        colocarImagem();
    });

});