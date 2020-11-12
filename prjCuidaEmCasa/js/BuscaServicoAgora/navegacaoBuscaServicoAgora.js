import scriptbuscarCuidadorAgora from "./scriptbuscarCuidadorAgora.js";

$(document).ready(function () {

    if(!localStorage.getItem("tipoUsuario") == 3){
        alert("Você não tem acesso a essa página, realize o login novamente");
        localStorage.clear();
        window.location.href = "../../pages/index.html";
    }

    $(".iconeVoltar").click(function () {

    	$(".visivel").each(function (i, obj) {
	       $(this).removeClass("visivel");
	    });
        
        $("#wrapper-detalhesServico").css("display","none");


	    $("#wrapper-historicoServico").addClass("visivel");
	    $('#headerComum').addClass("visivel");

        scriptHistoricoServico();

    });
});