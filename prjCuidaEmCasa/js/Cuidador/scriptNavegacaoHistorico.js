﻿import scriptFiltroServico from "./scriptFiltroServico.js";
import scriptHistoricoServico from "./scriptHistoricoServico.js";
import scriptDetalhesServico from "./scriptDetalhesServico.js";

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

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        var classes = $(this).parent().attr("class").split(/\s+/);
        scriptDetalhesServico(classes[1]);
        $("#wrapper-AreaDadosPaciente").addClass("visivel");

        $('#headerNav').addClass("visivel");

        $('#tituloGeral-Nav').html("Informações do serviço");
        colocarImagem();
    });

});