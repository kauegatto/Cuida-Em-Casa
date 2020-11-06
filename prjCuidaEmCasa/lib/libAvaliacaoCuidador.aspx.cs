using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libAvalicaoCuidador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["na"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["na"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string notaAvaliacao = Request["na"].ToString();

            if (Request["ec"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["ec"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string emailCuidador = Request["ec"].ToString();

            clsServico classeAvaliacao = new clsServico();

            if (!classeAvaliacao.avaliarServico(emailCuidador, notaAvaliacao))
            {
                Response.Write("erro");
                return;
            }
        }
    }
}