using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;
namespace prjCuidaEmCasa.lib
{
    public partial class libAdicionarPaciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsPaciente clsPaciente = new clsPaciente();
            string cd_paciente = Request["cd"].ToString();
            string ds_paciente = Request["descricao"].ToString();
            string cep_paciente = Request["CEP"].ToString();
            string nm_paciente = Request["nome"].ToString();
            string cidade_paciente = Request["cidade"].ToString();
            string bairro_paciente = Request["bairro"].ToString();
            string rua_paciente = Request["rua"].ToString();
            string num_paciente = Request["numero"].ToString();
            string complemento_paciente = Request["complemento"].ToString();
            string uf_paciente = Request["uf"].ToString();
            if (clsPaciente.editarDadosPaciente(cd_paciente, nm_paciente, ds_paciente, cep_paciente, cidade_paciente, bairro_paciente, rua_paciente, num_paciente, uf_paciente, complemento_paciente))
            {
                Response.Write("true");
            }
            else
            {
                Response.Write("false");
            }
        }
    }
}