
export default function colocarDisponibilidadeDoDia(){
	 var value = $(".selected_date").html();            
            $(".horarioDia").html("");

            //console.log("dia selecionado:" +value);

            if(value!="" && window.disponibilidades!=undefined && window.disponibilidades!=null && window.disponibilidades[0]!=""){
                console.log("foram reconhecidas : " + window.disponibilidades.length +" disponibilidades");
                //console.log("vou colocar as disponibilidades: " + window.disponibilidades);
                
                for (var i = 0; i < window.disponibilidades.length; i++) {

                    var arrayAtual = window.disponibilidades[i];
                    arrayAtual = arrayAtual.replace('[', "");
                    arrayAtual = arrayAtual.replace(']', "");
                    arrayAtual = arrayAtual.split(',');
                    var dia = arrayAtual[0];
                    var horaInicio = arrayAtual[1];
                    var horaFim = arrayAtual[2];
                    console.log(dia+horaInicio+horaFim);
                    if(dia == value){
                        $(".horarioDia").append("<div class='alert alert-dark horarioDisponibilidade'>Hora Inicial: <span class='horaInicio'>"+horaInicio+"</span> Hora final: <span class='horaFim'>"+ horaFim +"</span></div>");
                        $(".horarioDia").children(".alert").last().append("<div class='' id='btnRemover'> remover  </div>");
                    }
                }

            }
            else{
                $(".output").html("Selecione um dia");
            }
}