$(document).ready(function(){

  var payment_method_id;

  doSubmit = false;

  let form = document.getElementById('paymentForm');

  window.Mercadopago.setPublishableKey("TEST-06f36a5d-e8bf-4e09-a0cf-f9245242a3e5");

  window.Mercadopago.getIdentificationTypes();

  document.getElementById('cardNumber').addEventListener('change', guessPaymentMethod);

  document.getElementById('paymentForm').addEventListener('submit', getCardToken);

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
          alertIonic(`payment method info error: ${response}`);
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
         alertIonic(`issuers method info error: ${response}`);
     }
  }

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
         alertIonic(`installments method info error: ${response}`);
     }
   }


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
         let card = document.createElement('input');
         //card.setAttribute('name', 'token');
         //card.setAttribute('type', 'hidden');
         //card.setAttribute('value', response.id);
         //form.appendChild(card);
         //doSubmit=true;form.submit();
         realizarPagamento(response.id);
     } else {
         alertIonic("Cartão de crédito inválido");
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
                break
            case "FUND":
                alertIonic("Esse cartão não tem saldo suficiente");
                break;
            case "EXPI":
                alertIonic("O cartão inserido apresentou informações inválidas");
                break;
            case "CALL":
                alertIonic("O cartão inserido foi recusado, mas nao deveria ter sido.");
                break;
            case "OTHE":
                alertIonic("Erro na API");
                break;
            default:
                alertIonic("Erro desconhecido, contate o desenvolvedor");
                break;
          }
          
            


        }).fail(function (jqxhr, textStatus, error) {    
            var customErrorCode = jqxhr.responseJSON.cause[0].code;
            console.log(customErrorCode);
            switch (customErrorCode) {
              case 2067:
                alertIonic("Erro no número do documento");
                break;
              case 2006:
                alertIonic("Cartão de crédito inválido");
                break;
              case 2007:
                alertIonic("Erro na conexão da api de tokenização do cartão");
                break;
              case 2009:
                alertIonic("A empresa emissora do cartão não deve estar nula");
                break;
              case 2060:
                alertIonic("Você não pode comprar um produto de si mesmo!");
                break;
              case 3000:
                alertIonic("Digite o nome do dono do cartão de crédito");
                break;
              case 3020:
                alert("Digite o nome do dono do cartão de crédito");
                break;
              case 3021:
                alertIonic("Digite o número do documento do comprador");
                break;
              case 3022:
                alertIonic("Selecione o tipo do documento;");
                break;
              case 3029:
                alertIonic("Mês de vencimento do cartão está incorreto;");
                break;
              case 3030:
                alertIonic("Ano de vencimento do cartão está incorreto;");
                break;
              case 4003:
                alertIonic("Valor do pedido deve ser numérico");
                break;
              case 1:
                alertIonic("Erro nos parâmetros;");
                break;
              default:
                alertIonic("Desculpe, um erro inesperado aconteceu. O código de debug é: " +jqxhr);
            }
        });
    }
    function comprovarPagamento (){
      
      $.post("../../lib/libFinalizarServico.aspx", { dtInicioServico: localStorage.getItem("data"), horaInicio: localStorage.getItem("horaInicio"), horaFim: localStorage.getItem("horaFim"), cep: localStorage.getItem("cepEndereco"), cidade: localStorage.getItem("nomeCidade"), bairro: localStorage.getItem("nomeBairro"), rua: localStorage.getItem("nomeRua"), num: localStorage.getItem("numEndereco"), estado: localStorage.getItem("nomeEstado"), comp: localStorage.getItem("nomeComplemento"), cliente: localStorage.getItem("usuarioLogado"), cuidador: localStorage.getItem("emailCuidador"), cdPaciente: localStorage.getItem("cdPaciente")}, function (retorno)
      {
          retorno = retorno.split("|");
          if (!retorno[0]) {
              alertIonic("Erro na hora de cadastrar serviço");
          }
          else {
              localStorage.setItem("cdServico",retorno[1]);
              alertIonic("pagamento aprovado");
              doSubmit=true;
              window.location.href = "../pagamento/cliente/agendaCliente.html";
              form.submit();
          }
      });
    }
        

});
