import scriptAvaliacaoCuidador from '../AgendaCliente/scriptAvaliacaoCuidador.js';

$(document).ready(function(){

        var rating = 5;

        $(".counter").text(rating); 

        $("#rateYo").rateYo({
          rating: 1,
          numStars: 5,
          precision: 2,
          starWidth: "25px",
          spacing: "5px",
          fullStar: true,
          normalFill: "#646464",
          ratedFill: "#00000"
        });

       $("#rateYo").on("rateyo.init", function () { console.log("rateyo.init"); });

      var $rateYo = $("#rateYo").rateYo();


      $("#rateYo").click(function(){

         var value = $rateYo.rateYo("rating");
         
         switch (value)
         {
          case 1:
            $('#notaAvaliacaoEstrela').html(value + " - Pessimo");
            break;
          case 2:
            $('#notaAvaliacaoEstrela').html(value + " - Ruim");
            break;
          case 3: 
            $('#notaAvaliacaoEstrela').html(value + " - Regular");
            break;
          case 4:
            $('#notaAvaliacaoEstrela').html(value + " - Bom");
            break;
          case 5:
            $('#notaAvaliacaoEstrela').html(value + " - Excelente");
            break;
         }

         scriptAvaliacaoCuidador(value, localStorage.getItem('emailCuidador'));

    });


});