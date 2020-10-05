$(document).ready(function () {

    $.post("../../lib/libBuscarPaciente.aspx", function (retorno) {
        if (!retorno) {
        	$('#wrapper-paciente').html("ERRO NO RETORNO");
        }
		else if (retorno == "") {
			$('#wrapper-paciente').html(retorno);
			return;
		}
		else{
			console.log(retorno);
	        retorno = retorno + "<button class='btnProximo navBtn' type='button'>Próximo</button>";
			$('#wrapper-paciente').html(retorno);
	        $(".areaPaciente").each(function (i, obj) {
	            url = "data:image/png;base64," + $(this).children().eq(3).html();
	            $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
	        });
    	}
    	
    	$(".areaPaciente").click(function (e) {
	            $(".areaPaciente").removeClass("selecionado");
	            $(this).addClass("selecionado");
	        });

		$(".btnProximo").click(function () {
	            var classes = $(".selecionado").attr("class").split(/\s+/);
	            localStorage.setItem("cdPaciente", classes[1]);
	        });

    	}); 
});