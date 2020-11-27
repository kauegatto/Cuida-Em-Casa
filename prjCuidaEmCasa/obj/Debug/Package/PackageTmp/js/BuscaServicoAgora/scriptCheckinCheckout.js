export default function scriptCheckinCheckout(valor){

    if (valor == 0) 
		{
				//checkin
				$.post(http://3.96.217.5/lib/libCheckinCheckout.aspx", { ativo: valor, cdServico: localStorage.getItem('cdServico') }, function(retorno){
					
					if (retorno == "erro") {
						console.log("deu erro");
					}
					else
					{
						console.log("marcou o checkin");
					}
					
				});
		}
		else
		{
				//checkout
				$.post("http://3.96.217.5/lib/libCheckinCheckout.aspx", { ativo: valor, cdServico: localStorage.getItem('cdServico') }, function(retorno){
					
					if (retorno == "erro") {
						console.log("deu erro");
					}
					else
					{
						console.log("marcou o checkout");
					}

				});
		}

};