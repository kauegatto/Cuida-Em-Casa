export default function scriptAlterarSenha(){

	if ($('#txtSenhaRecuperacao').val() != $('#txtConfirmacaoSenhaRecuperacao').val()) 
	{
		alert('Senhas digitadas estão diferentes')
	}
	else
	{
		$.post("../../lib/libAlterarSenhaRecuperacao.aspx", { cdRecuperacao: localStorage.getItem('cdRecuperacao'),emailUsuario: localStorage.getItem('emailUsuario'), senha: $('#txtSenhaRecuperacao').val()}, function(retorno){

			if (retorno == "erro") 
			{
				console.log("deu erro na lib alterar senha recuperacao");
			}
			else
			{
				alert('Senha Alterada com sucesso');
				window.location.href = "index.html";
			}

		});
	}

}