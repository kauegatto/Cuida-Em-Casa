using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace prjCuidaEmCasa.classes
{
    static class clsConexao
    {
        private static string linhaConexao = "SERVER=localhost;UID=root;PASSWORD=root;DATABASE=prjcuidaemcasa";

        public static string getConexao()
        {
            return linhaConexao;
        }
    }
}