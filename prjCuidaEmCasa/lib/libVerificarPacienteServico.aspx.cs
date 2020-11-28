using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libVerificarPacienteServico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["cdPaciente"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["cdPaciente"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            if (Request["data"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["data"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            if (Request["hi"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["hi"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            if (Request["hf"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["hf"].ToString() == "")
            {
                Response.Write("false");
                return;
            }
            #endregion

            clsPaciente paciente = new clsPaciente();

            string cdPaciente = Request["cdPaciente"].ToString();
            string data = Request["data"].ToString();
            string horaInicio = Request["hi"].ToString();
            string horaFim = Request["hf"].ToString();

            if (!(paciente.verificarPacienteServico(cdPaciente, data, horaInicio, horaFim)))
            {
                Response.Write("false");
                return;
            }

            if (paciente.cdServico.Count() == 0)
            {
                Response.Write("não tem");
            }
            else
            {
                Response.Write("tem");
            }
        }
    }
}