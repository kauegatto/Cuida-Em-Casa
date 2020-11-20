using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libAceitarServicoAgora : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["cdServico"] == null)
            {
                Response.Write("erro");
            }

            if (Request["cdServico"].ToString() == "")
            {
                Response.Write("erro");
            }

            if (Request["emailCuidador"] == null)
            {
                Response.Write("erro");
            }

            if (Request["emailCuidador"].ToString() == "")
            {
                Response.Write("erro");
            }
            #endregion

            string cdServico = Request["cdServico"].ToString();
            string emailCuidador = Request["emailCuidador"].ToString();

            clsServico servico = new clsServico();
            clsCuidador cuidador = new clsCuidador();

            if (!(servico.aceitarServico(cdServico, emailCuidador)))
            {
                Response.Write("false");
                return;
            }
            else
            {
                if (!(cuidador.tornarIndisponivel(emailCuidador)))
                {
                    Response.Write("false");
                }

                Response.Write("true");
            }
        }
    }
}