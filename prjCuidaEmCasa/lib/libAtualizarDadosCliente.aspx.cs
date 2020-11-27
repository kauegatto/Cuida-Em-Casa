using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libAtualizarDadosCliente : System.Web.UI.Page
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

            if (Request["nomeCliente"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["nomeCliente"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string nomeCliente = Request["nomeCliente"].ToString();

            if (Request["telefoneCliente"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["telefoneCliente"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string telefoneCliente = Request["telefoneCliente"].ToString();


            if (Request["cpfCliente"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["cpfCliente"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string cpfCliente = Request["cpfCLiente"].ToString();

            clsUsuario classeCliente = new clsUsuario();


            if (!classeCliente.atualizarDadosCliente(emailCliente, nomeCliente, cpfCliente, telefoneCliente))
            {
                Response.Write("erro");
                return;
            }

        }
    }
}