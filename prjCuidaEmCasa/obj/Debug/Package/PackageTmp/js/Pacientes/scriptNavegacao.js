import scriptPacientes from "./scriptPacientes.js";
import scriptBuscarDadosPaciente from "./scriptBuscarDadosPaciente.js";
import scriptEditarDadosPaciente from "./scriptEditarDadosPaciente.js";
import scriptAdicionarPaciente from "./scriptAdicionarPaciente.js";

var indexPage = 0; var jump = 0;

$(".iconeVoltar").click(function(){    
});

$(document).ready(function () {
    
    if(!localStorage.getItem("tipoUsuario") == 2){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    }

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
        $('#tituloGeral-Nav').css("margin-right","56px");
        $('#tituloGeral-Nav').css("margin-left","0");
        $('#tituloGeral-Nav').css("width","204");
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
        $('#tituloGeral-Nav').html("Editar Paciente");
        $('#tituloGeral-Nav').css("margin-top","45px");
        $('#tituloGeral-Nav').css("margin-left","23px");
        scriptBuscarDadosPaciente();
    });

    $(document).on("click", ".btnSalvar", function(){
        scriptEditarDadosPaciente();
        $(".iconeVoltar").click();
        $("#listaPacientes").html("");        
        scriptPacientes();
       
    });

    $(document).on("click", "#btnSalvarPaciente", function(){
        scriptAdicionarPaciente();
        $(".iconeVoltar").click();
        $("#listaPacientes").html(""); 
        scriptPacientes();
       
    });

});