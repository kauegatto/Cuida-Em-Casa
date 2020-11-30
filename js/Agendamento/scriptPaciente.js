export default function scriptPaciente() {
	var retorno;
    $.post("http://3.96.217.5/lib/libBuscarPaciente.aspx",  { usuarioLogado: localStorage.getItem("usuarioLogado") }, function (retorno) {
        if (!retorno) {
        	$('#wrapper-paciente').html("ERRO NO RETORNO");
        }

		else if (retorno == "") {
			$('#wrapper-paciente').html("Você ainda não tem pacientes cadastrados!");
			return;
		}
        else if (retorno == "usuarioIncorreto"){window.location.href = "../index.html"}
		else{
	        var btnProx = "";
			$('#listaPacientes').append(retorno);
	        $(".areaPaciente").each(function (i, obj) {

		        var url = "data:image/png;base64," + $(this).children().eq(3).html();
		        $(this).children(":first").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");        		
	        });
    	}
    	
    	$(".areaPaciente").click(function (e) {
	            $(".areaPaciente").removeClass("selecionado");
	            $(this).addClass("selecionado");
		});
	});
};
