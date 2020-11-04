import scriptServicoAgendado from "./scriptServicoAgendado.js";
import scriptServicoAgendadoSelecionado from "./scriptServicoAgendadoSelecionado.js";
import scriptCancelarServicoAgendado from "./scriptCancelarServicoAgendado.js";
import scriptDenunciarServico from "./scriptDenunciarServico.js";

$(document).ready(function () {

    if(!localStorage.getItem("tipoUsuario") == 3){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    }

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

    $(document).on("click", ".areaAgendaConteudo", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        var classes = $(this).attr("class").split(/\s+/);
       
        scriptServicoAgendadoSelecionado(classes[1]);
      
        $("#wrapper-ServicoAgendado").css("display","none");
        $('#headerComum').css("display","none");
        $(".areaFiltro").css("display","none");


        $("#wrapper-InfoServicoAgendado").addClass("visivel");
        $('#headerNav').addClass("visivel");
        $('#tituloGeral-Nav').html("Informações do serviço");

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

    $(".btnDenunciar").click(function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        $("#wrapper-detalhesServico").css("display","none");
        $('#headerComum').css("display","none");
 
        $("#wrapper-areaDenunciaServico").addClass("visivel");
        $('#headerNav').addClass("visivel");

        $('.tituloGeral').html("Denunciar Cuidador");

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
        localStorage.setItem('cdTipoDenuncia', 1);
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
        localStorage.setItem('cdTipoDenuncia', 2);
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
        localStorage.setItem('cdTipoDenuncia', 3);
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
        localStorage.setItem('cdTipoDenuncia', 4);
    });

    $('.btnEnviarDenuncia').click(function(){

        scriptDenunciarServico(localStorage.getItem('usuarioLogado'), $('.areaRelatarProblema').val(), localStorage.getItem('cdServico'), localStorage.getItem('cdTipoDenuncia'));

    });

});