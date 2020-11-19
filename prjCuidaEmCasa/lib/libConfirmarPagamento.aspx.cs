using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjCuidaEmCasa.lib
{
    public partial class libConfirmarPagamento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region verificacao
            string cdServico; 
            if (Request["cdServico"] == null)
            {
                Response.Write("erro");
                return;
            }
            else{
                cdServico = Request["cdServico"];
            }
            #endregion

            classes.Agendamento.clsServico clsServico = new classes.Agendamento.clsServico();

            if (clsServico.confirmarPagamento(cdServico))
            {
                Response.Write("true");
            }
            else {
                Response.Write("false");
            }
        }
       
    }
}