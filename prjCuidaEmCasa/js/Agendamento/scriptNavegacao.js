import scriptPaciente from "./scriptPaciente.js";
import scriptConfirmarEndereco from "./scriptConfirmarEndereco.js";
import scriptAlterarEndereco from "./scriptAlterarEndereco.js";
import scriptDataHora from "./scriptDataHora.js";
import scriptCuidador from "./scriptCuidador.js";
import scriptInfoCuidador from "./scriptInfoCuidador.js";
import carregarFinalizarServico  from "./scriptFinalizarServico.js";
import EnviarFinalizarServico  from "./scriptAgendarServico.js";
import scriptFiltro from "./scriptFiltro.js";

var indexPage = 0; var jump = 0; var DomElement = $("#btnPaciente");

function passarPagina(SentDomElement,Jump) {
    
    $(".conteudoGeral").children().eq(indexPage).css("display", "block" );
    $(".conteudoGeral").children().eq(indexPage).addClass("visibleWrapper");

    indexPage += Jump;
    DomElement = SentDomElement; // botao que enviou o último click pra chegar na página que estamos

    if(Jump < 0){
        console.log(indexPage);
        if(indexPage>=0){
            $(".visibleWrapper").css("display", "none" );
            $(".visibleWrapper").removeClass("visibleWrapper");
            $(DomElement).parents("main.conteudoGeral").children().eq(indexPage).css( "display", "block");
            $(DomElement).parents("main.conteudoGeral").children().eq(indexPage).addClass("visibleWrapper"); 
        }
        else{indexPage = 0}
       
    }
    else{
        $(".visibleWrapper").css("display", "none" );
        
        $(".visibleWrapper").removeClass("visibleWrapper");

        $(DomElement).parents("main.conteudoGeral").children().eq(indexPage).css("display", "block" );

        $(DomElement).parents("main.conteudoGeral").children().eq(indexPage).addClass("visibleWrapper"); 
    }
    
    return;
};    	


$(".iconeVoltar").click(function(){
    
    if(indexPage == 5 ){
        passarPagina(DomElement, -2);
    } 
    else{passarPagina(DomElement, -1);}
});

$(document).ready(function () {

scriptPaciente();

// Pg 1  : btnPaciente
$("#btnPaciente").click(function () {

    if($('.selecionado').length){
        try{    

            var classes = $(".selecionado").attr("class").split(/\s+/);
            localStorage.setItem("cdPaciente", classes[1]);
            $(".selecionado").removeClass("selecionado");
            passarPagina($(this),1);
            scriptConfirmarEndereco();
        }
        catch {
            alert("Por favor, escolha um paciente!");
            return;
        }
    }   
    else{
        alert("Por favor, escolha um paciente!!");
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
        alert("Os únicos campos que podem estar vazios são CEP e Complemento!");
        return;
    }
   
 });

//pg 3: pg data hora -> vai para cuidador
$("#btnDataHora").click(function () {
    passarPagina($(this),1);
    scriptDataHora($("#horaInicio").val(), $("#horaFim").val());
    scriptCuidador();
    $(".areaFiltro").css('display','block');      
});

//pg 5: pag cuidador -> vai para info cuidador  
$(document).on("click", "#btnCuidador", function(){
    passarPagina($(this),1);
    $(".areaFiltro").css('display','none');      
    $(".infoFiltro").removeClass("visivel");
    $(".areaFiltro").css("display","none");
    var classes = $(".selecionado").attr("class").split(/\s+/);
    localStorage.setItem("emailCuidador", classes[1]);    
    scriptInfoCuidador();
});

$("#btnFiltro").click(function (){
    scriptFiltro();
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