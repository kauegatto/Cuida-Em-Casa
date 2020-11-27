using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libInfoCuidadoresAdm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["emailCuidador"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["emailCuidador"].ToString() == "")
            {
                Response.Write("false");
                return;
            }
            #endregion

            string emailCuidador = Request["emailCuidador"].ToString();

            clsAdministrador adm = new clsAdministrador();

            if (!(adm.infoCuidadorContrato(emailCuidador)))
            {
                Response.Write("false");
                return;
            }

            if (!(adm.listarQuantidadeAdvertencias(emailCuidador)))
            {
                Response.Write("false");
                return;
            }

            if (!(adm.listarQuantidadeOcorrencias(emailCuidador)))
            {
                Response.Write("false");
                return;
            }

            string dadosCuidador = "";

            dadosCuidador += adm.base64String[0] + "|";
            dadosCuidador += adm.nomeCuidador[0] + "|";
            dadosCuidador += adm.generoCuidador[0] + "|";
            dadosCuidador += adm.telCuidador[0] + "|";
            dadosCuidador += adm.cpfCuidador[0] + "|";
            dadosCuidador += adm.nmEmailCuidador[0] + "|";
            dadosCuidador += adm.dsUsuario[0] + "|";
            dadosCuidador += adm.especiazalicaoCuidador[0] + "|";
            dadosCuidador += adm.vlHora[0] + "|";
            dadosCuidador += adm.linkCurriculo[0] + "|";
            dadosCuidador += adm.qtdOcorrencias[0] + "|";
            dadosCuidador += adm.qtdAdvertencias[0] + "|";
            dadosCuidador += adm.situacaoUsuario[0] + "|";
            dadosCuidador = dadosCuidador.Substring(0, dadosCuidador.Length - 1);

            Response.Write(dadosCuidador);
        }
    }
}