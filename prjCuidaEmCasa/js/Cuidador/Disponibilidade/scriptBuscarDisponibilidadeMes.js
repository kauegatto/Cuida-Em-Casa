export default function scriptBuscarDisponibilidadeMes (intMes) {

    var usuarioLogado = localStorage.getItem("usuarioLogado");


    $.post("../../lib/libBuscarDisponibilidadeDoCuidadorPorMes.aspx", { intMes: intMes, usuarioLogado:usuarioLogado}, function (retorno) {

        if (retorno == "erro") {
            console.log("deu erro");
            alert("erro");
        }
        console.log(retorno);
        retorno = retorno.split("|");
        console.log(retorno);
        console.log(retorno.length)
        for (var i = retorno.length; i > 0; i++) {
            var arrayAtual = retorno[i]-1;
            var dia = arrayAtual[0];
            var horaInicio = arrayAtual[1];
            var horaFim = arrayAtual[2];
            var classeDia = ".Dia"+dia;
            $(classeDia).css("background-color","#888")
        }
        
    })
};

