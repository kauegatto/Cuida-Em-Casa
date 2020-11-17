export default function scriptDisponibilidadeCuidador(valor){

		if (valor == 0) 
		{
				//tornar disponivel
				$.post("../../lib/libDisponibilidadeCuidador.aspx", { ativo: valor, emailCuidador: localStorage.getItem('usuarioLogado') }, function(retorno){
					
					if (retorno == "erro") {
						console.log("deu erro");
					}
					else
					{
						console.log('ta disponivel');
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
						console.log("deu erro");
					}
					else
					{
						console.log('ta indisponivel');
						$("#btnDisponivel").removeClass("1");
						$("#btnDisponivel").addClass("0");
						$("#txtDisponibilidade").html("Torna-se Disponível");
						$('.areaDisponibilidade').css("background", "#9D2F42");
					}

				});
		}


};