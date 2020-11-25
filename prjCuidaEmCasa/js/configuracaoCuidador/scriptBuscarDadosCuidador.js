export default function scriptBuscarDadosCuidador(){

	$('#txtAlterarTelefone').mask('(00) 00000-0000');
	$('#txtAlterarCPF').mask('000.000.000-00');

	$.post("../../lib/libEspecializacaoCuidador.aspx", function(retorno){

		if (retorno == "erro") 
		{
			console.log('deu erro na libEspecializacaoCuidador');
		}
		else
		{
			$('#especializacoesCuidador').html(retorno);
		}

	});

	$.post("../../lib/dadosEmailCuidador.aspx", { e: localStorage.getItem('usuarioLogado')}, function(retorno){

		if (retorno == "erro") 
		{
			console.log('deu erro na lib buscar dados cuidador');
		}
		else
		{

			console.log('trouxe os dados do cuidador');
			retorno = retorno.split('|');
			console.log(retorno);

			$('#txtAlterarValorHora').val(retorno[0]);
			$('#txtAlterarNomeCuidador').val(retorno[1]);

			if (retorno[3] == "Masculino") 
			{
				$('#generoMasculino').prop('selected',true);
			}
			else
			{
				if (retorno[3] == "Feminino") 
				{
					$('#generoFeminino').prop('selected',true);
				}
				else
				{
					$('#generoOutro').prop('selected',true);
				}
			}

			$('#txtDescricaoEspecializacao').val(retorno[4]);
			$('#txtDescricaoCuidador').val(retorno[5]);
			$('#invi').html(retorno[6]);
			$('#txtAlterarCPF').val(retorno[7]);
			$('#txtAlterarTelefone').val(retorno[8]);
			$('#txtAlterarLinkCurriculo').val(retorno[9]);

		}


	});

}