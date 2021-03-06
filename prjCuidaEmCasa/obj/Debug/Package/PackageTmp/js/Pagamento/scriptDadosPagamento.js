﻿$(document).ready(function(){
  window.Mercadopago.setPublishableKey("TEST-06f36a5d-e8bf-4e09-a0cf-f9245242a3e5");

  window.Mercadopago.getIdentificationTypes();
    
  document.getElementById('cardNumber').addEventListener('change', guessPaymentMethod);

  /*$( "#cardNumber" ).on( "change", function( event ) {
    console.log(event);
    guessPaymentMethod(event);
  });
  */

  function guessPaymentMethod(event) {
      let cardnumber = document.getElementById("cardNumber").value;
      cardnumber = cardnumber.replace(" ","");
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
          document.getElementById('bandeira').style.backgroundImage = 'url(' + paymentMethod.thumbnail + ')';
          
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
  var payment_method_id;
  function getInstallments(paymentMethodId, transactionAmount, issuerId){
     window.Mercadopago.getInstallments({
         "payment_method_id": paymentMethodId,
         "amount": parseFloat("20"),
         "issuer_id": issuerId ? parseInt(issuerId) : undefined
     }, setInstallments);
     payment_method_id = paymentMethodId;
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

  // $( "#paymentForm" ).on( "submit", function( event ) {
  //   getCardToken(event);
  // });

  function getCardToken(event){
     event.preventDefault();
     if(!doSubmit){
         let $form = document.getElementById('paymentForm');
         window.Mercadopago.createToken($form, setCardTokenAndPay);

         return false;
     }
  };

  let form = document.getElementById('paymentForm');

  function setCardTokenAndPay(status, response) {
     if (status == 200 || status == 201) {
         
         console.log("setCardTokenAndPay -> 200/201");
         let card = document.createElement('input');
         card.setAttribute('name', 'token');
         card.setAttribute('type', 'hidden');
         card.setAttribute('value', response.id);
         form.appendChild(card);
         
         //doSubmit=true;form.submit();
         realizarPagamento(response.id);
     } else {
        console.log(status);
        console.log(response.message);
        alert("setCardTokenAndPay -> Verifique os dados do cartão e seu portador.");
     }
  };

  function realizarPagamento(cardToken) {
        
        let urlApi = 'https://api.mercadopago.com/v1/payments';
        
        let apiKey = 'Bearer TEST-5442897075228208-110414-2b1d83c67516b8ae0b214f4fa3e57298-141153426';

        var installments = parseInt($('select[name="installments"] option').filter(':selected').val());/**/console.log(installments);
        
        var transactionAmount = parseFloat($('input[name ="transactionAmount"]').val());/**/console.log(transactionAmount);
        
        var email = localStorage.getItem("usuarioLogado");console.log(email);
        
        var docNumber = parseInt($('input[name ="docNumber"]').val());/**/console.log(docNumber);
        
        var docType = $('select[name="docType"] option').filter(':selected').val();/**/console.log(docType);

        const data = { "token":cardToken, "installments":installments, "transaction_amount":transactionAmount,"description":"Servico de cuidadoria - Cuida Em Casa","payment_method_id":payment_method_id,"payer":{ "email":email,"identification": {"number": docNumber ,"type": docType }}};
        const dataJSON = JSON.stringify(data);

        $.ajax({
          url: urlApi,
          type: 'POST',
          dataType: 'json',
          headers: { 'Authorization': apiKey },
          dataType: 'json',
          processData: false,
          data: dataJSON,
        }).done(function(result){
          
          resultado = JSON.stringify(result.status);
          console.log(resultado)
          resultado = resultado.replace(/"/g,"");
          switch (resultado){
          case "approved":
              comprovarPagamento();
              alert("pagamento aprovado");
              break
          case "FUND":
              alert("Esse cartão não tem saldo suficiente");
              break;
          case "EXPI":
              alert("O cartão inserido apresentou informações inválidas");
              break;
          case "CALL":
              alert("O cartão inserido foi recusado, mas nao deveria ter sido.");
              break;
          case "OTHE":
              alert("Erro na API");
              break;
          default:
              alert("Erro desconhecido, contate o desenvolvedor");
              break;
          }
          
            doSubmit=true;
            form.submit();


        }).fail(function (jqxhr, textStatus, error) {    
            var customErrorCode = jqxhr.responseJSON.cause[0].code;
            console.log(customErrorCode);
            switch (customErrorCode) {
              case 2067:
                alert("Erro no número do documento");
                break;
              case 2006:
                alert(" Fail request api -> Cartão de crédito inválido");
                break;
              case 2007:
                alert("Erro na conexão da api de tokenização do cartão");
                break;
              case 2009:
                alert("A empresa emissora do cartão não deve estar nula");
                break;
              case 2060:
                alert("Você não pode comprar um produto de si mesmo!");
                break;
              case 3000:
                alert("Digite o nome do dono do cartão de crédito");
                break;
              case 3020:
                alert("Digite o nome do dono do cartão de crédito");
                break;
              case 3021:
                alert("Digite o número do documento do comprador");
                break;
              case 3022:
                alert("Selecione o tipo do documento;");
                break;
              case 3029:
                alert("Mês de vencimento do cartão está incorreto;");
                break;
              case 3030:
                alert("Ano de vencimento do cartão está incorreto;");
                break;
              case 4003:
                alert("Valor do pedido deve ser numérico");
                break;
              case 1:
                alert("Erro nos parâmetros;");
                break;
              default:
                alert("Desculpe, um erro inesperado aconteceu. O código de debug é: " +jqxhr);
            }

        });
  }

  function comprovarPagamento (){
      let cdServico =  localStorage.getItem("cdServico"); console.log(cdServico);
      $.post("http://3.96.217.5/lib/libConfirmarPagamento.aspx", { cdServico: cdServico }, function (retorno) {
          if (!retorno) {
                alert("Ocorreu um erro na hora de registrar o pagamento de seu pedido, contate a cuida em casa!");
                window.location.href = "cliente/agendamento.html"
          }
      });
  }
});
