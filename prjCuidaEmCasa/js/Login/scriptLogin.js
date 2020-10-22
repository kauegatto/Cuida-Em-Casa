$(document).on("click", "#btnLogin", function(){
    $.post("../../lib/libDadosLogin.aspx", { email: $("#txtEmail").val(), senha: $("#txtSenha").val() }, function (retorno) {
        
        var retorno;
        retornoLogin = retorno.split("|");
        
        console.log(retornoLogin);

        if (retorno[0] == "erro") {
            console.log("deu erro");
        }

        else {
            if (retornoLogin[0] == "true") {

                if (retornoLogin[1] == "1") {
                    console.log("adm");
                }
                else if (retornoLogin[1] == "2") {
                    console.log("cliente");
                }

                else if (retornoLogin[1] == "3") {
                    console.log("cuidador"); 
                }

                
                localStorage.setItem("usuarioLogado", $("#txtEmail").val()); 
                localStorage.setItem("tipoUsuario", retorno[1]);       
                
            }
            else {
                    console.log("O login e/ou senha inserida é inválido");
            }
        }
    });
});

