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

        public clsUsuario(): base()
        {
            emailUsuarioBusca = "";
            tipoUsuario = "";
        }

        #region Verificar Login Usuario
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
    }
}