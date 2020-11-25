using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libAtualizarDadosPaciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //fazer validacao 

            clsPaciente clsPaciente = new clsPaciente();

            if (Request["cd"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["cd"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            string cd_paciente = Request["cd"].ToString();

            if (Request["descricao"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["descricao"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            string ds_paciente = Request["descricao"].ToString();

            if (Request["CEP"].ToString() == "")
            {
                Response.Write("false"); 
                return;
            }

            if (Request["CEP"] == null)
            {
                Response.Write("false");
                return;
            }

            string cep_paciente = Request["CEP"].ToString();

            if (Request["nome"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["nome"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            string nm_paciente = Request["nome"].ToString();

            if (Request["cidade"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["cidade"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            string cidade_paciente = Request["cidade"].ToString();

            if (Request["bairro"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["bairro"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            string bairro_paciente = Request["bairro"].ToString();

            if (Request["rua"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["rua"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            string rua_paciente = Request["rua"].ToString();

            if (Request["numero"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["numero"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            string num_paciente = Request["numero"].ToString();

            if (Request["complemento"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["complemento"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            string complemento_paciente = Request["complemento"].ToString();

            if (Request["uf"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["uf"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

            string uf_paciente = Request["uf"].ToString();

            if (Request["imagem"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["imagem"].ToString() == "")
            {
                Response.Write("false");
                return;
            }


            string imgPaciente = Request["imagem"].ToString();


            if (Request["necessidadesPaciente"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["necessidadesPaciente"].ToString() == "")
            {
                Response.Write("false");
                return;
            }


            string necessidadesPaciente = Request["necessidadesPaciente"].ToString();

            if (!clsPaciente.editarDadosPaciente(cd_paciente, nm_paciente, ds_paciente, cep_paciente, cidade_paciente, bairro_paciente, rua_paciente, num_paciente, uf_paciente, complemento_paciente, imgPaciente))
            {
                Response.Write("false");
                return;
            }


            if (!clsPaciente.deletarNecessidadesPaciente(cd_paciente))
            {
                Response.Write("false");
                return;
            }

            string[] necessidades = necessidadesPaciente.Split(';');

            for (int i = 0; i < necessidades.Length; i++)
            {
                if (!clsPaciente.editarNecessidadesPaciente(necessidades[i], cd_paciente))
                {
                    Response.Write("false");
                    return;
                }
            }

            Response.Write("true");

        }
    }
}