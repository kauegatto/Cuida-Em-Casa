export default function scriptConfirmarEndereco () {

        var cd = localStorage.getItem("cdPaciente");
        var lati = ""; var long = ""; var geocode = "var";


        $.post("../../lib/dadosEndereco.aspx", { cdPaciente: cd }, function (retorno) {

            if (retorno == "erro") {
                console.log("deu erro");
            }

            retorno = retorno.split("/");
            geocode = 'https://nominatim.openstreetmap.org/search?q=' + retorno[0] + "," + retorno[1] + ",";
            geocode += retorno[3] + ",+";
            geocode += retorno[4] + ",+";
            geocode += retorno[5] + ",+";
            geocode += "&format=json&polygon=1&addressdetails=0";
            console.log(geocode);

            localStorage.setItem("numEndereco", retorno[0]);$("#numEndereco").html(retorno[0]);
            localStorage.setItem("nomeRua", retorno[1]);$("#nomeRua").html(retorno[1]);
            localStorage.setItem("nomeComplemento", retorno[2]);$("#nomeComplemento").html(retorno[2]);
            localStorage.setItem("nomeCidade", retorno[3]);$("#nomeCidade").html(retorno[3]);
            localStorage.setItem("nomeEstado", retorno[4]);$("#nomeEstado").html(retorno[4]);
            //geocode = 'https://nominatim.openstreetmap.org/search?q=' + retorno + '&format=json&polygon=1&addressdetails=1';
            $.getJSON(geocode, function (data) {
                try{
                    lati = data[0].lat;

                    long = data[0].lon;
                    map = L.map('areaMapa').setView([lati, long], 15);
                    marcador = L.marker(map.getCenter()).addTo(map);
                    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
                }   
                catch{
                    $('#areaMapa').html("erro na busca do mapa");
                }         
            });

        });




}   ;

