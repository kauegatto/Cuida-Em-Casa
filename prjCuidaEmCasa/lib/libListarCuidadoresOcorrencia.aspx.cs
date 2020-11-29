using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libListarCuidadoresOcorrencia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsAdministrador adm = new clsAdministrador();

            if (!(adm.listarCuidadoresOcorrencia()))
	        {
		        Response.Write("false");
                return;
	        }

            string cuidadoresOcorrencia = "";
            string imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
           
            for (int i = 0; i < adm.nomeCuidador.Count; i++)
			{
                string tinhaImg = "";
			    cuidadoresOcorrencia += "<div class='areaCuidador'>";
                cuidadoresOcorrencia += "<div class='areaImagemCuidador' style='margin-top: 10px; margin-left: 16px;'></div>";
                if (adm.base64String[i] == imgPadrao) { tinhaImg = "false"; } else { tinhaImg = "true"; }
                cuidadoresOcorrencia += "<div class='invi' style='display: none'>" + adm.base64String[i] + "#" + tinhaImg +"</div>";
                cuidadoresOcorrencia += "<a href='ocorrenciaCuidador.html'>";
                cuidadoresOcorrencia += "<img src='../../img/icones/cuidador/iconeInformacao.png' class='iconeInformacao " + adm.nmEmailCuidador[i] + "'>";
                cuidadoresOcorrencia += "<div class='areaInfoCuidador'>";
                cuidadoresOcorrencia += "</a>";
                cuidadoresOcorrencia += "<h3 class='nomeCuidador' style='width:400px'>" + adm.nomeCuidador[i] + "</h3>";					
                cuidadoresOcorrencia += "<div class='hora'>";
                cuidadoresOcorrencia += "<img src='../../img/icones/cuidador/iconeCifrao.png' class='iconeCifrao'>";
                cuidadoresOcorrencia += "<span style='margin-left: 9px;'>" + adm.vlHora[i] + " / Hora</span>";
                cuidadoresOcorrencia += "</div>";
                cuidadoresOcorrencia += "<img src='../../img/icones/agenda/iconeMaleta.png'>";
                cuidadoresOcorrencia += "<span class='especializacao'>" + adm.especiazalicaoCuidador[i] + "</span>";	
                cuidadoresOcorrencia += "<div class='denuncia'>";
                cuidadoresOcorrencia += "<img src='../../img/icones/cuidador/iconeDenuncia.png'>";
                if (adm.qtdOcorrenciaCuidadores[i] == "1")
	            {
		            cuidadoresOcorrencia += "<span class='especializacao'>" + adm.qtdOcorrenciaCuidadores[i] + " denúncia</span>";	
	            }
                else
	            {
                    cuidadoresOcorrencia += "<span class='especializacao'>" + adm.qtdOcorrenciaCuidadores[i] + " denúncias</span>";	
	            }
                cuidadoresOcorrencia += "</div>";
                cuidadoresOcorrencia += "</div>";
                cuidadoresOcorrencia += "</div>";
                cuidadoresOcorrencia += "</div>";
			}

            if (adm.nomeCuidador.Count == 0)
            {
                Response.Write("");
                return;
            }

            Response.Write(cuidadoresOcorrencia);
        }
    }
}