import scriptBuscarDisponibilidadeMes from './scriptBuscarDisponibilidadeMes.js'; 
import scriptCarregarCalendario from './scriptCarregarDisponibilidade.js';

    var mes;
    var hrFimDisponibilidade,hrInicioDisponibilidade;

    var usuarioLogado = localStorage.getItem("usuarioLogado");
    var dtDisponibilidade = localStorage.getItem("diaSelecionado");

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
    }
    $(document).on("click", "#btnSalvar", function(){
            
            hrInicioDisponibilidade = $("#horaInicio").val();
            hrFimDisponibilidade = $("#horaFim").val();
            dtDisponibilidade = localStorage.getItem("diaSelecionado");
            console.log('hr Inicio : ' + hrInicioDisponibilidade);
            console.log('hr Fim : ' + hrFimDisponibilidade);
            console.log('dataDisponibilidade : ' + dtDisponibilidade);
            
            adicionarDisponibilidade(usuarioLogado,dtDisponibilidade,hrInicioDisponibilidade,hrFimDisponibilidade);
            scriptCarregarCalendario();
   
    });

    $(document).on("click", "#btnRemover", function(){
        var divHorarioDisponibilidade = $(this).parent(".horarioDisponibilidade");
        console.log(divHorarioDisponibilidade);
        hrInicioDisponibilidade = $(divHorarioDisponibilidade).children('.horaInicio').html();
        hrFimDisponibilidade = $(divHorarioDisponibilidade).children('.horaFim').html();
        dtDisponibilidade = localStorage.getItem("diaSelecionado");
        //console.log('hora inicio: ' + hrInicioDisponibilidade);
        //console.log('hora fim : ' + hrFimDisponibilidade);
        //console.log('hora fim : ' + dtDisponibilidade);

        removerDisponibilidade(usuarioLogado,dtDisponibilidade,hrInicioDisponibilidade,hrFimDisponibilidade);
        scriptCarregarCalendario();
    });

    function adicionarDisponibilidade(emailCuidador, dataDisponibilidade, hrInicio, hrFim){

        $.post("../../lib/libAdicionarDisponibilidade.aspx", { usuarioLogado: emailCuidador, dtInicioDisponibilidade:dataDisponibilidade,hrInicioDisponibilidade:hrInicio,hrFimDisponibilidade:hrFim}, function (retorno) {
            
            if (retorno == "false") {
                console.log("deu erro");
                return;
            }
            if (retorno == "true"){
            }
            
        });
    }

    function removerDisponibilidade(emailCuidador, dataDisponibilidade, hrInicio, hrFim){

        $.post("../../lib/libRemoverDisponibilidade.aspx", { usuarioLogado: emailCuidador, dtInicioDisponibilidade:dataDisponibilidade,hrInicioDisponibilidade:hrInicio,hrFimDisponibilidade:hrFim}, function (retorno) {
            
            if (retorno == "false") {
                console.log("deu erro");
                return;
            }
            if (retorno == "true"){ 
            }
            
        });
    }

    scriptCarregarCalendario();