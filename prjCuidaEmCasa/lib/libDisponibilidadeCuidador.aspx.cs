using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libDisponibilidadeCuidador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["ativo"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["ativo"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            if (Request["emailCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["emailCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string ativo = Request["ativo"].ToString();
            string emailCuidador = Request["emailCuidador"].ToString();

            clsCuidador classeCuidador = new clsCuidador();

            if (ativo == "0")
            {
                //tornar disponivel

                if (!classeCuidador.tornarDisponivel(emailCuidador))
                {
                    Response.Write("erro");
                    return;
                }
            }
            else 
            {
                //tornar indisponivel

                if (!classeCuidador.tornarIndisponivel(emailCuidador))
                {
                    Response.Write("erro");
                    return;
                }
            }

        }
    }
}