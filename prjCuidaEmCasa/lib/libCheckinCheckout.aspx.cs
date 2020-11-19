using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libCheckinCheckout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
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

            if (Request["cdServico"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["cdServico"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }
            #endregion

            string ativo = Request["ativo"].ToString();
            string cdServico = Request["cdServico"].ToString();

            clsServico servico = new clsServico();

            if (ativo == "0")
            {
                //checkin

                if (!(servico.checkin(cdServico)))
                {
                    Response.Write("erro");
                    return;
                }
            }
            else 
            {
                //checkout

                if (!servico.checkout(cdServico))
                {
                    Response.Write("erro");
                    return;
                }
            }
        }
    }
}