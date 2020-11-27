using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libAlterarSenhaRecuperacao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["emailUsuario"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["emailUsuario"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string emailUsuario = Request["emailUsuario"].ToString();

            if (Request["senha"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["senha"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string senhaUsuario = Request["senha"].ToString();

            if (Request["cdRecuperacao"] == null)
	        {
                Response.Write("erro");
                return;
	        }

            if (Request["cdRecuperacao"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string cdRecuperacao = Request["cdRecuperacao"].ToString();

            clsUsuario classeUsuario = new clsUsuario();

            if (!classeUsuario.alterarSenha(senhaUsuario, emailUsuario))
            {
                Response.Write("erro");
                return;
            }

            if (!classeUsuario.deletarAuthRecover(cdRecuperacao, emailUsuario))
            {
                Response.Write("erro");
                return;
            }

            Random r = new Random();
            int randNum = r.Next(1000000);
            string sixDigitNumber = randNum.ToString("D6");

            if (!classeUsuario.inserirAuthRecover(emailUsuario, sixDigitNumber))
	        {
		        Response.Write("erro");
                return;
	        }


        }
    }
}