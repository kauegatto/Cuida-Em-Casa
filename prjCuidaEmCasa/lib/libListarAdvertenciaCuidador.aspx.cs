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
            string imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
            string tinhaImg = "";

            dadosAdvertencia += "<div class='areaCuidador' >";
            dadosAdvertencia += "<div class='areaImagemCuidador' style='margin-top: 10px; margin-left: 16px;'></div>";
            if (adm.base64String[0] == imgPadrao) { tinhaImg = "false"; } else { tinhaImg = "true"; }
            dadosAdvertencia += "<div class='invi' style='display: none'>" + adm.base64String[0] + "#" + tinhaImg +"</div>";
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
                dadosAdvertencia += "<br/>";
                dadosAdvertencia += "<span>Email adm:</span><span class='emailAdminAdvertencia'>" + adm.emailAdm[i] + "</span>";
                dadosAdvertencia += "<br/>";
                dadosAdvertencia += "<span>Descrição:</span><span class='descricaoDenuncia'>" + adm.dsAdvertencia[i] + "</span>";
                dadosAdvertencia += "</div>";
                dadosAdvertencia += "</div>";
            }

            dadosAdvertencia += "</div>";

            Response.Write(dadosAdvertencia);
        }
    }
}