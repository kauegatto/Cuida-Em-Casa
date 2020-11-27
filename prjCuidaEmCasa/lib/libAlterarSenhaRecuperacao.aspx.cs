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

            clsUsuario classeUsuario = new clsUsuario();

            if (!classeUsuario.alterarSenha(senhaUsuario, emailUsuario))
            {
                Response.Write("erro");
                return;
            }


        }
    }
}