using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libCriarContaCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

            string cpfCliente = Request["cpfCliente"].ToString();


            if (Request["senhaCliente"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["senhaCliente"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string senhaCliente = Request["senhaCliente"].ToString();

            Random r = new Random();
            int randNum = r.Next(1000000);
            string sixDigitNumber = randNum.ToString("D6");

            clsUsuario classeUsuario = new clsUsuario();

            if (!classeUsuario.cadastroCliente(emailCliente,nomeCliente,telefoneCliente,cpfCliente,senhaCliente))
            {
                Response.Write("erro");
                return;
            }

            if (!classeUsuario.inserirAuthRecover(emailCliente, sixDigitNumber))
            {
                Response.Write("erro");
                return;
            }

        }
    }
}