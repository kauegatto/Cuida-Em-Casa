using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjCuidaEmCasa.lib
{
    public partial class dadosAgendamento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["d"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["d"] == "")
            {
                Response.Write("erro");
                return;
            }

            if (Request["hi"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["hi"] == "")
            {
                Response.Write("erro");
                return;
            }

            if (Request["hf"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["hf"] == "")
            {
                Response.Write("erro");
                return;
            }

            
        }
    }
}