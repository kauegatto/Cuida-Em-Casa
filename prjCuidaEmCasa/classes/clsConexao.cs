using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace prjCuidaEmCasa.classes
{
    static class clsConexao
    {
        private static string linhaConexao = "conexao banco :)";

        public static string getConexao()
        {
            return linhaConexao;
        }
    }
}