using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace prjCuidaEmCasa.classes.Agendamento
{
    public class clsUsuario: clsBanco_32623 
    {
        public string emailUsuarioBusca { get; set; }
        public string tipoUsuario { get; set; }
        public string codigoOcrrencia { get; set; }
        public string telefoneUsuario { get; set; }
        public string senhaVerificada { get; set; }

        public clsUsuario(): base()
        {
            emailUsuarioBusca = "";
            tipoUsuario = "";
            codigoOcrrencia = "";
            senhaVerificada = "";
        }

        #region Verificar login usuario
        public bool verificarLogin(string emailUsuario, string senhaUsuario)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[2, 2];
            valores[0, 0] = "vEmailUsuario";
            valores[0, 1] = emailUsuario;
            valores[1, 0] = "vSenha";
            valores[1, 1] = senhaUsuario;
            
            if (!Procedure("verificarLogin", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    emailUsuarioBusca = dados[0].ToString();
                    tipoUsuario = dados[1].ToString();
                    telefoneUsuario = dados[2].ToString();
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
            }
            return true;
        }
        #endregion 

        #region Alterar senha
        public bool alterarSenha(string novaSenha, string emailUsuario)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[2, 2];
            valores[0, 0] = "vNovaSenha";
            valores[0, 1] = novaSenha;
            valores[1, 0] = "vEmailUsuario";
            valores[1, 1] = emailUsuario;
            if (!Procedure("alterarSenha", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true; 
        }
        #endregion

        #region Verificar Senha 

        public bool verificarSenha(string emailUsuario, string senhaAtual) 
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[2, 2];
            valores[0, 0] = "vEmailUsuario";
            valores[0, 1] = emailUsuario;
            valores[1, 0] = "vSenhaAtual";
            valores[1, 1] = senhaAtual;
            
            if (!Procedure("verificarSenha", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (!dados.HasRows)
            {
                Desconectar();
                return false; 
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true; 
        }

        #endregion

        #region Próximo código ocorrência
        public bool proxCodigoOcorrencia()
        {
            MySqlDataReader dados = null;

            if (!Procedure("proxCodigoOcorrencia", false, null, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    codigoOcrrencia = dados[0].ToString();
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
            }

            return true;
        }
        #endregion

        #region Gerar ocorrência
        public bool gerarOcorrencia(string cdOcorrencia, string dsOcorrencia, string emailUsuario, string codigoServico, string cdTipoOcorrencia)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[5, 2];
            valores[0, 0] = "vCodigo";
            valores[0, 1] = cdOcorrencia;
            valores[1, 0] = "vDsOcorrencia";
            valores[1, 1] = dsOcorrencia;
            valores[2, 0] = "vEmailUsuario";
            valores[2, 1] = emailUsuario;
            valores[3, 0] = "vCodigoServico";
            valores[3, 1] = codigoServico;
            valores[4, 0] = "vCodigoTipoOcorrencia";
            valores[4, 1] = cdTipoOcorrencia;

            if (!Procedure("gerarOcorrencia", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();


            return true; 
        }
        #endregion

        #region Criar Conta Cliente

        public bool cadastroCliente(string emailCliente, string nomeCliente, string telefoneCliente, string cpfCliente, string senhaCliente)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[5, 2];
            valores[0, 0] = "vEmailUsuario";
            valores[0, 1] = emailCliente;
            valores[1, 0] = "vNomeUsuario";
            valores[1, 1] = nomeCliente;
            valores[2, 0] = "vTelefoneUsuario";
            valores[2, 1] = telefoneCliente;
            valores[3, 0] = "vCpfUsuario";
            valores[3, 1] = cpfCliente;
            valores[4, 0] = "vSenhaUsuario";
            valores[4, 1] = senhaCliente;

            if (!Procedure("cadastroCliente", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            return true;

        }


        #endregion

        #region Criar Conta Cuidador

        public bool cadastroCuidador(string emailCuidador, string nomeCuidador, string telefoneCuidador, string cpfCuidador, string senhaCuidador, string imgCuidador, string cdGenero, string linkCurriculo, string descricaoCuidador, string valorHora, string descricaoEspecializacao)
        {
            valorHora = valorHora.Replace(",", ".");
            imgCuidador = imgCuidador.Replace("data:image/jpeg;base64,", "").Trim();

            MySqlDataReader dados = null;
            string[,] valores = new string[11, 2];
            valores[0, 0] = "vEmailUsuario";
            valores[0, 1] = emailCuidador;
            valores[1, 0] = "vNomeUsuario";
            valores[1, 1] = nomeCuidador;
            valores[2, 0] = "vTelefoneUsuario";
            valores[2, 1] = telefoneCuidador;
            valores[3, 0] = "vCpfUsuario";
            valores[3, 1] = cpfCuidador;
            valores[4, 0] = "vSenhaUsuario";
            valores[4, 1] = senhaCuidador;
            valores[5, 0] = "vImgCuidador";
            valores[5, 1] = imgCuidador;
            valores[6, 0] = "vCdGenero";
            valores[6, 1] = cdGenero;
            valores[7, 0] = "vLinkCurriculo";
            valores[7, 1] = linkCurriculo;
            valores[8, 0] = "vDescricaoCuidador";
            valores[8, 1] = descricaoCuidador;
            valores[9, 0] = "vValorHora";
            valores[9, 1] = valorHora;
            valores[10, 0] = "vDescricaoEspecializacao";
            valores[10, 1] = descricaoEspecializacao;

            if (!Procedure("cadastroCuidador", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            return true;
        }


        #endregion 

        #region Cadastrar especilizações cuidador

        public bool cadastrarEspecializacoes(string cdEspecializacao, string emailCuidador)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[2, 2];
            valores[0, 0] = "vEspecializacao";
            valores[0, 1] = cdEspecializacao;
            valores[1, 0] = "vEmailCuidador";
            valores[1, 1] = emailCuidador;

            if (!Procedure("cadastrarEspecializacoes", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            return true;
        }

        #endregion

    }
}