export default function scriptPaciente() {
    $.post("../../lib/libBuscarPaciente.aspx", function (retorno) {
        if (!retorno) {
        	$('#wrapper-paciente').html("ERRO NO RETORNO");
        }
		else if (retorno == "") {
			$('#wrapper-paciente').html(retorno);
			return;
		}
		else{
	        //retorno = retorno + "<button class='btnProximo navBtn' id='btnPaciente' type='button'>Próximo</button>";
			$('#wrapper-paciente').append(retorno);
	        $(".areaPaciente").each(function (i, obj) {
	        var url = "data:image/png;base64," + $(this).children().eq(3).html();
	            $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
	        });
	        console.log("Pacientes encontrados!");
    	}
    	
    	$(".areaPaciente").click(function (e) {
	            $(".areaPaciente").removeClass("selecionado");
	            $(this).addClass("selecionado");
	        });
	});
};
