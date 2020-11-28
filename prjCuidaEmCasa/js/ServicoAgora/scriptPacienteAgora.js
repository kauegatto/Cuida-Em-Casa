export default function scriptPacienteAgora() {


    function alertIonic(text) {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = text;
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

	var retorno;
    $.post("../../lib/libBuscarPaciente.aspx",  { usuarioLogado: localStorage.getItem("usuarioLogado") }, function (retorno) {
        if (!retorno) {
        	//$('#wrapper-paciente').html("ERRO NO RETORNO");
        	alertIonic('Houve um erro');
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