export default function scriptServicoAgendadoSelecionado(cdServico) {
    var dados;
    $.post("http://3.96.217.5/lib/libServicoAgendadoSelecionado.aspx", { codigoServico: cdServico }, function (retorno) {

        if (retorno == "erro") {
            console.log("deu erro");
        }
        else 
        {
           dados = retorno.split(';');
           $('.invi').html(dados[0]);
           $(".areaInfoPaciente").each(function (i, obj) {
                var url = "data:image/png;base64," + $(this).children('.invi').html();
                $(this).children(".areaImagemPacienteAgendamento").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });
           $('.nomeInfoPaciente').html(dados[1]);
           $('#medicacao').html(dados[2]);
           $('#descricao').html(dados[3]);
           $('#cep').html(dados[4]);
           $('#bairro').html(dados[5]);
           $('#rua').html(dados[6]);
           $('#numero').html(dados[7]);
           $('#cidade').html(dados[8]);
           $('#uf').html(dados[9]);
           $('#complemento').html(dados[10]);
           $('#horario').html(dados[11] + " - " + dados[12]);
           $('#duracao').html(dados[13] + " Hora(s)");
           $('#valorHora').html("R$ " + dados[16]);
           $('#status').html(dados[15]);
           $('#valorTotal').html("R$ " + dados[14]);
        }
    });

};
