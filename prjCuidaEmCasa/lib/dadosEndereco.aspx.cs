using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class dadosEndereco : System.Web.UI.Page
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

            string codigoPacienteSelecionada = Request["cdPaciente"].ToString();

            clsPaciente paciente = new clsPaciente();

            if (!paciente.confirmarEndereco(codigoPacienteSelecionada))
            {
                Response.Write("erro");
                return;
            }

            //Response.Write(paciente.nm_rua + ", " + paciente.nm_num + " " + paciente.nm_complemento + ", " + paciente.nm_cidade[0] + ", " + paciente.nm_estado[0]);
            Response.Write(paciente.nm_num + "/" + paciente.nm_rua + "/" + paciente.nm_complemento + "/" + paciente.nm_cidade[0] + "/" + paciente.nm_estado[0] + "/" + paciente.nm_bairro + "/" + paciente.cep + "/" + "Brazil");
        
        }
    }
}