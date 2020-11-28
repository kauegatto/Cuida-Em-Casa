import scriptBuscarDadosCliente from './scriptBuscarDadosCliente.js';

export default function scriptAtualizarDadosCliente(){

	var nmCliente = $('#txtAlterarNomeCliente').val();
	var telCliente = $('#txtAlterarTelefoneCliente').val();
	var cpf = $('#txtAlterarCpfCliente').val();

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

	$.post("../../lib/libAtualizarDadosCliente.aspx", { nomeCliente: nmCliente, telefoneCliente: telCliente, cpfCliente: cpf, emailCliente: localStorage.getItem('usuarioLogado')}, function(retorno){

		if (retorno == "erro") 
		{
			//console.log('deu erro na lib atualizar dados');
			alertIonic('Houve um erro! <br> <br> Por Favor preencha os dados novamente.');
		}
		else
		{
			//console.log('deu certo alterou dados');
			alertIonic('Dados Altetado com sucesso!');
			scriptBuscarDadosCliente();
			$('.iconeVoltar').click();
		}


	});

}