export default function scriptBuscarDadosPaciente() {

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
    $.post("http://3.96.217.5/lib/libBuscarDadosPaciente.aspx",  { cd: localStorage.getItem("cdPaciente") }, function (retorno) {
       
        if (!retorno) {
        	//$('#wrapper-paciente').html("ERRO NO RETORNO");
        	console.log('Houve um erro!');
        }

		else if (retorno == "") {
			$('#wrapper-paciente').html("Você ainda não tem pacientes cadastrados!");
			return;
		}
        else if (retorno == "usuarioIncorreto"){window.location.href = "../index.html"}
		else{

	        retorno = retorno.split("|");
	        console.log(retorno);
	        console.log(retorno[0]); $('#txtAlterarNomePaciente').val(retorno[0]);
	        
	        console.log(retorno[1]); 
	        //$('#txtAlterarNecessidadePaciente').append("<option selected>"+retorno[1]+"</option>");
	       	
	       	$.post("http://3.96.217.5/lib/libListarNecessidades.aspx", {}, function(retorno){

				if (retorno == 'erro') 
				{
					//console.log('deu erro na lib de listar as necessidades');
				}
				else
				{
					$('#txtAlterarNecessidadePaciente').html(retorno);
					//console.log('necessidades cadastradas');
				}

			});

	        $('#txtAlterarDescricaoPaciente').val(retorno[2]);
			$('#txtAlterarCEPPaciente').val(retorno[3]);
			$('#txtAlterarCidadePaciente').val(retorno[4]);
			$('#txtAlterarBairroPaciente').val(retorno[5]);
			$('#txtAlterarRuaPaciente').val(retorno[6]);
			$('#txtAlterarNumeroPaciente').val(retorno[7]);
			$('#txtAlterarComplementoPaciente').val(retorno[9]);
	      	var url = "data:image/png;base64," + retorno[10];
			$("#areaAlterarImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
	    	//localStorage.setItem('cdNecessidadesAntiga', retorno[11]);
	    }

    });
};
