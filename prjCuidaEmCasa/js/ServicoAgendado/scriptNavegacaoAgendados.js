import scriptServicoAgendado from "./scriptServicoAgendado.js";
import scriptServicoAgendadoSelecionado from "./scriptServicoAgendadoSelecionado.js";
import scriptCancelarServicoAgendado from "./scriptCancelarServicoAgendado.js";
import scriptCarregarCalendario from "../Cuidador/Disponibilidade/scriptCarregarDisponibilidade.js";
import scriptCarregarCalendarioAgenda from "./scriptCarregarCalendarioAgenda.js";
import colocarAgendadosDia from "./scriptColocarServicoDoDia.js";

var start_date_dialog = osmanli_calendar


$(document).ready(function () {

    var start_date_dialog;
    start_date_dialog = osmanli_calendar;
          
    $('.prev-month').click(function () {start_date_dialog.pre_month()});
    $('.next-month').click(function () {start_date_dialog.next_month()});

    

    if(!localStorage.getItem("tipoUsuario") == 3){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    };

    //scriptServicoAgendado();
    scriptCarregarCalendarioAgenda();

    $(document).on("click", "#areaAgendados", function(){
        $('#areaAgendados').removeClass('areaCinza');
        $('#areaAgendados').addClass('areaBranca');
        $('#areaDisponibilidade').removeClass('areaBranca');
        $('#areaDisponibilidade').addClass('areaCinza');
        $('#wrapper-calendarioDisponibilidade').css('display', 'block');
        scriptCarregarCalendarioAgenda();
    });

    $(document).on("click", "#areaDisponibilidade", function(){
        $('#areaDisponibilidade').removeClass('areaCinza');
        $('#areaDisponibilidade').addClass('areaBranca');
        $('#areaAgendados').removeClass('areaBranca');
        $('#areaAgendados').addClass('areaCinza')
        $('#ListaServicosAgendados').css('display', 'none');
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

        scriptCarregarCalendarioAgenda();


    });

    var classes;

    $(document).on("click", ".areaAgendaConteudo", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        classes = $(this).attr("class").split(/\s+/);
       
        scriptServicoAgendadoSelecionado(classes[1]);
      
        $("#wrapper-calendarioDisponibilidade").css("display","none");
        $(".opcoes").css("display","none");    


        $("#wrapper-InfoServicoAgendado").addClass("visivel");
        $('#headerNav').addClass("visivel");
        $('#tituloGeral-Nav').html("Informações do serviço");
    });

    $(document).on("click", ".btnCancelarServico", function(){
        
        scriptCancelarServicoAgendado(classes[1]);
        
        $(".visivel").each(function (i, obj) {
            $(this).removeClass("visivel");
        });

        $("#wrapper-calendarioDisponibilidade").css("display","block");
        $(".opcoes").css("display","block");    

        $("#wrapper-calendarioDisponibilidade").addClass("visivel");
        $('#headerComum').addClass("visivel");

        scriptCarregarCalendarioAgenda();
    });

    $(document).on("click", "td", function(){
        if($("#areaAgendados").hasClass("areaBranca")){
            if($(this).html() != ""){
                
                $(".output").html("Data Selecionada: "+$(this).html()+"/"+intMes);
                
                colocarAgendadosDia();
                //console.log("coloca os agendado pf");
                /* Guardar na procedure a data selecionada*/
                dia = $(this).html();
                if(dia.length == 1){
                    //console.log("entrou");
                    dia = "0"+dia;
                }
                //console.log("dia : " +dia);
                var mes = intMes;

                if(mes.length == 1){
                    //console.log("entrou");
                    mes = "0"+mes;
                }

                //console.log("mes : " +mes);

                var ano = $('.mesServico').html();
                
                ano = ano.split(" ");
                
                ano = ano[1];
                
                localStorage.setItem("diaSelecionado",ano+'-'+mes+'-'+dia+1);
            }
        }
    });
});
