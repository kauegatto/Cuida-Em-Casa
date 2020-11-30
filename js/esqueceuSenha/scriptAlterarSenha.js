export default function scriptAlterarSenha(){

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

	if ($('#txtSenhaRecuperacao').val() != $('#txtConfirmacaoSenhaRecuperacao').val()) 
	{
		alertIonic('Senhas digitadas estão diferentes!');
	}
	else
	{
		$.post("http://3.96.217.5/lib/libAlterarSenhaRecuperacao.aspx", { cdRecuperacao: localStorage.getItem('cdRecuperacao'),emailUsuario: localStorage.getItem('emailUsuario'), senha: $('#txtSenhaRecuperacao').val()}, function(retorno){

			if (retorno == "erro") 
			{
				//console.log("deu erro na lib alterar senha recuperacao");
				alertIonic('Houve um erro!');
			}
			else
			{
				alertIonic('Senha Alterada com sucesso');
				window.location.href = "index.html";
			}

		});
	}

}