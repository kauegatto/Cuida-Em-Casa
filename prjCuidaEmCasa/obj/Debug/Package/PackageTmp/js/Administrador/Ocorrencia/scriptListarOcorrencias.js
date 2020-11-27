$(document).ready(function () {

    var botao = 3;

    $.post("http://3.96.217.5/lib/libListarOcorrenciaCuidador.aspx", { control: botao, emailCuidador: localStorage.getItem("emailCuidador"), cdOcorrencia: "0", dsOcorrencia: "0", emailAdm: "0", cdTipoOcorrencia: "0" }, function (retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }
        else {
            $('.conteudoCuidador').html(retorno);
        }
    });

    $(document).on("click", ".btnDenuncia", function () {
        var classes = $(this).attr("class").split(/\s+/);
        localStorage.setItem("cdOcorrencia", classes[1]);
        botao = 0;

        $.post("http://3.96.217.5/lib/libListarOcorrenciaCuidador.aspx", { control: botao, cdOcorrencia: localStorage.getItem("cdOcorrencia"), emailCuidador: localStorage.getItem("emailCuidador"), dsOcorrencia: "0", emailAdm: "0", cdTipoOcorrencia: "0" }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else {
                botao = 3;

                $.post("http://3.96.217.5/lib/libListarOcorrenciaCuidador.aspx", { control: botao, cdOcorrencia: localStorage.getItem("cdOcorrencia"), emailCuidador: localStorage.getItem("emailCuidador"), dsOcorrencia: "0", emailAdm: "0", cdTipoOcorrencia: "0" }, function (retorno) {
                    if (retorno == "false") {
                        console.log("deu erro na lib");
                    }
                    else {
                        if (retorno != "true") {
                            $('.conteudoCuidador').html(retorno);
                        }
                    }
                });
            };
        });
    });

    $(document).on("click", ".btnEnviarAdvertencia", function () {
        var classes = $(this).attr("class").split(/\s+/);
        localStorage.setItem("cdOcorrencia", classes[1]);
        botao = 1;

        var dsOcorrencia = $('.descricaoDenuncia').html();
        var emailCliente = $('.emailClienteOcorrencia').html();
        var cdTipoOcorrencia = classes[2];

        $.post("http://3.96.217.5/lib/libListarOcorrenciaCuidador.aspx", { control: botao, cdOcorrencia: localStorage.getItem("cdOcorrencia"), emailCuidador: localStorage.getItem("emailCuidador"), dsOcorrencia: dsOcorrencia, emailAdm: localStorage.getItem("usuarioLogado"), cdTipoOcorrencia: cdTipoOcorrencia }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else {
                botao = 3;

                $.post("http://3.96.217.5/lib/libListarOcorrenciaCuidador.aspx", { control: botao, cdOcorrencia: localStorage.getItem("cdOcorrencia"), emailCuidador: localStorage.getItem("emailCuidador"), dsOcorrencia: "0", emailAdm: "0", cdTipoOcorrencia: "0" }, function (retorno) {
                    if (retorno == "false") {
                        console.log("deu erro na lib");
                    }
                    else {
                        if (retorno != "true") {
                            $('.conteudoCuidador').html(retorno);
                        }
                    }
                });
            };
        });
    });

});