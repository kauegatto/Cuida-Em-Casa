export default function scriptAlterarEndereco () {

        var CEP = $('#cep').val();
        var UF = $('#uf').val();
        var rua = $('#rua').val();
        var num = $('#num').val();
        var comp = $('#comp').val();
        var bairro = $('#bairro').val();
        var cidade = $('#cidade').val();

        localStorage.setItem("enderecoServico", rua + ", " + num + " " + comp + ", " + cidade + ", " + UF);

};