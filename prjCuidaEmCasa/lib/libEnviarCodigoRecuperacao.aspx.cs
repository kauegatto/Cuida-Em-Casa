using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libEnviarCodigoRecuperacao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação dados do post

            if (Request["codigoRecuperacao"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["codigoRecuperacao"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string codigoRecuperacao = Request["codigoRecuperacao"].ToString();

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

            string emailDestinatario = Request["emailUsuario"].ToString();

            #endregion

            #region classeUsuario

            clsUsuario classeUsuario = new clsUsuario();

            if (!classeUsuario.verificarCodigoRecuperacao(emailDestinatario, codigoRecuperacao))
            {
                Response.Write("erro");
                return;
            }

            if (classeUsuario.cdRecuperarSenha[0] != codigoRecuperacao)
            {
                Response.Write("erro");
                return;
            }

            #endregion

        
        }
    }
}