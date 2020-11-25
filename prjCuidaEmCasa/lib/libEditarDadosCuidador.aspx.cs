using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libEditarDadosCuidador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["emailCuidador"] == null)
	        {
		        Response.Write("erro");
                return;
	        }

            if (Request["emailCuidador"].ToString() == "")
	        {
		        Response.Write("erro");
                return;
	        }

            string emailCuidador = Request["emailCuidador"].ToString();

            if (Request["imagemCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["imagemCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string imgCuidador = Request["imagemCuidador"].ToString();

            if (Request["nmCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["nmCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string nomeCuidador = Request["nmCuidador"].ToString();

            if (Request["especializacoes"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["especializacoes"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string especializacoes = Request["especializacoes"].ToString();

            if (Request["genero"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["genero"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string generoCuidador = Request["genero"].ToString();


            if (Request["dsCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["dsCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string dsCuidador = Request["dsCuidador"].ToString();

            if (Request["dsEspecializacao"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["dsEspecializacao"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string dsEspecializacao = Request["dsEspecializacao"].ToString();


            if (Request["telCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["telCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string telCuidador = Request["telCuidador"].ToString();


            if (Request["cpf"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["cpf"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string cpf = Request["cpf"].ToString();


            if (Request["link"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["link"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string link = Request["link"].ToString();

            if (Request["vlHora"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["vlHora"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string vlHora = Request["vlHora"].ToString();

            clsCuidador classeCuidador = new clsCuidador();

            if (!classeCuidador.editarDadosCuidador(emailCuidador,nomeCuidador,cpf, telCuidador, imgCuidador, vlHora, link, dsEspecializacao, dsCuidador, generoCuidador))
            {
                Response.Write("erro");
                return;
            }


            if (!classeCuidador.deletarEspecializacoes(emailCuidador))
            {
                Response.Write("erro");
                return;
            }

            clsUsuario classeUsuario = new clsUsuario();

            string[] codigosEspecializacoes = especializacoes.Split(';');

            for (int i = 0; i < codigosEspecializacoes.Length; i++)
            {
                if (!classeUsuario.cadastrarEspecializacoes(codigosEspecializacoes[i], emailCuidador))
                {
                    Response.Write("erro");
                    return;
                }
            }

        }
    }
}