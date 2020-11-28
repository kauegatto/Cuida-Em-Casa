//localStorage.clear();

$(document).on("click", "#btnLogin", function () {

    function presentAlert(textoAlerta) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'teste';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = textoAlerta;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

    $.post("../../lib/libDadosLogin.aspx", { email: $("#txtEmail").val(), senha: $("#txtSenha").val() }, function (retorno) {

        var retorno;
        retornoLogin = retorno.split("|");

        console.log(retornoLogin);

        if (retorno[0] == "erro") {
            console.log("deu erro");
        }

        else {
            if (retornoLogin[0] == "true") {
                localStorage.setItem("usuarioLogado", $("#txtEmail").val());

                localStorage.setItem("tipoUsuario", retornoLogin[1]);

                localStorage.setItem('SituacaoUsuario', retornoLogin[2]);

                if (retornoLogin[1] == "1") {
                    window.location.href = "../../pages/administrador/contratarCuidador.html";
                }
                else if (retornoLogin[1] == "2") {
                    window.location.href = "../../pages/cliente/atendimento.html";
                }

                else if (retornoLogin[1] == "3") {
                    if(retornoLogin[2] != "1"){
                        if(retornoLogin[2]=="2"){
                            presentAlert("Você ainda não foi aceito como um de nossos cuidadores, mas não se preocupe, você receberá um e-mail em breve sobre sua situação. Fique de olho!");
                        }
                        else if(retornoLogin[2]=="3");
                            presentAlert("Você foi suspenso por tempo indeterminado do nosso sistema por condutas inadequadas. Você recebeu um email explicando melhor");
                        }
                        else if(retornoLogin[4]=="4"){
                         presentAlert("Você foi demitido de nosso sistema");
                        }
                    else{
                        window.location.href = "../../pages/cuidador/servicoAgendado.html";
                    }
                }

            }
            else {
                presentAlert("O login e/ou senha inserida é inválido, tente novamente!");
            }
        }
    });
});

