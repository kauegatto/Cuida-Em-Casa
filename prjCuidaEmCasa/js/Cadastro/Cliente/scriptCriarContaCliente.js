export default function scriptCriarContaCliente(){

    function alertErro() {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = 'Houve um erro no Cadastro !<br> <br> Por Favor preencha novamente seus dados.';
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

	$.post("../../../lib/libCriarContaCliente.aspx", { nomeCliente: localStorage.getItem("nomeCliente"), emailCliente: localStorage.getItem("emailCliente"), telefoneCliente: localStorage.getItem('telefoneCliente'), cpfCliente: localStorage.getItem('cpfCliente'), senhaCliente: localStorage.getItem('senhaCliente')}, function(retorno){

		if (retorno == "erro") {
			alertErro();
			$('.iconeVoltar').click();
		}
		else
		{
			window.location.href = "../../pages/cliente/atendimento.html";
		}

	});

}