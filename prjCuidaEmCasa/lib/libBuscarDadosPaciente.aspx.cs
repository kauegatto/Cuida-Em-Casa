using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;
namespace prjCuidaEmCasa.lib
{
    public partial class libBuscarDadosPaciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsPaciente clsPaciente = new clsPaciente();
            string cd_paciente = Request["cd"].ToString();
            if (clsPaciente.buscarDadosPaciente(cd_paciente))
            {
                string resposta = clsPaciente.nm_paciente[0] + "|" + clsPaciente.nm_tipo_necessidade_paciente + "|" + clsPaciente.ds_paciente + "|";
                resposta += clsPaciente.cep + "|" + clsPaciente.nm_cidade[0] + "|" + clsPaciente.nm_bairro + "|" + clsPaciente.nm_rua + "|";
                resposta += clsPaciente.nm_num + "|" + clsPaciente.nm_estado[0] + "|" + clsPaciente.nm_complemento + "|" + clsPaciente.base64String[0] + "|" + clsPaciente.cdTipoNecessidade[0]; 
                Response.Write(resposta);
            }
            else 
            {
                Response.Write("false");
            }
        }
    }
}