export default function scriptCheckinCheckout(valor){

	function alertCerto(text) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

    function alertErro(text) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

    if (valor == 0) 
		{
				//checkin
				$.post("http://3.96.217.5/lib/libCheckinCheckout.aspx", { ativo: valor, cdServico: localStorage.getItem('cdServico') }, function(retorno){
					
					if (retorno == "erro") {
						alertErro('Houve um erro!')
					}
					else
					{
						alertCerto('Check-In marcado com sucesso!');
					}
					
				});
		}
		else
		{
				//checkout
				$.post("http://3.96.217.5/lib/libCheckinCheckout.aspx", { ativo: valor, cdServico: localStorage.getItem('cdServico') }, function(retorno){
					
					if (retorno == "erro") {
						alertErro('Houve um erro!')
					}
					else
					{
						alertCerto('Check-Out marcado com sucesso!');
					}

				});
		}

};