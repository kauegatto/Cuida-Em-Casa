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
            string cdNecessidade = "", email_logado = "",ds_paciente="", cep_paciente="", nm_paciente="", cidade_paciente="", bairro_paciente="", rua_paciente="", num_paciente="", complemento_paciente="", uf_paciente = "", imgPaciente = "";
            try
            {
                email_logado = Request["usuarioLogado"].ToString();
                ds_paciente = Request["descricao"].ToString();
                cep_paciente = Request["CEP"].ToString();
                nm_paciente = Request["nome"].ToString();
                cidade_paciente = Request["cidade"].ToString();
                bairro_paciente = Request["bairro"].ToString();
                rua_paciente = Request["rua"].ToString();
                num_paciente = Request["numero"].ToString();    
                uf_paciente = Request["uf"].ToString();
                cdNecessidade = Request["cdNecessidade"].ToString();
                complemento_paciente = Request["complemento"].ToString();
                imgPaciente = Request["imagemPaciente"].ToString();
            }
            catch {
                Response.Write("false");
                return;
            }



            //try
            //{
            //    complemento_paciente = Request["complemento"].ToString();
            //}
            //catch { complemento_paciente = ""; }


            if (!clsPaciente.adicionarPaciente( email_logado,nm_paciente, ds_paciente, cep_paciente, cidade_paciente, bairro_paciente, rua_paciente, num_paciente, uf_paciente, complemento_paciente, imgPaciente))
            {
                Response.Write("false");
            }

            if (!clsPaciente.listarCodigoPaciente())
	        {
		        Response.Write("false");
	        }


            string[] necessidades = cdNecessidade.Split(';');


            for (int i = 0; i < necessidades.Length; i++)
            {
                if (!clsPaciente.editarNecessidadesPaciente(necessidades[i], clsPaciente.ultimoCodigoPaciente))
                {
                    Response.Write("false");
                }
            }

            Response.Write("true");

        }
    }
}