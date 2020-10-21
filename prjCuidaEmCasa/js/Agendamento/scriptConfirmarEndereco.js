export default function scriptConfirmarEndereco () {

            var cd = localStorage.getItem("cdPaciente");
            var retorno = "";
            var map = document.getElementById('map');
            var img = document.createElement('img'); 
            
            

            
            $.post("../../lib/dadosEndereco.aspx", { cdPaciente: cd }, function (retorno) {

                if (retorno == "erro") {
                    console.log("deu erro");
                }

                retorno = retorno.split("/");
               

                localStorage.setItem("numEndereco", retorno[0]);$("#numEndereco").html(" "+retorno[0]);
                localStorage.setItem("nomeRua", retorno[1]);$("#nomeRua").html(retorno[1]);
                localStorage.setItem("nomeComplemento", retorno[2]);$("#nomeComplemento").html(retorno[2]);
                localStorage.setItem("nomeCidade", retorno[3]);$("#nomeCidade").html(retorno[3]);
                localStorage.setItem("nomeEstado", retorno[4]);$("#nomeEstado").html(retorno[4]);
                localStorage.setItem("nomeBairro", retorno[5]);$("#nomeBairro").html(retorno[5]);
                localStorage.setItem("cepEndereco", retorno[6]);
                

                var endereco =  "rua " + retorno[1] + ", "+retorno[0] +" bairro" + retorno[5]+ "  "+ retorno [3] + " - " + retorno[5]; 
                var apimaps = "api";
                img.src =  'https://maps.googleapis.com/maps/api/staticmap?center='+ endereco+'&zoom=13&size=300x300&maptype=roadmap&markers=color:blue|label:k|'+endereco+'&key='+ apimaps;

            
                document.getElementById('map').appendChild(img); 
            })
};

