using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libFinalizarServico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsServico servico = new clsServico();

            string proxCodigo = servico.proxCodigo().ToString();

            
        }
    }
}