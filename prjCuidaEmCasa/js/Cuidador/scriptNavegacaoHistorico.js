﻿import scriptFiltroServico from "./scriptFiltroServico.js";
import scriptHistoricoServico from "./scriptHistoricoServico.js";
import scriptDetalhesServico from "./scriptDetalhesServico.js";
import scriptDenunciarServico from "./scriptDenunciarServico.js";

$(document).ready(function () {

    if(!localStorage.getItem("tipoUsuario") == 3){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    }

    scriptHistoricoServico();


 	$(".iconeVoltar").click(function () {

    	$(".visivel").each(function (i, obj) {
	       $(this).removeClass("visivel");
	    });
        
        $("#wrapper-detalhesServico").css("display","none");


	    $("#wrapper-historicoServico").addClass("visivel");
	    $('#headerComum').addClass("visivel");

        scriptHistoricoServico();

    });

    $(document).on("click", ".areaHistorico", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        var classes = $(this).attr("class").split(/\s+/);

        scriptDetalhesServico(classes[1]);
        localStorage.setItem('cdServico', classes[1]);

        $("#wrapper-historicoServico").css("display","none");
        $('#headerComum').css("display","none");
        $(".areaFiltro").css("display","none");


        $("#wrapper-detalhesServico").addClass("visivel");
        $('#headerNav').addClass("visivel");
        $('#tituloGeral-Nav').html("Informações do serviço");

    });

    $("#btnFiltroServico").click(function () {
        scriptFiltroServico();
    });

    $(document).on("click", ".btnDenunciar", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });
        console.log("clicou");
        $("#wrapper-detalhesServico").css("display","none");
        $('#headerComum').css("display","none");
 
        $("#wrapper-areaDenunciaServico").addClass("visivel");
        $('#headerNav').addClass("visivel");

        $('.tituloGeral').html("Denunciar Paciente");

        localStorage.setItem("nomePaciente", $('.nomePacienteHistorico').html());

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

        $('.relateProblema2').html('Relate o seu problema com o paciente ' + localStorage.getItem("nomePaciente") +', para que possamos ajudar da melhor forma ');
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

        $('.relateProblema2').html('Relate o seu problema com o paciente ' + localStorage.getItem("nomePaciente") +', para que possamos ajudar da melhor forma ');
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

        $('.relateProblema2').html('Relate o seu problema com o paciente ' + localStorage.getItem("nomePaciente") +', para que possamos ajudar da melhor forma ');
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

        $('.relateProblema2').html('Relate o seu problema com o paciente ' + localStorage.getItem("nomePaciente") +', para que possamos ajudar da melhor forma ');
        localStorage.setItem('cdTipoDenuncia', 4);
    });

    $('.btnEnviarDenuncia2').click(function(){
        
        scriptDenunciarServico(localStorage.getItem('usuarioLogado'), $('.areaRelatarProblema2').val(), localStorage.getItem('cdServico'), localStorage.getItem('cdTipoDenuncia'));

    });

});