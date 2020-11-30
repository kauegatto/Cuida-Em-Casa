export default function scriptAceitarServico(){

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

    $.post("http://3.96.217.5/lib/libAceitarServicoAgora.aspx", { cdServico: localStorage.getItem("cdServico"), emailCuidador: localStorage.getItem("usuarioLogado") }, function (retorno) {
        
        if (!retorno) {
            alertErro();
        }
        
    });

};