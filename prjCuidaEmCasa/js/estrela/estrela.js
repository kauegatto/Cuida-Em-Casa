$(document).ready(function(){

        var rating = 5;

        $(".counter").text(rating); 

        $("#rateYo").rateYo({
          rating: 1,
          numStars: 5,
          precision: 2,
          starWidth: "20px",
          spacing: "5px",
          halfStar: true,
          normalFill: "#646464",
          ratedFill: "#00000"
        });

       $("#rateYo").on("rateyo.init", function () { console.log("rateyo.init"); });

      var $rateYo = $("#rateYo").rateYo();

      $("#rateYo").click(function(){

         var value = $rateYo.rateYo("rating");
         console.log(value);
      });

       

        


});