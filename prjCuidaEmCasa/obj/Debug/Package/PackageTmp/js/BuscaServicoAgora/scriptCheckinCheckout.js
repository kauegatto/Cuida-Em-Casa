﻿export default function scriptCheckinCheckout(valor){

    if (valor == 0) 
		{
				//checkin
				$.post("../../lib/libCheckinCheckout.aspx", { ativo: valor, cdServico: localStorage.getItem('cdServico') }, function(retorno){
					
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
				$.post("../../lib/libCheckinCheckout.aspx", { ativo: valor, cdServico: localStorage.getItem('cdServico') }, function(retorno){
					
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