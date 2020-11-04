using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libDenunciarCuidador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação POST

            if (Request["e"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["e"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string emailCliente = Request["e"].ToString();

            if (Request["d"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["d"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string txtDenuncia = Request["d"].ToString();

            if (Request["c"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["c"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string cdServico = Request["c"].ToString();

            if (Request["cd"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["cd"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string cdTipoDenuncia = Request["cd"].ToString();

            #endregion

            clsServico classeDenunciarCuidador = new clsServico();

            if (!classeDenunciarCuidador.denunciarServico(emailCliente,txtDenuncia,cdServico,cdTipoDenuncia))
            {
                Response.Write("erro");
                return;
            }

        }
    }
}