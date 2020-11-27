export default function scriptBuscarDadosPaciente() {
	var retorno;
    $.post("../../lib/libBuscarDadosPaciente.aspx",  { cd: localStorage.getItem("cdPaciente") }, function (retorno) {
       
        if (!retorno) {
        	$('#wrapper-paciente').html("ERRO NO RETORNO");
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
	       	
	       	$.post('../../lib/libListarNecessidades.aspx', {}, function(retorno){

				if (retorno == 'erro') 
				{
					console.log('deu erro na lib de listar as necessidades');
				}
				else
				{
					$('#txtAlterarNecessidadePaciente').html(retorno);
					console.log('necessidades cadastradas');
				}

			});

	        console.log(retorno[2]); $('#txtAlterarDescricaoPaciente').val(retorno[2]);
	        console.log(retorno[3]); $('#txtAlterarCEPPaciente').val(retorno[3]);
	        console.log(retorno[4]); $('#txtAlterarCidadePaciente').val(retorno[4]);
	        console.log(retorno[5]); $('#txtAlterarBairroPaciente').val(retorno[5]);
	        console.log(retorno[6]); $('#txtAlterarRuaPaciente').val(retorno[6]);
	        console.log(retorno[7]); $('#txtAlterarNumeroPaciente').val(retorno[7]);
	        console.log(retorno[9]); $('#txtAlterarComplementoPaciente').val(retorno[9]);
	      	var url = "data:image/png;base64," + retorno[10];
			$("#areaAlterarImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");
	    	//localStorage.setItem('cdNecessidadesAntiga', retorno[11]);
	    }

    });
};
