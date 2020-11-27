﻿var urlApi = "https://api.mercadopago.com/v1/payments/search";
var idServico = "1230927205";
let apiKey = 'Bearer TEST-5442897075228208-110414-2b1d83c67516b8ae0b214f4fa3e57298-141153426';

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

$("#btnMostrarInfo").click(function () {

    $.ajax({

        url: urlApi+"?id="+idServico,
        type: 'GET',
        headers: { 'Authorization': apiKey },
        dataType: 'json',
        processData: false,

    }).done(function(response){
        console.log(JSON.stringify(response));
        alertIonic("Usuario = "+response.results[0].payer.email+"\nO pagamento foi: " + response.results[0].status);
        doSubmit = true; form.submit();

    }).fail(function(jqxhr, textStatus, error){
        alertIonic("Erro na busca de informações");
        //alert(jqxhr); 
        //doSubmit = true; form.submit();
    })

});