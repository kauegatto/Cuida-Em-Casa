import scriptPaciente from "./scriptPaciente.js";
import scriptConfirmarEndereco from "./scriptConfirmarEndereco.js";
import scriptAlterarEndereco from "./scriptAlterarEndereco.js";
import scriptDataHora from "./scriptDataHora.js";
import scriptCuidador from "./scriptCuidador.js";
import scriptInfoCuidador from "./scriptInfoCuidador.js";
import carregarFinalizarServico  from "./scriptFinalizarServico.js";
import enviarFinalizarServico  from "./scriptFinalizarServico.js";

function passarPagina (indexPage, DomElement) {
    $(DomElement).parents("div.wrapper").css({ "display": "none" });
    $(DomElement).parents("main.conteudoGeral").children().eq(indexPage).css({ "display": "block" });
    return indexPage + 1;
};    	

$(document).ready(function () {
	var indexPage = 1;

	scriptPaciente();

    $(".navBtn").click(function () {
    	var DomElement = ($(this)[0]);
    	indexPage = passarPagina(indexPage, $(DomElement));
    	console.log("era p ter passado de pagina ta");
    	
});  

// Pg 1  : btnPaciente
$("#btnPaciente").click(function () {
			try{
						var classes = $(".selecionado").attr("class").split(/\s+/);
			            localStorage.setItem("cdPaciente", classes[1]);
                        $(".selecionado").removeClass("selecionado");
			}
			catch{
			        	alert("Por favor, escolha um paciente!");
			        	return;
			}
    	scriptConfirmarEndereco();
 });
//
// Pg 2 : btnConfirmarEndereco 

$("#btnConfirmarEndereco").click(function () {
		scriptAlterarEndereco();	
		var DomElement = ($(this)[0]);
    	indexPage = passarPagina(indexPage+1, $(DomElement));
});

//pg 2.1: alterou endereço 

$("#btnAlterarEndereco").click(function () {
     scriptAlterarEndereco();
 });

//pg 3: pg data hora -> vai para cuidador
$("#btnDataHora").click(function () {
    scriptDataHora($("#horaInicio").val(), $("#horaFim").val());
    console.log("era p ter salvo hora");
    scriptCuidador();      
});

//pg 5: pag cuidador -> vai para info cuidador  
$("#btnCuidador").click(function () {
    var classes = $(".selecionado").attr("class").split(/\s+/);
    localStorage.setItem("emailCuidador", classes[1]);    
    scriptInfoCuidador();
    
});

//pg 6 : info cuidador -> vai para finalizar
$("#btnInfoCuidador").click(function () {
    carregarFinalizarServico();
});
//pg 7: pg finalizar pedido (resumo)
$("#btnFinalizarServico").click(function () {
    enviarFinalizarServico();
    
});

});