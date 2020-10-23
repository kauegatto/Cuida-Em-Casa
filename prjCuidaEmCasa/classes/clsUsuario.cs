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

        public clsUsuario(): base()
        {
            emailUsuarioBusca = "";
            tipoUsuario = "";
            codigoOcrrencia = "";
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
    }
}