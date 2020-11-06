export default function scriptDetalheHistoricoCliente(cdServico) {

	$.post("../../lib/libDetalheHistoricoCliente.aspx", { codigoServico: cdServico}, function(retorno) {

		if (retorno == "erro") 
		{
			console.log("deu erro");
		}
		else
		{
			var dados;
			dados = retorno.split(';');
			console.log(dados);

			$('.invi').html(dados[0]);

			$(".areaInformacoesCuidador").each(function (i, obj) {
				var url = "data:image/svg+xml;base64," + $(this).children('.invi').html();
                 $(this).children(".areaImagemCuidador").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
            });

			$('#nomeCuidador').html(dados[1]);
			$('#estrela').html(dados[2] + " " + dados[3]);
			$('#especializacao').html(dados[4]);
			$('#generoCuidador').html(dados[5]);
			$('#descricaoCuidador').html(dados[6]);
			$('#enderecoServico').html(dados[7] + " - " + dados[8] + " - " + dados[9]  + " - " +  dados[10]  + " - " + dados[11] + " - " + dados[12]);
			$('#horarioServico').html(dados[13] + " - " + dados[14]);
			$('#valorTotal').html(dados[15] + " Reais");
			localStorage.setItem('emailCuidador', dados[16]);
		}

	});

}