export default function scriptBuscarDadosPaciente() {
	
	var retorno;
	var imgPaciente;
	var descricao = $('#txtAlterarDescricaoPaciente').val();
	var CEP =  $('#txtAlterarCEPPaciente').val();
	var cidade =  $('#txtAlterarCidadePaciente').val();
	var bairro = $('#txtAlterarBairroPaciente').val();
	var rua = $('#txtAlterarRuaPaciente').val();
	var nome = $('#txtAlterarNomePaciente').val();
	var uf = "SP";
	var numero = $('#txtAlterarNumeroPaciente').val();
	var complemento = $('#txtAlterarComplementoPaciente').val();
	var cdPaciente = localStorage.getItem("cdPaciente");

	var input = document.getElementById("uploadImgUsuario");
	var fReader = new FileReader();
	fReader.readAsDataURL(input.files[0]);
	fReader.onloadend = function(event){
		console.log(event.target.result);
		imgPaciente = event.target.result;
		localStorage.setItem('imagemPaciente', imgPaciente);
	}

    $.post("../../lib/libAtualizarDadosPaciente.aspx",  { imagemPaciente: localStorage.getItem('imagemPaciente'), cd: cdPaciente, nome: nome, uf: uf, descricao: descricao, CEP: CEP, cidade: cidade, bairro: bairro, rua:rua, numero:numero, complemento:complemento }, function (retorno) {
       
        if (!retorno) {
        	$('#wrapper-paciente').html("ERRO NO RETORNO");
        }

		else if (retorno == "") {
			$('#wrapper-paciente').html("Você ainda não tem pacientes cadastrados!");
			return;
		}
        else if (retorno == "usuarioIncorreto"){window.location.href = "../index.html"}
		else{
	        alert("Os dados do(a) cliente "+nome+" foram alterados com sucesso!");
	        console.log(retorno);	      
	    }
    });
};
