export default function scriptBuscarCuidadorAgora() {

    function alertErro() {
        const alert = document.createElement('ion-alert');
        alert.cssClass = 'alertBonito';
        alert.header = 'Atenção';
        alert.subHeader = '';
        alert.message = 'Houve um erro';
        alert.buttons = ['OK'];

        document.body.appendChild(alert);
        return alert.present();
    }

    $.post("http://3.96.217.5/lib/libBuscarCuidadorAgora.aspx", { usuario: localStorage.getItem("usuarioLogado"), indice: localStorage.getItem("indice") }, function(retorno){
            
        if (retorno == "erro") {
           alertErro();
        }

        if (retorno == "" || retorno == "false") {
            $(".areaServicoEncontrado").html("");
            $(".areaServicoEncontrado").css("display", "none");
        }  
        else {
            $(".areaServicoEncontrado").html(retorno);
            $(".areaServicoEncontrado").css("display", "block");
            localStorage.setItem("indice", "1");
        }
    });
};