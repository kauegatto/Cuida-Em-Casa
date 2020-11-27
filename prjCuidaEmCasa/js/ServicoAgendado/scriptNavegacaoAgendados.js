import scriptServicoAgendado from "./scriptServicoAgendado.js";
import scriptServicoAgendadoSelecionado from "./scriptServicoAgendadoSelecionado.js";
import scriptCancelarServicoAgendado from "./scriptCancelarServicoAgendado.js";
import scriptCarregarCalendario from "../Cuidador/Disponibilidade/scriptCarregarDisponibilidade.js";
import scriptCarregarCalendarioAgenda from "./scriptCarregarCalendarioAgenda.js";
import colocarAgendadosDia from "./scriptColocarServicoDoDia.js";

var start_date_dialog = osmanli_calendar
var mes

$(document).ready(function () {

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


    var start_date_dialog;
    start_date_dialog = osmanli_calendar;
          
    $('.prev-month').click(function () {start_date_dialog.pre_month();$("#listaServicosAgendados").html("")});
    $('.next-month').click(function () {start_date_dialog.next_month();$("#listaServicosAgendados").html("")});

    if(!localStorage.getItem("tipoUsuario") == 3){
        alertIonic("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    };

    //scriptServicoAgendado();
    scriptCarregarCalendarioAgenda();

    function pegarMes(stringMes){
        mes = stringMes.split(" ");
        mes = mes[0];
        switch (mes) {
                  case "Janeiro":
                    mes = 1;
                    break;
                  case "Fevereiro":
                    mes = 2;
                    break;
                  case "Marco":
                    mes = 3;
                    break;
                  case "Abril":
                    mes = 4;
                    break;
                  case "Maio":
                    mes = 5;
                    break;
                  case "Junho":
                    mes=6;
                    break;
                  case "Julho":
                    mes=7;
                    break;
                  case "Agosto":
                    mes=8;
                    break;
                  case "Setembro":
                    mes=9;
                    break;
                  case "Outubro":
                    mes=10;
                    break;
                  case "Novembro":
                    mes=11;
                    break;
                  case "Dezembro":
                    mes=12;
                    break;
       }
    };

    mes = $(".mesServico").text();
    pegarMes(mes);

    $(document).on("click", "#areaAgendados", function(){
        $('#areaAgendados').removeClass('areaCinza');
        $('#areaAgendados').addClass('areaBranca');
        $('#areaDisponibilidade').removeClass('areaBranca');
        $('#areaDisponibilidade').addClass('areaCinza');
        $('#wrapper-calendarioDisponibilidade').css('display', 'block');
        console.log("passou agenda");
        scriptCarregarCalendarioAgenda();
    });

    $(document).on("click", "#areaDisponibilidade", function(){
        $('#areaDisponibilidade').removeClass('areaCinza');
        $('#areaDisponibilidade').addClass('areaBranca');
        $('#areaAgendados').removeClass('areaBranca');
        $('#areaAgendados').addClass('areaCinza')
        $('#listaServicosAgendados').css('display', 'none');
        $('#wrapper-calendarioDisponibilidade').css('display', 'block');

        scriptCarregarCalendario();
    });
    

 	$(".iconeVoltar").click(function () {

    	$(".visivel").each(function (i, obj) {
	    $(this).removeClass("visivel");

    });

        /* Mostrar divs novas */
                    $("#headerComum").css("display","block");$("#headerComum").removeClass("visivel");
                    $("#wrapper-calendarioDisponibilidade").css("display","block");
                    $(".opcoes").css("display","block");

        /* Esconder divs antigas */
        
                    $("#listaServicosAgendados").css("display","none");
                    $("#wrapper-informacoesDisponibilidade").css("display","none");
                    $("#headerNav").css("display","none"); $("#headerNav").removeClass("visivel");
                    $("#wrapper-InfoServicoAgendado").css("display","none");
                    

        if($("#areaAgendados").hasClass("areaBranca")){
            scriptCarregarCalendarioAgenda();
        }
        else{
            scriptCarregarCalendario();
        }
    });
    
    var classes;

    $(document).on("click", ".areaAgendaConteudo", function(){

        $(".visivel").each(function (i, obj) {
           $(this).removeClass("visivel");
        });

        classes = $(this).attr("class").split(/\s+/);
       
        scriptServicoAgendadoSelecionado(classes[1]);
      
        $("#wrapper-calendarioDisponibilidade").css("display","none");
        $("#wrapper-informacoesServico").css("display","none");
        $("#wrapper-informacoesServico").removeClass("visivel");
        $(".opcoes").css("display","none");    


        $("#wrapper-InfoServicoAgendado").addClass("visivel");
       // $('#headerNav').addClass("visivel");
        $("#headerNav .areaTituloGeral").css('display','block');
        $("#headerNav .areaLogo").css('display','block');
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
            console.log("tem");
            if($(this).html() != ""){
                /* Esconder divs antigas */
                    $("#wrapper-calendarioDisponibilidade").css("display","none");
                    $("#wrapper-calendarioDisponibilidade").removeClass("visivel");
                    $("#headerComum").css("display","block");// $("#headerComum").removeClass("visivel");
                    $(".opcoes").css("display","none");
                /* Mostrar divs novas */
                    //$("#headerNav").css("display","block"); 
                    $("#listaServicosAgendados").css("display","block");
                    $("#wrapper-informacoesServico").css("display","visivel");
                    $("#wrapper-informacoesServico").addClass("visivel");    
                /* Guardar na procedure a data selecionada e coloca-la no título*/
                
                    var dia = $(this).html();
                    
                    if(dia.length == 1){
                        //console.log("entrou");
                        dia = "0"+dia;
                    }
                    mes = $(".mesServico").text();
                    pegarMes(mes);
                    //console.log("dia : " +dia)
                    if(mes.length == 1){
                        //console.log("entrou");
                        mes = "0"+mes;
                    }

                    $(".output").html("Data Selecionada: "+$(this).html()+"/"+mes);
                    //console.log("mes : " +mes);

                    var ano = $('.mesServico').html();
                    
                    ano = ano.split(" ");
                    
                    ano = ano[1];

                    localStorage.setItem("diaSelecionado",ano+'-'+mes+'-'+dia);             
                colocarAgendadosDia();   
            }
        }
    });
});






