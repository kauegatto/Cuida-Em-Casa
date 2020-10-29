import scriptAgendaClienteAgendado from './scriptAgendaCliente.js';
import scriptHistoricoClienteAgendado from './scriptHistoricoCliente.js';
import scriptDetalheHistoricoCliente from './scriptDetalheHistoricoCliente.js';

$(document).ready(function(){

	scriptAgendaClienteAgendado();

 	$(".iconeVoltar").click(function () {

		$(".visivel").each(function (i, obj) {
	       $(this).removeClass("visivel");
	    });
	    
	    $("#wrapper-areaHistoricoAgendaCliente").css("display","none");


	    $("#wrapper-areaAgendadosAgendaCliente").addClass("visivel");
	    $('#headerComum').addClass("visivel");

	   scriptAgendaClienteAgendado();

	});


	$(document).on("click", ".areaHistorico", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        $("#wrapper-areaAgendadosAgendaCliente").css("display","none");
        $('#headerComum').css("display","none");
 

        $("#wrapper-areaHistoricoAgendaCliente").addClass("visivel");
        $('#headerNav').addClass("visivel");

        scriptHistoricoClienteAgendado();

    });

    $(document).on("click", ".areaAgendados", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });
      
        $("#wrapper-areaHistoricoAgendaCliente").css("display","none");
        $('#headerNav').css("display","none");
 

        $("#wrapper-areaAgendadosAgendaCliente").addClass("visivel");
        $('#headerComum').addClass("visivel");

         scriptAgendaClienteAgendado();

    });

    $(document).on("click", ".areaDadosAgendados", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        var classes = $(this).attr("class").split(/\s+/);

        scriptDetalheHistoricoCliente(classes[1]);
      
        $("#wrapper-areaHistoricoAgendaCliente").css("display","none");
        $('#headerComum').css("display","none");
 
        $("#wrapper-areaDetalhesServico").addClass("visivel");
        $('#headerNav').addClass("visivel");
        

    });


});