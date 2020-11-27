import scriptPacientesEmServico from './scriptPacientesEmServico.js';
import scriptInfoServicoAtual from './scriptInfoServicoAtual.js';


$(document).ready(function(){
    var autorizado;

    scriptPacientesEmServico();

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
    
    if($('#wrapper-pacienteServico').html() == "ERRO NO RETORNO" || $('#wrapper-pacienteServico').html() == "Nenhum de seus clientes está em serviço!"){
        return;
    }

    else{
        autorizado = true;
        $(".areaPaciente").each(function (i, obj) {
		    var url = "data:image/png;base64," + $(this).children('.invi').html();
            $(this).children(".areaImagemPaciente").css("background-image", "url('" + url.replace(/(\r\n|\n|\r)/gm, "") + "')");        		
	    });
        
    }
    
    $(document).on("click", ".areaPaciente", function(){
	            $(".areaPaciente").removeClass("selecionado");
	            $(this).addClass("selecionado");
	});
    
    $(document).on("click", "#btnPaciente", function(){

        if($('.selecionado').length){
            try{    
                var classes = $(".selecionado").attr("class").split(/\s+/);
                var cdServico =  classes[1];   
                $(".selecionado").removeClass("selecionado");
                scriptInfoServicoAtual(cdServico);
                $("#wrapper-pacienteServico").css("display","none");$("#wrapper-pacienteServico").removeClass("visivel");
                $("#wrapper-ServicoAtual").css("display","block");$("#wrapper-ServicoAtual").addClass("visivel");
            }
            catch {
                alertIonic("Por favor, escolha um paciente!");
                return;
            }
        }
           
        else{
            alertIonic("Por favor, escolha um paciente!!");
        }
    });

    $('.iconeVoltar').click(function(){

        window.location.href = 'atendimento.html';

    });
});
