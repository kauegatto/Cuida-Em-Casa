// adicionar no vs
import colocarAgendadosDia from "./scriptColocarServicoDoDia.js";
import scriptServicoAgendado from "./scriptServicoAgendado.js";

export default function scriptBuscarServicos (intMes) {

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

    var usuarioLogado = localStorage.getItem("usuarioLogado");
    
    var servicos;
    
    window.servicos = "";

    var dia;var cdServico; var value;
    

    function buscarAgendadosMensalmente(){
        $("td").removeClass("temCoisa");
        $.post("../../lib/libBuscarAgendadosDoCuidadorMes.aspx", { intMes: intMes, usuarioLogado:usuarioLogado}, function (retorno) {
            
            if (retorno == "erro") {
                alertIonic("Houve um erro");
            }
            retorno = retorno.split("|");
            window.servicos = retorno;

            for (var i = 0; i < retorno.length; i++) {
                var arrayAtual = retorno[i];
                arrayAtual = arrayAtual.replace('[', "");
                arrayAtual = arrayAtual.replace(']', "");
                arrayAtual = arrayAtual.split(',');
                dia = arrayAtual[0];
                cdServico = arrayAtual[1];
               
                var tr = $(".date_table > tbody > tr").not(':eq(0)');

                tr.each(function(){
                    var td = $(this).children('td')
                    td.each(function(){
                        
                        window.value = $(this).html();
                        //console.log("vendo cada tabelinha fofa");
                        if(window.value == dia && window.value!=""){
                            $(this).addClass("temCoisa");
                        }
                    })
                })      
            }
        });
    }

    buscarAgendadosMensalmente();
    
    colocarAgendadosDia();
    
    
};

