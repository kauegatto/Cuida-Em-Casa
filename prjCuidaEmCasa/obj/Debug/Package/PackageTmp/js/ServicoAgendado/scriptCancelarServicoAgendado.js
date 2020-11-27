export default function scriptCancelarServicoAgendado(cdServico) {
    var dados;
    $.post("http://3.96.217.5/lib/libCancelarServicoAgendado.aspx", { codigoServico: cdServico }, function (retorno) {
         if (retorno == "false") {
            console.log("deu erro");
        }
        else 
        {
            console.log("deu certo");
        }
    });
};
