$.post("../../lib/libDadosLogin.aspx", { email: $("#txtEmail").val(), senha: $("#txtSenha").val() }, function (retorno) {
    
    var retorno;
    retornoLogin = retorno.split("|");

    if (retorno[0] == "erro") {
        console.log("deu erro");
    }

    else {
        if (retorno[0] == "true") {

            if (retorno[1] == "1") {
                console.log("adm");
            }
            else if (retorno[1] == "2") {
                console.log("cliente");
            }

            else if (retorno[1] == "3") {
                console.log("cuidador"); 
            }

            else {
                alert("Coloca um login e senha certo na moral kkkkkkkk");
                localStorage.setItem("usuarioLogado", $("#txtEmail").val()); 
                localStorage.setItem("tipoUsuario", retorno[1]);       
            }
        }
    }
});