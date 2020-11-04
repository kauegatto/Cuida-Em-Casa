using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.ServicoAgendado;

namespace prjCuidaEmCasa.lib
{
    public partial class libCancelarServicoAgendado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cdServico = Request["codigoServico"].ToString();

            clsServicoAgendado servico = new clsServicoAgendado();

            if (!servico.cancelarServicoAgendado(cdServico))
            {
                Response.Write("false");
                return;
            }

            Response.Write("true");
        }
    }
}