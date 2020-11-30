
export default function colocarDisponibilidadeDoDia(){
	        
            var value = $(".selected_date").html();

            $(".horarioDia").html("");

               
            if(value!="" && window.disponibilidades!=undefined && window.disponibilidades!=null && window.disponibilidades[0]!=""){
                
                for (var i = 0; i < window.disponibilidades.length; i++) {

                    var arrayAtual = window.disponibilidades[i];
                    arrayAtual = arrayAtual.replace('[', "");
                    arrayAtual = arrayAtual.replace(']', "");
                    arrayAtual = arrayAtual.split(',');
                    var dia = arrayAtual[0];
                    var horaInicio = arrayAtual[1];
                    var horaFim = arrayAtual[2];

                    if(dia == value){
                        $(".horarioDia").append("<div class='alert alert-dark horarioDisponibilidade'>Hora Inicial: <span class='horaInicio'>"+horaInicio+"</span><br> Hora final: <span class='horaFim'>"+ horaFim +"</span></div>");
                        $(".horarioDia").children(".alert").last().append("<div class='' id='btnRemover'> Remover  </div>");
                    }
                }

            }
            else{
                $(".output").html("Selecione um dia");
            }
}