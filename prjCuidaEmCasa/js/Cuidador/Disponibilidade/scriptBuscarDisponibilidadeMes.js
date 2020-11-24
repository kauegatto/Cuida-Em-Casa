export default function scriptBuscarDisponibilidadeMes (intMes) {

    var usuarioLogado = localStorage.getItem("usuarioLogado");
    var disponibilidades;
    var dia;var horaInicio; var horaFim;var value;

    function buscarDisponibilidadeMensal(){

        $.post("../../lib/libBuscarDisponibilidadeDoCuidadorPorMes.aspx", { intMes: intMes, usuarioLogado:usuarioLogado}, function (retorno) {
            
            if (retorno == "erro") {
                console.log("deu erro");
                alert("erro");
            }
            retorno = retorno.split("|");
            
            disponibilidades = retorno;
            
            for (var i = 0; i < retorno.length; i++) {

                
                if(retorno[i]!=""){console.log(retorno[i]);}
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
                        value = $(this).html()
                        if(value == dia && value!=""){
                            $(this).css("background-color","#56cc9d94");//56cc9d94 //2980b975
                            $(this).css("color","black");
                        }
                    })
                })      
               
            }

            $(document).on("click", "td", function(){
                if($(this).html() != ""){
                    $(".output").html("Data Selecionada: "+$(this).html()+"/"+intMes);
                    colocarDisponibilidadeDoDia();
                }
            });
            
        });
    }

    function colocarDisponibilidadeDoDia(){

            value = $(".selected_date").html();
            $(".horarioDia").html("");
            if(value!=""){
                for (var i = 0; i < disponibilidades.length; i++) {

                    var arrayAtual = disponibilidades[i];
                    arrayAtual = arrayAtual.replace('[', "");
                    arrayAtual = arrayAtual.replace(']', "");
                    arrayAtual = arrayAtual.split(',');
                    dia = arrayAtual[0];
                    horaInicio = arrayAtual[1];
                    horaFim = arrayAtual[2];
                    if(dia == value){
                        $(".horarioDia").append("<div class='alert alert-dark horarioDisponibilidade'>Hora Inicial: "+horaInicio+" Hora final: "+ horaFim + "</div>");
                    }
                }
            }
    }

    buscarDisponibilidadeMensal();

};

