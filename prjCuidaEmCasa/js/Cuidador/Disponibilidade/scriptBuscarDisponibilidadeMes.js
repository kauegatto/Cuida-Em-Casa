export default function scriptBuscarDisponibilidadeMes (intMes) {

    var usuarioLogado = localStorage.getItem("usuarioLogado");
    
    var disponibilidades;
    
    window.disponibilidades = "";

    var dia;var horaInicio; var horaFim; var value;
    

    function buscarDisponibilidadeMensal(){

        $.post("../../lib/libBuscarDisponibilidadeDoCuidadorPorMes.aspx", { intMes: intMes, usuarioLogado:usuarioLogado}, function (retorno) {
            
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
                            $(this).css("background-color","#56cc9d94");//56cc9d94 //2980b975
                            $(this).css("color","black");
                        }
                    })

                })      
               
            }

            $(document).on("click", "td", function(){
                
                if($(this).html() != ""){

                    //vai se fode dougla

                    $(".output").html("Data Selecionada: "+$(this).html()+"/"+intMes);

                    colocarDisponibilidadeDoDia();

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
                    
                    //console.log("ano : " +ano);

                    localStorage.setItem("diaSelecionado",ano+'-'+mes+'-'+dia);
                }
            });

            colocarDisponibilidadeDoDia()
        });
    }

    function colocarDisponibilidadeDoDia(){

            value = $(".selected_date").html();            
            $(".horarioDia").html("");

            //console.log("dia selecionado:" +value);

            if(value!="" && window.disponibilidades!=undefined && window.disponibilidades!=null && window.disponibilidades[0]!=""){
                console.log("foram reconhecidas : " + window.disponibilidades.length +" disponibilidades");
                //console.log("vou colocar as disponibilidades: " + window.disponibilidades);
                
                for (var i = 0; i < window.disponibilidades.length; i++) {

                    var arrayAtual = window.disponibilidades[i];
                    arrayAtual = arrayAtual.replace('[', "");
                    arrayAtual = arrayAtual.replace(']', "");
                    arrayAtual = arrayAtual.split(',');
                    dia = arrayAtual[0];
                    horaInicio = arrayAtual[1];
                    horaFim = arrayAtual[2];
                    if(dia == value){
                        $(".horarioDia").append("<div class='alert alert-dark horarioDisponibilidade'>Hora Inicial: <span class='horaInicio'>"+horaInicio+"</span> Hora final: <span class='horaFim'>"+ horaFim +"</span></div>");
                        $(".horarioDia").children(".alert").last().append("<div class='' id='btnRemover'> remover  </div>");
                    }
                }

            }
            else{
                $(".output").html("Selecione um dia");
            }
    }
    
    buscarDisponibilidadeMensal();

    
    

};

