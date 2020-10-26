import scriptPacientes from "./scriptPacientes.js";
import scriptBuscarDadosPaciente from "./scriptBuscarDadosPaciente.js";

var indexPage = 0; var jump = 0;

$(".iconeVoltar").click(function(){    
});

$(document).ready(function () {

    scriptPacientes();

    $(".btnAdicionar").click(function () {
    	$(".visivel").each(function (i, obj) {
	       $(this).removeClass("visivel");
	    });
    	$('#wrapper-AreaPaciente').css("display","none");
    	$('#wrapper-AreaDadosPaciente').css("display","none");
    	$('#headerComum').css("display","none");
    	$('#wrapper-areaAdicionarPaciente').addClass("visivel");
    	$('#headerNav').addClass("visivel");
    });

 	$(".iconeVoltar").click(function () {
    	$(".visivel").each(function (i, obj) {
	       $(this).removeClass("visivel");
	    });
	    $("#wrapper-AreaPaciente").addClass("visivel");
	    $('#headerComum').addClass("visivel");
    });

    $(document).on("click", ".imgEditar", function(){
        
        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });
        $('#wrapper-AreaPaciente').css("display","none");
        $('#wrapper-AreaDadosPaciente').css("display","none");
        $('#headerComum').css("display","none");

        $("#wrapper-AreaDadosPaciente").addClass("visivel");
        $('#headerNav').addClass("visivel");
        scriptBuscarDadosPaciente();
    });

});