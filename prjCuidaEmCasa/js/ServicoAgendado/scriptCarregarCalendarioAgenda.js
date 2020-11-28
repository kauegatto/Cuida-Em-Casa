import scriptBuscarServicos from './scriptBuscarServicos.js';
//adicionar no vs
export default function scriptCarregarCalendarioAgenda(){
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
  	
    function carregarServicos(){
	    mes = $(".mesServico").text();
	    pegarMes(mes);
	    scriptBuscarServicos(mes);
	    $(".btnAdicionar").css("display","none");
		  $(".horarioDia").css("display","none");
  	}

  	$(document).on("click", ".btnMes", function(){
    
      if ($("#areaAgendados").hasClass("areaBranca")) {
	    	carregarServicos();
      	$(".btnAdicionar").css("display","none");      		
    	}

  	});  
	  
    carregarServicos();
}
