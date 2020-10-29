import scriptAgendaClienteAgendado from './scriptAgendaCliente.js';
import scriptHistoricoClienteAgendado from './scriptHistoricoCliente.js';

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

});