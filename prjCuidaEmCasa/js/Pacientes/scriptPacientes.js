export default function scriptPacientes() {
	var retorno;
    $.post("../../lib/libBuscarPaciente.aspx",  { usuarioLogado: localStorage.getItem("usuarioLogado") }, function (retorno) {
       
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
			$('#wrapper-paciente').append(btnProx);
	        $(".areaPaciente").each(function (i, obj) {
	        	var url = "data:image/png;base64," + $(this).children().eq(3).html();
		        $(this).children(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
		        var divImagem = "<img src='../../img/icones/editarPaciente/editar.png' class='imgEditar'>";
		        $(this).append(divImagem);
	        });
    	}
    });
};
