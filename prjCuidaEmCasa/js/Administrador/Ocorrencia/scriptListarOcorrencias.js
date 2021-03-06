﻿$(document).ready(function () {

    function alertIonic(text) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

    var botao = 3;

    $.post("../../../lib/libListarOcorrenciaCuidador.aspx", { control: botao, emailCuidador: localStorage.getItem("emailCuidador"), cdOcorrencia: "0", dsOcorrencia: "0", emailAdm: "0", cdTipoOcorrencia: "0" }, function (retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }
        else {
            if (retorno == "") {
                $('.conteudoCuidador').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%;color:white;'>Desculpe, esse cuidador não tem ocorrências registradas</h2>");
            }
            else {
                $('.conteudoCuidador').html(retorno);

               
                var tinhaImg = $(".invi").html().split("#");
                if (tinhaImg[1] == "true") { var url = "data:image/png;base64," + tinhaImg[0]; }
                else { var url = "data:image/svg+xml;base64," + tinhaImg[0]; }

                $(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            }
        }
    });

    $(document).on("click", ".btnDenuncia", function () {
        var classes = $(this).attr("class").split(/\s+/);
        localStorage.setItem("cdOcorrencia", classes[1]);
        botao = 0;

        $.post("../../../lib/libListarOcorrenciaCuidador.aspx", { control: botao, cdOcorrencia: localStorage.getItem("cdOcorrencia"), emailCuidador: localStorage.getItem("emailCuidador"), dsOcorrencia: "0", emailAdm: "0", cdTipoOcorrencia: "0" }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else {
                botao = 3;

                $.post("../../../lib/libListarOcorrenciaCuidador.aspx", { control: botao, cdOcorrencia: localStorage.getItem("cdOcorrencia"), emailCuidador: localStorage.getItem("emailCuidador"), dsOcorrencia: "0", emailAdm: "0", cdTipoOcorrencia: "0" }, function (retorno) {
                    if (retorno == "false") {
                        console.log("deu erro na lib");
                    }
                    else {
                        if (retorno == "") {
                            $('.conteudoCuidador').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%;color:white;'>Desculpe, esse cuidador não tem ocorrências registradas</h2>");
                        }
                        else {
                            //retorno = retorno.split("|@")
                            alertIonic('Denúncia recebida com sucesso!');
                            $('.conteudoCuidador').html(retorno);
                            //var url = "data:image/jpeg+jpg;base64," + retorno[0];
                            //$(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
                            $(".areaCuidador").each(function (i, obj) {
                                var tinhaImg = $(this).children("div.invi").html().split("#");
                                if (tinhaImg[1] == "true") { var url = "data:image/png;base64," + tinhaImg[0]; }
                                else { var url = "data:image/svg+xml;base64," + tinhaImg[0]; }

                                $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
                            });
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

        $.post("../../../lib/libListarOcorrenciaCuidador.aspx", { control: botao, cdOcorrencia: localStorage.getItem("cdOcorrencia"), emailCuidador: localStorage.getItem("emailCuidador"), dsOcorrencia: dsOcorrencia, emailAdm: localStorage.getItem("usuarioLogado"), cdTipoOcorrencia: cdTipoOcorrencia }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else {
                botao = 3;

                $.post("../../../lib/libListarOcorrenciaCuidador.aspx", { control: botao, cdOcorrencia: localStorage.getItem("cdOcorrencia"), emailCuidador: localStorage.getItem("emailCuidador"), dsOcorrencia: "0", emailAdm: "0", cdTipoOcorrencia: "0" }, function (retorno) {
                    if (retorno == "false") {
                        console.log("deu erro na lib");
                    }
                    else {
                        if (retorno == "") {
                            alertIonic('Advertência enviada com sucesso!');
                            $('.conteudoCuidador').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%;color:white;'>Desculpe, esse cuidador não tem ocorrências registradas</h2>");
                        }
                        else {
                            //retorno = retorno.split("|@")
                            alertIonic('Advertência enviada com sucesso!');
                            $('.conteudoCuidador').html(retorno);
                            //var url = "data:image/svg+xml+jpeg+jpg;base64," + retorno[0];
                            //$(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
                            $(".areaCuidador").each(function (i, obj) {
                                var tinhaImg = $(this).children("div.invi").html().split("#");
                                if (tinhaImg[1] == "true") { var url = "data:image/png;base64," + tinhaImg[0]; }
                                else { var url = "data:image/svg+xml;base64," + tinhaImg[0]; }

                                $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
                            });
                        }
                    }
                });
            };
        });
    });

});