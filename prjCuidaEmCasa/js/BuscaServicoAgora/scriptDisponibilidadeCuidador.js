export default function scriptDisponibilidadeCuidador(valor){

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
			//tornar disponivel
			$.post("../../lib/libDisponibilidadeCuidador.aspx", { ativo: valor, emailCuidador: localStorage.getItem('usuarioLogado') }, function(retorno){
				
				if (retorno == "erro") {
					alertErro('Houve um erro');
				}
				else
				{
					//console.log('ta disponivel');
					$("#btnDisponivel").removeClass("0");
					$("#btnDisponivel").addClass("1");
					$("#txtDisponibilidade").html("Torna-se Indisponível");
					$('.areaDisponibilidade').css("background", "#27AE60");
				}
				
			});
	}
	else
	{
			//tornar indisponivel
			$.post("../../lib/libDisponibilidadeCuidador.aspx", { ativo: valor, emailCuidador: localStorage.getItem('usuarioLogado') }, function(retorno){
				
				if (retorno == "erro") {
					alertErro('Houve um erro');
				}
				else
				{
					//console.log('ta indisponivel');
					$("#btnDisponivel").removeClass("1");
					$("#btnDisponivel").addClass("0");
					$("#txtDisponibilidade").html("Torna-se Disponível");
					$('.areaDisponibilidade').css("background", "#9D2F42");
				}

			});
	}


};