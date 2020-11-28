using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libDadosLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string email = Request["email"].ToString();
            string senha = Request["senha"].ToString();
            
            if (email == "" || email == null) { Response.Write("false"); }
            if (senha == "" || senha == null) { Response.Write("false"); }


            clsUsuario usuario = new clsUsuario();

            if (!usuario.verificarLogin(email, senha))
            {
                Response.Write("false");
            }
            else {
                if (usuario.emailUsuarioBusca == email)
                {
                    Response.Write("true" + "|" + usuario.tipoUsuario + "|" + usuario.cdSituacaoUsuario);
                }
                else {
                    Response.Write("false");
                }
            }
        }
    }
}