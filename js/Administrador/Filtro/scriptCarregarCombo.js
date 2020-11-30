$(document).ready(function () {

    $.post("http://3.96.217.5/lib/libEspecializacaoCuidador.aspx", function (retorno) {

        if (retorno == "erro") {
            console.log('deu erro na libEspecializacaoCuidador');
        }
        else {
            $('#especializacaoCuidador').html("<option id='opt Especialização' value='0'>Especialização</option>" + retorno);
        }

    });

})