import scriptBuscarDisponibilidadeMes from './scriptBuscarDisponibilidadeMes.js';

var mes;

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

$( document ).ready(function() {


var start_date_dialog = osmanli_calendar
        $('.prev-month').click(function () {start_date_dialog.pre_month()});
        $('.next-month').click(function () {start_date_dialog.next_month()});

        start_date_dialog.init();
        
        start_date_dialog.ON_SELECT_FUNC = function(){
         $('.output').html(osmanli_calendar.SELECT_DATE);
}
function carregarDisponibilidades(){
    mes = $(".mesServico").text();
    pegarMes(mes);
    scriptBuscarDisponibilidadeMes(mes);
}


carregarDisponibilidades();


$(document).on("click", ".btnMes", function(){
    carregarDisponibilidades();
});   


$(document).on("click", ".btnAdicionar", function(){
  $(".wrapper-calendario").css("display","none");
  $("#wrapper-escolherDataServico").css("display","block");

});

$(document).on("click", "#btnSalvar", function(){
  $(".wrapper-calendario").css("display","block");
  $("#wrapper-escolherDataServico").css("display","none");
  carregarDisponibilidades();
});

});

