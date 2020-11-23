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
            
            $('.date_table tr td#' + dia).css("background-color","#888");
            console.log('deu certo');
        }
        

    })
};

