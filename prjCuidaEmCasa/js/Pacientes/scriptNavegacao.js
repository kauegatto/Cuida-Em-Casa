import scriptPacientes from "./scriptPacientes.js";
import scriptBuscarDadosPaciente from "./scriptBuscarDadosPaciente.js";
import scriptEditarDadosPaciente from "./scriptEditarDadosPaciente.js";
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
        $('#tituloGeral-Nav').html("Adicionar Paciente");
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
        var classes = $(this).parent().attr("class").split(/\s+/);
        localStorage.setItem("cdPaciente", classes[1]);
        $('#tituloGeral-Nav').html("Editar Paciente;");
        scriptBuscarDadosPaciente();
    });

    $(document).on("click", ".btnSalvar", function(){
        scriptEditarDadosPaciente();
        $(".iconeVoltar").click();
        $("#listaPacientes").html("");        
        scriptPacientes();
       
    });
});