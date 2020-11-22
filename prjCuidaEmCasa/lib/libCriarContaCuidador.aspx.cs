using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libCriarContaCuidador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["nomeCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["nomeCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string nomeCuidador = Request["nomeCuidador"].ToString();

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

            if (Request["telefoneCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["telefoneCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string telefoneCuidador = Request["telefoneCuidador"].ToString();

            if (Request["cpfCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["cpfCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string cpfCuidador = Request["cpfCuidador"].ToString();

            if (Request["imgCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["imgCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string imgCuidador = Request["imgCuidador"].ToString();


            if (Request["generoCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["generoCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string generoCuidador = Request["generoCuidador"].ToString();

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

            if (Request["descricaoCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["descricaoCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string descricaoCuidador = Request["descricaoCuidador"].ToString();

            if (Request["especializacaoCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["especializacaoCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string especializacaoCuidador = Request["especializacaoCuidador"].ToString();


            if (Request["valorHora"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["valorHora"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string valorHora = Request["valorHora"].ToString();


            if (Request["descricaoEspecializacao"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["descricaoEspecializacao"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string descricaoEspecializacao = Request["descricaoEspecializacao"].ToString();


            if (Request["senhaCuidador"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["senhaCuidador"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string senhaCuidador = Request["senhaCuidador"].ToString();
            #endregion

            clsUsuario usuario = new clsUsuario();

            if (!(usuario.cadastroCuidador(emailCuidador, nomeCuidador, telefoneCuidador, cpfCuidador, senhaCuidador, imgCuidador, generoCuidador, link, descricaoCuidador, valorHora, descricaoEspecializacao)))
            {
                Response.Write("erro");
                return;
            }


            string[] especializacoes = especializacaoCuidador.Split(';');

            for (int i = 0; i < especializacoes.Length; i++)
            {
                
                if (!(usuario.cadastrarEspecializacoes(especializacoes[i], emailCuidador)))
	            {
                    Response.Write("erro");
                    return;
	            }

            }


        }
    }
}