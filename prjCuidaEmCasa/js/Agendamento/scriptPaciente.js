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
	        retorno = retorno + retorno + retorno;
	        var btnProx = "";
			$('#listaPacientes').append(retorno);
			$('#wrapper-paciente').append(btnProx);
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
