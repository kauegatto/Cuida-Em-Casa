$(document).ready(function(){

        var rating = 1.6;

        $(".counter").text(rating);

        $("#rateYo").on("rateyo.init", function () { console.log("rateyo.init"); });

        $("#rateYo").rateYo({
          rating: rating,
          numStars: 5,
          precision: 2,
          starWidth: "64px",
          spacing: "5px",
          halfStar: true,
    rtl: true,
          multiColor: {

            startColor: "#000000",
            endColor  : "#ffffff"
          },
          onInit: function () {

            console.log("On Init");
          },
          onSet: function () {

            console.log("On Set");
          }
        }).on("rateyo.set", function () { console.log("rateyo.set"); })
          .on("rateyo.change", function () { console.log("rateyo.change"); });

        $(".rateyo").rateYo();

        $(".rateyo-readonly-widg").rateYo({

          rating: rating,
          numStars: 5,
          precision: 2,
          minValue: 1,
          maxValue: 5
        }).on("rateyo.change", function (e, data) {
        
          console.log(data.rating);
        });


});