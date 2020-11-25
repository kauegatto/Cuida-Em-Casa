import scriptPacientes from "./scriptPacientes.js";

export default function scriptExcluirPaciente(){

	$.post("../../lib/libExcluirPaciente.aspx", { cdPaciente: localStorage.getItem('cdPaciente')}, function(retorno){

		if (retorno == "erro") 
		{
			console.log(' deu erro na lib excluir paciente');
		}
		else
		{
			console.log('excluiu o paciente');

			scriptPacientes();
		}

	});


}


