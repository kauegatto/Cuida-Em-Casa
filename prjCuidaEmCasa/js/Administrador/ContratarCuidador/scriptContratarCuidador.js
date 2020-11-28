$(document).ready(function () {

    var botao = 3;
    localStorage.setItem("emailCuidadorContrato", "teste@gmail.com");

    $.post("../../../lib/libContratarCuidador.aspx", { control: botao, emailCuidador: localStorage.getItem("emailCuidadorContrato") }, function (retorno) {
        if (retorno == "false") {
            console.log("deu erro na lib");
        }
        else {
            $('.listaCuidadores').html(retorno);

            $(".areaCuidador").each(function (i, obj) {
                var tinhaImg = $(this).children("div.invi").html().split("#");
                if (tinhaImg[1] == "true" ){var url = "data:image/png;base64," + tinhaImg[0];}
                else{ var url = "data:image/svg+xml;base64," + tinhaImg[0]; }
        
                $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });
        }
    });

    $(document).on("click", ".iconeInformacao", function () {
        var classes = $(this).attr("class").split(/\s+/);
        localStorage.setItem("emailCuidador", classes[1]);
    });

    $(document).on("click", ".btnAceitar", function () {
        var classes = $(this).attr("class").split(/\s+/);
        localStorage.setItem("emailCuidadorContrato", classes[1]);
        botao = 0;

        $.post("../../../lib/libContratarCuidador.aspx", { control: botao, emailCuidador: localStorage.getItem("emailCuidadorContrato") }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else {
                botao = 3;

                $.post("../../../lib/libContratarCuidador.aspx", { control: botao, emailCuidador: localStorage.getItem("emailCuidadorContrato") }, function (retorno) {
                    if (retorno == "false") {
                        console.log("deu erro na lib");
                    }
                    else {
                        if (retorno != "true") {
                            $('.listaCuidadores').html(retorno);
                            $(".areaCuidador").each(function (i, obj) {
                                var tinhaImg = $(this).children("div.invi").html().split("#");
                                if (tinhaImg[1] == "true" ){var url = "data:image/png;base64," + tinhaImg[0];}
                                else{ var url = "data:image/svg+xml;base64," + tinhaImg[0]; }
                        
                                $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
                            });
                        }
                    }
                });
            };
        });
    });

    $(document).on("click", ".btnRejeitar", function () {
        var classes = $(this).attr("class").split(/\s+/);
        localStorage.setItem("emailCuidadorContrato", classes[1]);
        botao = 1;

        $.post("../../../lib/libContratarCuidador.aspx", { control: botao, emailCuidador: localStorage.getItem("emailCuidadorContrato") }, function (retorno) {
            if (retorno == "false") {
                console.log("deu erro na lib");
            }
            else {
                botao = 3;

                $.post("../../../lib/libContratarCuidador.aspx", { control: botao, emailCuidador: localStorage.getItem("emailCuidadorContrato") }, function (retorno) {
                    if (retorno == "false") {
                        console.log("deu erro na lib");
                    }
                    else {
                        if (retorno != "true") {
                            $('.listaCuidadores').html(retorno);
                            $(".areaCuidador").each(function (i, obj) {
                                var tinhaImg = $(this).children("div.invi").html().split("#");
                                if (tinhaImg[1] == "true" ){var url = "data:image/png;base64," + tinhaImg[0];}
                                else{ var url = "data:image/svg+xml;base64," + tinhaImg[0]; }
                        
                                $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
                            });
                        }
                    }
                });
            };
        });
    });

});