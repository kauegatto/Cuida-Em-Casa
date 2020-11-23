export default function scriptBuscarDisponibilidadeMes (intMes) {

    $.post("../../lib/libBuscarDisponibilidadeDoUsuarioPorMes.aspx", { intMes: intMes }, function (retorno) {

        if (retorno == "erro") {
            console.log("deu erro");
        }

    })
};

