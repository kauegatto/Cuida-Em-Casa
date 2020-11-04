window.Mercadopago.setPublishableKey("TEST-06f36a5d-e8bf-4e09-a0cf-f9245242a3e5");

window.Mercadopago.getIdentificationTypes();
  
document.getElementById('cardNumber').addEventListener('change', guessPaymentMethod);

function guessPaymentMethod(event) {
    let cardnumber = document.getElementById("cardNumber").value;
    if (cardnumber.length >= 6) {
        let bin = cardnumber.substring(0,6);
        window.Mercadopago.getPaymentMethod({
            "bin": bin
        }, setPaymentMethod);
    }
}

function setPaymentMethod(status, response) {
    if (status == 200) {
        let paymentMethod = response[0];
        
        document.getElementById('paymentMethodId').value = paymentMethod.id;
        document.getElementById('cardNumber').style.backgroundImage = 'url(' + paymentMethod.thumbnail + ')';
        
        if(paymentMethod.additional_info_needed.includes("issuer_id")){
            getIssuers(paymentMethod.id);
        } else {
           // document.getElementById('issuerInput').classList.add("hidden");
           // getIssuers(paymentMethod.id);
           // getInstallments(
           //     paymentMethod.id,
           //   document.getElementById('transactionAmount').value
           // );
           getIssuers(paymentMethod.id);
        }

    } else {
        alert(`payment method info error: ${response}`);
    }
}

function getIssuers(paymentMethodId) {
   window.Mercadopago.getIssuers(
       paymentMethodId,
       setIssuers
   );
}

function setIssuers(status, response) {
   if (status == 200) {
       let issuerSelect = document.getElementById('issuer');
       response.forEach( issuer => {
           let opt = document.createElement('option');
           opt.text = issuer.name;
           opt.value = issuer.id;
           issuerSelect.appendChild(opt);
       });

       getInstallments(
           document.getElementById('paymentMethodId').value,
           document.getElementById('transactionAmount').value,
           issuerSelect.value
       );
   } else {
       alert(`issuers method info error: ${response}`);
   }
}

function getInstallments(paymentMethodId, transactionAmount, issuerId){
   window.Mercadopago.getInstallments({
       "payment_method_id": paymentMethodId,
       "amount": parseFloat("20"),
       "issuer_id": issuerId ? parseInt(issuerId) : undefined
   }, setInstallments);
}

function setInstallments(status, response){
   if (status == 200) {
       document.getElementById('installments').options.length = 0;
       response[0].payer_costs.forEach( payerCost => {
           let opt = document.createElement('option');
           opt.text = payerCost.recommended_message;
           opt.value = payerCost.installments;
           document.getElementById('installments').appendChild(opt);
       });
   } else {
       alert(`installments method info error: ${response}`);
   }
 }


doSubmit = false;
document.getElementById('paymentForm').addEventListener('submit', getCardToken);
function getCardToken(event){
   event.preventDefault();
   if(!doSubmit){
       let $form = document.getElementById('paymentForm');
       window.Mercadopago.createToken($form, setCardTokenAndPay);
       return false;
   }
};

function setCardTokenAndPay(status, response) {
   if (status == 200 || status == 201) {
       let form = document.getElementById('paymentForm');
       let card = document.createElement('input');
       //card.setAttribute('name', 'token');
       //card.setAttribute('type', 'hidden');
       //card.setAttribute('value', response.id);
       //form.appendChild(card);
       //doSubmit=true;form.submit();
       realizarPagamento(response.id);
   } else {
       alert("Verify filled data!\n"+JSON.stringify(response, null, 4));
   }
};

function realizarPagamento(cardToken) {
      
      let urlApi = 'https://api.mercadopago.com/v1/payments';
      let apiKey = 'Bearer TEST-5442897075228208-110414-2b1d83c67516b8ae0b214f4fa3e57298-141153426';
      alert(cardToken);
      const data = { "token":cardToken, "installments":2, "transaction_amount":99.80,"description":"Point Mini a maquininha que dá o dinheiro de suas vendas na hora","payment_method_id":"visa","payer":{ "email":"kauegatto@gmail.com","identification": {"number": "33580494856","type": "CPF"}}};
      const dataJSON = JSON.stringify(data);
      $.ajax({
        url: urlApi,
        type: 'POST',
        dataType: 'json',
        headers: { 'Authorization': apiKey },
        dataType: 'json',
        processData: false,
        data: dataJSON,
        success: function (resultado) {
          alert(JSON.stringify(resultado));doSubmit=true;form.submit();
        },
        error: function(){
          alert("Erro no post - ajax");doSubmit=true;form.submit();
        }
      });
}
    