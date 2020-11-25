using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libExcluirPaciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["cdPaciente"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["cdPaciente"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string codigoPaciente = Request["cdPaciente"].ToString();


            clsPaciente classePaciente = new clsPaciente();

            if (!classePaciente.excluirPaciente(codigoPaciente))
            {
                Response.Write("erro");
                return;
            }



        }
    }
}