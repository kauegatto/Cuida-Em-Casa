import scriptPacientes from "./scriptPacientes.js";

export default function scriptExcluirPaciente(){

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

	$.post("http://3.96.217.5/lib/libExcluirPaciente.aspx", { cdPaciente: localStorage.getItem('cdPaciente')}, function(retorno){

		if (retorno == "erro") 
		{
			//console.log(' deu erro na lib excluir paciente');
			alertIonic('Houve um erro!');
		}
		else
		{
			//console.log('excluiu o paciente');
			alertIonic('Paciente excluido com sucesso!');
			scriptPacientes();
		}

	});


}


