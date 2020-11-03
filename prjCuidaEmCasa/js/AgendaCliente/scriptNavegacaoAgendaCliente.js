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

    $(document).on("click", ".areaDadosAgendadosHistorico", function(){

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

    $(".btnDenunciar").click(function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        $("#wrapper-areaDetalhesServico").css("display","none");
        $('#headerComum').css("display","none");
 
        $("#wrapper-areaDenunciaServico").addClass("visivel");
        $('#headerNav').addClass("visivel");

        $('.tituloGeral').html("Denunciar Cuidador")

        localStorage.setItem("nomeCuidador", $('#nomeCuidador').html());

    });

    $(document).on("click", "#fp", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        $("#wrapper-areaDenunciaServico").css("display","none");
        $('#headerComum').css("display","none");
 
        $("#wrapper-areaRelatarProblema").addClass("visivel");
        $('#headerNav').addClass("visivel");
        $('.tituloRelatarProblema').html('Falta de Profissionalismo');

        $('.relateProblema').html('Relate o seu problema com o cuidador ' + localStorage.getItem("nomeCuidador") +', para que possamos ajudar da melhor forma ');

    });

    $(document).on("click", "#ci", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        $("#wrapper-areaDenunciaServico").css("display","none");
        $('#headerComum').css("display","none");
 
        $("#wrapper-areaRelatarProblema").addClass("visivel");
        $('#headerNav').addClass("visivel");
        $('.tituloRelatarProblema').html('Conduta inadequada e/ou desespeitosa');

        $('.relateProblema').html('Relate o seu problema com o cuidador ' + localStorage.getItem("nomeCuidador") +', para que possamos ajudar da melhor forma ')
        
    });

    $(document).on("click", "#af", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        $("#wrapper-areaDenunciaServico").css("display","none");
        $('#headerComum').css("display","none");
 
        $("#wrapper-areaRelatarProblema").addClass("visivel");
        $('#headerNav').addClass("visivel");
        $('.tituloRelatarProblema').html('Abuso físico e/ou psicológico');

        $('.relateProblema').html('Relate o seu problema com o cuidador ' + localStorage.getItem("nomeCuidador") +', para que possamos ajudar da melhor forma ')
        
    });

    $(document).on("click", "#afv", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        $("#wrapper-areaDenunciaServico").css("display","none");
        $('#headerComum').css("display","none");
 
        $("#wrapper-areaRelatarProblema").addClass("visivel");
        $('#headerNav').addClass("visivel");
        $('.tituloRelatarProblema').html('Agressão física e/ou verbal');

        $('.relateProblema').html('Relate o seu problema com o cuidador ' + localStorage.getItem("nomeCuidador") +', para que possamos ajudar da melhor forma ')

    });
});