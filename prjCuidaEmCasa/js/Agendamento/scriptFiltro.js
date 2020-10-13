export default function scriptFiltro(){	

        var filtroEspecializacao = $('.cbxEspecializacao').val();
        var filtroPreco = $('.cbxPreco').val();
        var filtroGenero = $('.cbxGenero').val();
        var filtroAvaliacao = $('.cbxAvaliacao').val();
        var vE,vP,vG,vA;

        if (filtroEspecializacao == "Selecione") {
            vE = "false";
        }
      	else{
      		vE = "true";
      	}

    	if (filtroPreco == "Selecione") {
            vP = "false";
        }
        else{
      		vP = "true"
      	}

    	if (filtroGenero == "Selecione") {
            vG = "false";
        }
        else{
      		vG = "true";
      	}

    	if (filtroAvaliacao == "Selecione") {
           vA = "false";
        }
        else{
      		vA = "true";
      	}

      	//console.log($('#cbxEspecializacao').val());
      	//console.log($('#cbxGenero').val());
	  	$.post("../../lib/libBuscarCuidador.aspx", { d: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), hf: localStorage.getItem("horaFim"), filtro: "true", vA: vA, vP: vP, vG: vG, vE: vE,vEspecializacao: filtroEspecializacao, vPreco: filtroPreco,vAvaliacao: filtroAvaliacao,vGenero:filtroGenero}, function (retorno) {
	       	var botao = "<button class='btnProximo' id='btnFinalizarServico'>Finalizar</button>";
	        retorno = retorno.split("|");
	        if (retorno[0] == "" || retorno[0] == null){
	            $('#wrapper-cuidador').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Desculpe, mas não encontramos cuidadores nesse horário</h2>");
	        }
	        else if (!retorno[0] || retorno[0] == "false") {
	            $('#wrapper-cuidador').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Erro no retorno</h2>");
	        }
	        $('#wrapper-cuidador').html(retorno[0] + botao);

	        $(".areaCuidador").each(function (i, obj) {
	            var url = "data:image/svg+xml;base64," + $(this).children("div.invi").html();
	            $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
	        
	        });
	    

	    });
}
