import scriptPacientes from "./scriptPacientes.js";
import scriptBuscarDadosPaciente from "./scriptBuscarDadosPaciente.js";
import scriptEditarDadosPaciente from "./scriptEditarDadosPaciente.js";
import scriptAdicionarPaciente from "./scriptAdicionarPaciente.js";
import scriptExcluirPaciente from "./scriptExcluirPaciente.js";

var indexPage = 0; var jump = 0;

$(".iconeVoltar").click(function(){    
});

$(document).ready(function () {

    $('#txtAdicionarCEPPaciente').mask('00000-000');

    function alertIonic(text) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }
    
    if(!localStorage.getItem("tipoUsuario") == 2){
        alertIonic("Você não tem acesso a essa página, realize o login novamente");
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
        
        $.post('../../lib/libListarNecessidades.aspx', {}, function(retorno){

            if (retorno == 'erro') 
            {
                //console.log('deu erro na lib de listar as necessidades');
            }
            else
            {
                $('#selectAlterarNecessidade').html(retorno);
                //alertIonic('As necessidades do paciente foram cadastradas com sucesso !');
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

        
        if ($('#txtAlterarComplementoPaciente').val() == "" || $('#txtAlterarNumeroPaciente').val() == "" || $('#txtAlterarNomePaciente').val() == "" || $('#txtAlterarRuaPaciente').val() == "" || $('#txtAlterarBairroPaciente').val() == "" || $('#txtAlterarDescricaoPaciente').val() == "" || $('#txtAlterarCEPPaciente').val() == "" || $('#txtAlterarCidadePaciente').val() == "") 
        {
            if ($('#txtAlterarDescricaoPaciente').val() == "") 
            {
                alertIonic('Digite uma descrição para o paciente!');
                return;
            }

            if ($('#txtAlterarCEPPaciente').val() == "") 
            {
                alertIonic('Digite um CEP para o paciente!');
                return;
            }

            if ($('#txtAlterarCidadePaciente').val() == "") 
            {
                alertIonic('Digite uma cidade para o paciente!');
                return;
            }

            if ($('#txtAlterarBairroPaciente').val() == "") 
            {
                alertIonic('Digite um bairro para o paciente');
                return;
            }

            if ($('#txtAlterarRuaPaciente').val() == "") 
            {
                alertIonic('Digite uma rua para o paciente!');
                return;
            }

            if ($('#txtAlterarNomePaciente').val() == "") 
            {
                alertIonic('Digite um nome para o paciente!');
                return;
            }

            if ($('#txtAlterarNumeroPaciente').val() == "")
            {
                alertIonic('Digite um número número para o paciente!');
                return;
            }

            if ($('#txtAlterarComplementoPaciente').val() == "") 
            {
                 alertIonic('Digite um complemento para o paciente!');
                return;
            }
        }
        else
        {
            scriptEditarDadosPaciente();
            $(".iconeVoltar").click();
        }
           
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