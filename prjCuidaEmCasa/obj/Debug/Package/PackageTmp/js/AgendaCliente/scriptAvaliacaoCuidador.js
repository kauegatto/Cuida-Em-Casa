export default function scriptAvaliacaoCuidador(notaAvaliacao, emailCuidador) {

	$.post("http://3.96.217.5/lib/libAvaliacaoCuidador.aspx", { na: notaAvaliacao, ec: emailCuidador }, function(retorno){

		if (retorno == "erro") {
			console.log('deu erro na estrela mano arruma ai slc');
		}
		else
		{
			console.log('o cuidador foi avaliado slc fi mandou mt!');
		}

	});


}