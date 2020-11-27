using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libListarAdvertenciaCuidador : System.Web.UI.Page
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
                
            if (!(adm.listarAdvertenciaCuidador(emailCuidador)))
            {
                Response.Write("false");
                return;
            }

            string dadosAdvertencia = "";

            dadosAdvertencia += "<div class='areaCuidador' >";
            dadosAdvertencia += "<div class='areaImagemCuidador' style='background-image: url('img/imgCuidador1.jfif'); margin-top: 10px; margin-left: 16px;'></div>";
            dadosAdvertencia += "<div class='areaNomeCuidador'>";
            dadosAdvertencia += "<h3 class='nomeCuidador' style='width:400px' >" + adm.nomeCuidador[0] + "</h3>";				
            dadosAdvertencia += "</div>";
            dadosAdvertencia += "</div>";
            dadosAdvertencia += "<div class='tituloConteudo'><span>Advertências</span></div>";

            for (int i = 0; i < adm.dataAdvertencia.Count; i++)
            {
                dadosAdvertencia += "<div class='areaAdvertencia'>";
                dadosAdvertencia += "<h2 class='tipoDenuncia'>" + adm.tipoAdvertencia[i] + "</h2>";
                dadosAdvertencia += "<div class='areaInfoAdvertencia'>";
                dadosAdvertencia += "<span>Data de emissão:</span><span class='dataEmissaoAdvertencia'>" + adm.dataAdvertencia[i] + "</span>";
                dadosAdvertencia += "<br/>";
                dadosAdvertencia += "<span>Advertido por:</span><span class='adminAdvertencia'>" + adm.nomeAdm[i] + "</span>";
                dadosAdvertencia += "<span class='emailAdminAdvertencia'>" + adm.emailAdm[i] + "</span>";
                dadosAdvertencia += "<br/>";
                dadosAdvertencia += "<span>Descrição:</span><span class='descricaoDenuncia'>" + adm.dsAdvertencia[i] + "</span>";
                dadosAdvertencia += "</div>";
                dadosAdvertencia += "</div>";
            }

            dadosAdvertencia += "</div>";

            Response.Write(adm.base64String[0] + " |@ " + dadosAdvertencia);
        }
    }
}