using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libVerificarAceitouServicoAgora : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["codigoServico"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["codigoServico"].ToString() == "")
            {
                Response.Write("false");
                return;
            }
            #endregion

            string cdServico = Request["codigoServico"].ToString();

            clsServico servico = new clsServico();

            if (!(servico.verificarAceitouServicoAgora(cdServico)))
            {
                Response.Write("false");
                return;
            }

            string situacaoServico = servico.situacaoServico[0];

            Response.Write(situacaoServico);
        }
    }
}