$(document).on("click", "#btnLogin", function () {
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

                if (retornoLogin[1] == "1") {
                    console.log("adm");
                }
                else if (retornoLogin[1] == "2") {
                    window.location.href = "../../pages/cliente/atendimento.html";
                }

                else if (retornoLogin[1] == "3") {
                    window.location.href = "../../pages/cuidador/servicoAgendado.html";
                }

            }
            else {
                console.log("O login e/ou senha inserida é inválido");
            }
        }
    });
});

