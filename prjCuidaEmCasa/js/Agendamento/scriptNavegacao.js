﻿import scriptPaciente from "./scriptPaciente.js";
import scriptConfirmarEndereco from "./scriptConfirmarEndereco.js";
import scriptAlterarEndereco from "./scriptAlterarEndereco.js";
import scriptDataHora from "./scriptDataHora.js";
import scriptCuidador from "./scriptCuidador.js";
import scriptInfoCuidador from "./scriptInfoCuidador.js";
import carregarFinalizarServico  from "./scriptFinalizarServico.js";
import EnviarFinalizarServico  from "./scriptAgendarServico.js";
import scriptFiltro from "./scriptFiltro.js";
import scriptVerificarPacienteServico from "./scriptVerificarPacienteServico.js";

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


var indexPage = 0; var jump = 0; var DomElement = $("#btnPaciente");

function passarPagina(SentDomElement,Jump) {
    
    $(".conteudoGeral").children().eq(indexPage).addClass("visivel");

    indexPage += Jump;
    DomElement = SentDomElement; // botao que enviou o último click pra chegar na página que estamos

    if(Jump < 0){
        console.log(indexPage);
        if(indexPage>=0){
            $(".visivel").css("display", "none" );
            $(".visivel").removeClass("visivel");
            $(DomElement).parents("main.conteudoGeral").children().eq(indexPage).css( "display", "block");
            $(DomElement).parents("main.conteudoGeral").children().eq(indexPage).addClass("visivel"); 
        }
        else{window.location.href = "../../pages/cliente/atendimento.html"}
       
    }
    else{
        $(".visivel").css("display", "none" );
        
        $(".visivel").removeClass("visivel");

        $(DomElement).parents("main.conteudoGeral").children().eq(indexPage).addClass("visivel"); 
    }   
    
    return;
};    	


$(".iconeVoltar").click(function(){
    
    if(indexPage == 3 ){
        passarPagina(DomElement, -2);
    } 
    else{passarPagina(DomElement, -1);}
});

$(document).ready(function () {


var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!
var yyyy = today.getFullYear();
if(dd<10){
    dd='0'+dd
} 

if(mm<10){
    mm='0'+mm
} 

today = yyyy+'-'+mm+'-'+dd;
$("#data").attr("min", today);


if(!localStorage.getItem("tipoUsuario") == 2){
    alertIonic("Você não tem acesso a essa página, realize o login novamente");
    localStorage.clear();
    window.location.href = "../../pages/index.html";
}

scriptPaciente();

$.post("../../lib/libEspecializacaoCuidador.aspx", function(retorno){

    if (retorno == "erro") 
    {
	    console.log('deu erro na libEspecializacaoCuidador');
    }
    else
    {
	    $('.cbxEspecializacao').html("<option id='opt Selecione' value='0'>Selecione</option>" + retorno);
    }

});

// Pg 1  : btnPaciente
$(document).on("click", "#btnPaciente", function(){

    if($('.selecionado').length){
        try{    

            var classes = $(".selecionado").attr("class").split(/\s+/);
            localStorage.setItem("cdPaciente", classes[1]);
            $(".selecionado").removeClass("selecionado");
            passarPagina($(this),1);
            scriptConfirmarEndereco();
        }
        catch {
            alertIonic("Por favor, escolha um paciente!");
            return;
        }
    }   
    else{
        alertIonic("Por favor, escolha um paciente!!");
    }
});
//btnEnderecoDiferente


// Pg 2 : Escolher se endereço tá certo ou não

$("#btnConfirmarEndereco").click(function () {
        passarPagina($(this),2);


});
$("#btnEnderecoDiferente").click(function () {
        passarPagina($(this),1);  //-> só passa pra próxima, não roda nenhum script
});

//pg 2.1: alterou endereço 

$("#btnAlterarEndereco").click(function () {

    if($(".required").val() != ""){
        passarPagina($(this),1);
        scriptAlterarEndereco(); // guarda os dados do endereço que foi digitado
    }
    else{
        alertIonic("Os únicos campos que podem estar vazios são CEP e Complemento!");
        return;
    }
   
 });

//pg 3: pg data hora -> vai para cuidador
$("#btnDataHora").click(function () {

    if ($('#horaInicio').val() != "" && $("#horaFim").val() != "" && $('#data').val() != "") 
    {
        const duracaoServico = $("#horaFim").val().split(":");
        if(duracaoServico[0] == "00"){
            alertIonic("Seu serviço precisa durar no mínimo uma hora!");
        }
        else{
            scriptVerificarPacienteServico();
            passarPagina($(this),1);
            scriptDataHora($("#horaInicio").val(), $("#horaFim").val());
            scriptCuidador(); 
            $(".areaFiltro").addClass("visivel");
            $('#dinheiro').mask('000,00', { reverse: true });
            $('#avaliacao').mask('0.0', { reverse: true });
        }
    }
    else
    {
        alertIonic('Selecione uma data ou hora para inicio/fim de serviço!');
        return;
    }
});

//pg 5: pag cuidador -> vai para info cuidador  
$(document).on("click", "#btnCuidador", function(){

    if ($('.selecionado').length != 0) 
    {
        var classes = $(".selecionado").attr("class").split(/\s+/);
        localStorage.setItem("emailCuidador", classes[1]); 
        passarPagina($(this),1);
        $(".areaFiltro").removeClass("visivel");
        scriptInfoCuidador();
    }   
    else
    {
        alertIonic('Por favor, selecione um cuidador');
        return;
    }

});

$(document).on("click", "#btnFiltro", function(){
    scriptFiltro();
    $(".infoFiltro").removeClass("visivel");
});

//pg 6 : info cuidador -> vai para finalizar
$("#btnInfoCuidador").click(function () {
    passarPagina($(this),1);
    carregarFinalizarServico();
});

//pg 7: pg finalizar pedido (resumo)
$("#btnFinalizarServico").click(function () {
    EnviarFinalizarServico();
    
});

});