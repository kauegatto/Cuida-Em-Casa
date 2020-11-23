export default function scriptBuscarDisponibilidadeMes (intMes) {

    var usuarioLogado = localStorage.getItem("usuarioLogado");


    $.post("../../lib/libBuscarDisponibilidadeDoCuidadorPorMes.aspx", { intMes: intMes, usuarioLogado:usuarioLogado}, function (retorno) {

        if (retorno == "erro") {
            console.log("deu erro");
            alert("erro");
        }

        console.log(retorno);
        retorno = retorno.split("|");

        for (var i = 0; i < retorno.length; i++) {

            console.log(retorno[i])
            var arrayAtual = retorno[i];
            arrayAtual = arrayAtual.replace('[', "");
            arrayAtual = arrayAtual.replace(']', "");
            arrayAtual = arrayAtual.split(',');
            var dia = arrayAtual[0];
            var horaInicio = arrayAtual[1];
            var horaFim = arrayAtual[2];
            var classeDia = dia;

            var tr = $(".date_table > tbody > tr").not(':eq(0)');

            //console.log(tr)

            tr.each(function(){
                var td = $(this).children('td')
                td.each(function(){
                    var value = $(this).html()
                    if(value == dia && value!=""){
                        $(this).css("background-color","#2980b975");
                        $(this).css("color","black");
                    }
                })
            })      
           
            console.log('deu certo');
        }
        

    })
};

