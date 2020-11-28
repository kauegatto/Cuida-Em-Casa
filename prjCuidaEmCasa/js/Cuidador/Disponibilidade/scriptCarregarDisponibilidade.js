import scriptBuscarDisponibilidadeMes from './scriptBuscarDisponibilidadeMes.js';
export default function scriptCarregarCalendario() {
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

  function carregarDisponibilidades(){
      mes = $(".mesServico").text();
      pegarMes(mes);
      scriptBuscarDisponibilidadeMes(mes);
      $(".btnAdicionar").css("display","block");
      $(".horarioDia").css("display","block");
  }

  carregarDisponibilidades();
}

    






