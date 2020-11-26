using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libBuscarDadosCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["emailCliente"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["emailCliente"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string emailCliente = Request["emailCliente"].ToString();

            clsUsuario classeUsuario = new clsUsuario();

            if (!classeUsuario.buscarDadosCliente(emailCliente))
            {
                Response.Write("erro");
                return;
            }

            Response.Write
            (
                classeUsuario.nomeCliente[0] + "|" +
                classeUsuario.cpfCliente[0] + "|" +
                classeUsuario.telefoneCliente[0]
            );

        }
    }
}