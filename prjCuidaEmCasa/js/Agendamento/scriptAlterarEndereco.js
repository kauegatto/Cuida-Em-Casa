export default function scriptAlterarEndereco () {

        var CEP = $('#cep').val();
        var UF = $('#uf').val();
        var rua = $('#rua').val();
        var num = $('#num').val();
        var comp = $('#comp').val();
        var bairro = $('#bairro').val();
        var cidade = $('#cidade').val();

        if (CEP != "") {
            localStorage.setItem("cepEndereco", CEP)
            localStorage.setItem("numEndereco", num);
            localStorage.setItem("nomeRua", rua);
            localStorage.setItem("nomeComplemento", comp);
            localStorage.setItem("nomeCidade", cidade);
            localStorage.setItem("nomeEstado", UF);
            localStorage.setItem("nomeBairro", bairro);
        }
};