export default function scriptFiltro(){	

        var filtroEspecializacao = $('.cbxEspecializacao').val();
        var filtroPreco = $('.cbxPreco').val().replace('Até R$', '').trim(); var intFiltroPreco; var intAvaliacao;
        var filtroGenero = $('.cbxGenero').val(); var infoGenero
        var filtroAvaliacao = $('.cbxAvaliacao').val().replace('Maior que:', '').trim();
        var vE,vP,vG,vA;

        if (filtroEspecializacao == "0") {vE = "false";}
      	else{vE = "true";}

    	if (filtroPreco == "") {
	    	vP = "false"; 
	    }
        else {
	        vP = "true";
	        intFiltroPreco = filtroPreco;
	    }

    	if (filtroGenero == "Selecione") {vG = "false";}
        else{vG = "true"; infoGenero = filtroGenero}

    	if (filtroAvaliacao == "") {vA = "false";}
        else{vA = "true"; intAvaliacao = filtroAvaliacao}

	  	$.post("../../lib/libBuscarCuidador.aspx", { d: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), hf: localStorage.getItem("horaFim"), filtro: "true", vA: vA, vP: vP, vG: vG, vE: vE,vEspecializacao: filtroEspecializacao, vPreco: intFiltroPreco,vAvaliacao: intAvaliacao,vGenero:infoGenero}, function (retorno) {
	       	console.log(retorno);
            var botao = "<button class='btnProximo' id='btnCuidador'>Próximo</button>";
	        if (retorno == "" || retorno == null){
                $('#wrapper-cuidador').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Erro no retorno</h2>");
	        }
	        else if (retorno == "false") {
	            $('#wrapper-cuidador').html("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Desculpe, mas não encontramos cuidadores nessas especificações</h2>");
	        }
            else {
                retorno = retorno.split("|");

	            $('#wrapper-cuidador').html(retorno[0] + botao);

	            $(".areaCuidador").each(function (i, obj) {
	                var url = "data:image/svg+xml;base64," + $(this).children("div.invi").html();
	                $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
	        
	            });
	            $(".areaCuidador").click(function (e) {
                    $(".areaCuidador").removeClass("selecionado");
                    $(this).addClass("selecionado");
                });
            }
	    });
}
