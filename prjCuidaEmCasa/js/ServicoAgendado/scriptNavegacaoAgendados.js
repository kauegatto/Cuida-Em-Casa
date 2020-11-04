import scriptServicoAgendado from "./scriptServicoAgendado.js";
import scriptServicoAgendadoSelecionado from "./scriptServicoAgendadoSelecionado.js";
import scriptCancelarServicoAgendado from "./scriptCancelarServicoAgendado.js";

$(document).ready(function () {

    if(!localStorage.getItem("tipoUsuario") == 3){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    };

    scriptServicoAgendado();

 	$(".iconeVoltar").click(function () {

    	$(".visivel").each(function (i, obj) {
	       $(this).removeClass("visivel");
	    });
        
        $("#wrapper-InfoServicoAgendado").css("display","none");


	    $("#wrapper-ServicoAgendado").addClass("visivel");
	    $('#headerComum').addClass("visivel");

        scriptServicoAgendado();

    });

    var classes;

    $(document).on("click", ".areaAgendaConteudo", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        classes = $(this).attr("class").split(/\s+/);
       
        scriptServicoAgendadoSelecionado(classes[1]);
      
        $("#wrapper-ServicoAgendado").css("display","none");
        $('#headerComum').css("display","none");
        $(".areaFiltro").css("display","none");


        $("#wrapper-InfoServicoAgendado").addClass("visivel");
        $('#headerNav').addClass("visivel");
        $('#tituloGeral-Nav').html("Informações do serviço");
    });

    $(document).on("click", ".btnCancelarServico", function(){
        
        scriptCancelarServicoAgendado(classes[1]);
        
        $(".visivel").each(function (i, obj) {
            $(this).removeClass("visivel");
        });

        $("#wrapper-InfoServicoAgendado").css("display","none");


        $("#wrapper-ServicoAgendado").addClass("visivel");
        $('#headerComum').addClass("visivel");

        scriptServicoAgendado();
    });
});
