﻿import scriptPacientes from "./scriptPacientes.js";
import scriptBuscarDadosPaciente from "./scriptBuscarDadosPaciente.js";
import scriptEditarDadosPaciente from "./scriptEditarDadosPaciente.js";
import scriptAdicionarPaciente from "./scriptAdicionarPaciente.js";
import scriptExcluirPaciente from "./scriptExcluirPaciente.js";

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
        $.post('http://3.96.217.5/lib/libListarNecessidades.aspx', {}, function(retorno){

            if (retorno == 'erro') 
            {
                console.log('deu erro na lib de listar as necessidades');
            }
            else
            {
                $('#selectAlterarNecessidade').html(retorno);
                console.log('necessidades cadastradas');
            }

    });

    });

 	$(".iconeVoltar").click(function () {
    	$(".visivel").each(function (i, obj) {
	       $(this).removeClass("visivel");
	    });
	    $("#wrapper-AreaPaciente").addClass("visivel");
	    $('#headerComum').addClass("visivel");
    });

    $(document).on("click", "#areaAlterarImagemPaciente", function(){

        $('#uploadImgUsuario').trigger('click');

    });

    var c = 0;
    var cdNecessidade = "";

    $('#addNecessidade').click(function(){

        if (c > 0) {
            $('#necessidadeEscolhida').html($('#necessidadeEscolhida').html() + ", " + $('#txtAlterarNecessidadePaciente option:selected').html());
            //$('#especializacaoCuidador').prop('disabled', true);          
            cdNecessidade += ";" + $('#txtAlterarNecessidadePaciente').val() ;
            console.log(cdNecessidade);
            var id = $('#txtAlterarNecessidadePaciente').children(":selected").attr("id");
            $("#"+id).prop('disabled',true);
        }
        else
        {
            c++;
            $('#necessidadeEscolhida').html($('#txtAlterarNecessidadePaciente option:selected').html());
            //$('#especializacaoCuidador').prop('disabled', true);
            cdNecessidade += $('#txtAlterarNecessidadePaciente').val();
            console.log(cdNecessidade);
            var id = $('#txtAlterarNecessidadePaciente').children(":selected").attr("id");
            $("#"+id).prop('disabled',true);
        }

        $('#areaTxtNecessidade').css('display','block');
        localStorage.setItem('necessidadeEscolhida', cdNecessidade);

    });

    var c2 = 0;
    var cdNecessidade2 = "";

    $('#addNecessidadeAddPaciente').click(function(){

        if (c2 > 0) {
            $('#necessidadeEscolhida2').html($('#necessidadeEscolhida2').html() + ", " + $('#selectAlterarNecessidade option:selected').html());
            //$('#especializacaoCuidador').prop('disabled', true);          
            cdNecessidade2 += ";" + $('#selectAlterarNecessidade').val() ;
            console.log(cdNecessidade2);
            var id = $('#selectAlterarNecessidade').children(":selected").attr("id");
            $("#"+id).prop('disabled',true);
        }
        else
        {
            c2++;
            $('#necessidadeEscolhida2').html($('#selectAlterarNecessidade option:selected').html());
            //$('#especializacaoCuidador').prop('disabled', true);
            cdNecessidade2 += $('#selectAlterarNecessidade').val();
            console.log(cdNecessidade2);
            var id = $('#selectAlterarNecessidade').children(":selected").attr("id");
            $("#"+id).prop('disabled',true);
        }

        $('#areaTxtNecessidade2').css('display','block');
        localStorage.setItem('necessidadeEscolhida', cdNecessidade2);

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

        $("#listaPacientes").html("");  
        scriptEditarDadosPaciente();

        
        $(".iconeVoltar").click();
       
    });

    $(document).on("click", "#btnSalvarPaciente", function(){
       $("#listaPacientes").html(""); 

        scriptAdicionarPaciente();

        $(".iconeVoltar").click();
      
        //scriptPacientes();
       
    });

    $('.btnExcluir').click(function(){

        scriptExcluirPaciente();
        $(".iconeVoltar").click();
        $("#listaPacientes").html(""); 

    });


});