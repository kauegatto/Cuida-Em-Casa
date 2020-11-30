export default function scriptCriarContaCuidador(){

	function alertErro() {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = 'Houve um erro no cadastrado <br> <br> Por Favor preencha seus dados novamente';
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

	$.post("http://3.96.217.5/lib/libCriarContaCuidador.aspx", { nomeCuidador: localStorage.getItem('nomeCuidador'), emailCuidador: localStorage.getItem('emailCuidador'), telefoneCuidador: localStorage.getItem('telefoneCuidador'), cpfCuidador: localStorage.getItem('cpfCuidador'), imgCuidador: localStorage.getItem('imgCuidador'), generoCuidador: localStorage.getItem('generoCuidador'), link: localStorage.getItem('linkCurriculo'), descricaoCuidador: localStorage.getItem('descricaoCuidador'), especializacaoCuidador: localStorage.getItem('especializacaoCuidador'), valorHora: localStorage.getItem('valorHora'), descricaoEspecializacao: localStorage.getItem('descricaoEspecializacao'), senhaCuidador: localStorage.getItem('senhaCuidador')}, function(retorno){

		if (retorno == "erro") 
		{
			alertErro();
			$('.iconeVoltar').click();
		}
		else
		{
			console.log('cuidador cadastrado');
		}

	});


};