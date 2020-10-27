export default function scriptServicoAgendadoSelecionado(cdServico) {

    $.post("../../lib/libServicoAgendadoSelecionado.aspx", { codigoServico: cdServico }, function (retorno) {

        if (retorno == "erro") {
            console.log("deu erro");
        }
        else 
        {
            console.log('deu certo')
        }
    });

};
