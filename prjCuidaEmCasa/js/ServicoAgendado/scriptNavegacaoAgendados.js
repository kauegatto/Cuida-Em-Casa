import scriptServicoAgendado from "./scriptServicoAgendado.js";
import scriptServicoAgendadoSelecionado from "./scriptServicoAgendadoSelecionado.js";
import scriptCancelarServicoAgendado from "./scriptCancelarServicoAgendado.js";
import scriptCarregarCalendario from "../Cuidador/Disponibilidade/scriptCarregarDisponibilidade.js";


$(document).ready(function () {

    if(!localStorage.getItem("tipoUsuario") == 3){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    };

    scriptServicoAgendado();

    $(document).on("click", "#areaAgendados", function(){
        $('#areaAgendados').removeClass('areaCinza');
        $('#areaAgendados').addClass('areaBranca');
        $('#areaDisponibilidade').removeClass('areaBranca');
        $('#areaDisponibilidade').addClass('areaCinza');
        $('#wrapper-ServicoAgendado').css('display', 'block');
        $('#wrapper-calendarioDisponibilidade').css('display', 'none');
        scriptServicoAgendado();
    });

    $(document).on("click", "#areaDisponibilidade", function(){
        $('#areaDisponibilidade').removeClass('areaCinza');
        $('#areaDisponibilidade').addClass('areaBranca');
        $('#areaAgendados').removeClass('areaBranca');
        $('#areaAgendados').addClass('areaCinza')
        $('#wrapper-ServicoAgendado').css('display', 'none');
        $('#wrapper-calendarioDisponibilidade').css('display', 'block');
        scriptCarregarCalendario();
    });
    

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
