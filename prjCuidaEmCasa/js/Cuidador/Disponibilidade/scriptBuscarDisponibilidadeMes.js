
import colocarDisponibilidadeDoDia from "./scriptColocarDisponibilidadeDoDia.js";
export default function scriptBuscarDisponibilidadeMes (intMes) {

    var usuarioLogado = localStorage.getItem("usuarioLogado");
    
    var disponibilidades;
    
    window.disponibilidades = "";

    var dia;var horaInicio; var horaFim; var value;
    

    function buscarDisponibilidadeMensal(){

        $("td").removeClass("temCoisa");
        $.post("../../../lib/libBuscarDisponibilidadeDoCuidadorPorMes.aspx", { intMes: intMes, usuarioLogado:usuarioLogado}, function (retorno) {
            
            if (retorno == "erro") {
                console.log("deu erro");
                alert("erro");
            }

            retorno = retorno.split("|");
            window.disponibilidades = retorno;

            //console.log(window.disponibilidades);
            
            for (var i = 0; i < retorno.length; i++) {
                
                //if(retorno[i]!=""){console.log(retorno[i]);}
                var arrayAtual = retorno[i];
                arrayAtual = arrayAtual.replace('[', "");
                arrayAtual = arrayAtual.replace(']', "");
                arrayAtual = arrayAtual.split(',');
                dia = arrayAtual[0];
                horaInicio = arrayAtual[1];
                horaFim = arrayAtual[2];


                var tr = $(".date_table > tbody > tr").not(':eq(0)');

                //console.log(tr)

                tr.each(function(){
                    var td = $(this).children('td')

                    td.each(function(){
                        
                        window.value = $(this).html();
                        if(window.value == dia && window.value!=""){
                            $(this).addClass("temCoisa");
                        }
                    })

                })      
               
            }
            colocarDisponibilidadeDoDia();
        });
        
    }
    
    buscarDisponibilidadeMensal();    

};

