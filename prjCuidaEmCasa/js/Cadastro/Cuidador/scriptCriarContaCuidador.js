export default function scriptCriarContaCuidador(){

	$.post("../../lib/libCriarContaCuidador.aspx", { nomeCuidador: localStorage.getItem('nomeCuidador'), emailCuidador: localStorage.getItem('emailCuidador'), telefoneCuidador: localStorage.getItem('telefoneCuidador'), cpfCuidador: localStorage.getItem('cpfCuidador'), imgCuidador: localStorage.getItem('imgCuidador'), generoCuidador: localStorage.getItem('generoCuidador'), link: localStorage.getItem('linkCurriculo'), descricaoCuidador: localStorage.getItem('descricaoCuidador'), especializacaoCuidador: localStorage.getItem('especializacaoCuidador'), valorHora: localStorage.getItem('valorHora'), descricaoEspecializacao: localStorage.getItem('descricaoEspecializacao'), senhaCuidador: localStorage.getItem('senhaCuidador')}, function(retorno){

		if (retorno == "erro") 
		{
			console.log('deu erro na lib de criar o cuidador');
		}
		else
		{
			console.log('cuidador cadastrado');
		}

	});


};