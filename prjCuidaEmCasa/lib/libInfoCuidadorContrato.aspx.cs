using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libInfoCuidadorContrato : System.Web.UI.Page
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

            string dadosCuidador = "";

            string imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
            string tinhaImg = "";

            dadosCuidador += "<div class='areaImagemCuidador'></div>";
            if (adm.base64String[0] == imgPadrao) { tinhaImg = "false"; } else { tinhaImg = "true"; }
            dadosCuidador += "<div class='invi' style='display: none'>" +  adm.base64String[0] + "#" + tinhaImg + "</div>";
			dadosCuidador += "<div class='areaNomeCuidador'>";
			dadosCuidador += "<h3 class='nomeCuidador'>" + adm.nmEmailCuidador[0] + "</h3>";			
	 		dadosCuidador += "</div>";	
			dadosCuidador += "</div>";
			dadosCuidador += "<div class='tituloConteudo'><span>Informações Básicas</span></div>";
			dadosCuidador += "<div class='areaInfoCuidador'>";
			dadosCuidador += "<div class='areaInfoBasicas'>";
			dadosCuidador += "<span>Gênero:</span>";
		    dadosCuidador += "<span class='generoCuidador' style='color: gray'>" + adm.generoCuidador[0] + "</span>";
		    dadosCuidador += "<span style='margin-left: 20px'>Telefone:</span>";
		    dadosCuidador += "<span class='telefoneCuidador' style='color: gray'>" + adm.telCuidador[0] + "</span>";
		    dadosCuidador += "<span style='margin-left: 20px'>CPF:</span>";
		    dadosCuidador += "<span class='cpfCuidador' style='color: gray'>" + adm.cpfCuidador[0] + "</span>";
		    dadosCuidador += "<span>Email:</span><span class='emailCuidador' style='color: gray'>" + adm.nmEmailCuidador[0] + "</span>"; 
		    dadosCuidador += "<br/>";
		    dadosCuidador += "<span>Descrição:</span>";
		    dadosCuidador += "<span class='descricaoCuidador' style='color: gray'>" + adm.dsUsuario[0] + "</span>";
	        dadosCuidador += "</div>";
			dadosCuidador += "</div>";	
			dadosCuidador += "<div class='tituloConteudo'><span>Informações de Trabalho</span></div>";
			dadosCuidador += "<div class='areaInfoCuidador'>";
			dadosCuidador += "<div class='areaInfoTrabalho'>";
			dadosCuidador += "<span>Especialização:</span>";
    		dadosCuidador += "<span class='especializacaoCuidador' style='color: gray'>" + adm.especiazalicaoCuidador[0] + "</span>";
			dadosCuidador += "<br/>";
			dadosCuidador += "<span>Valor Hora:</span>";
    		dadosCuidador += "<span class='valorHoraCuidador' style='color: gray'>R$ " + adm.vlHora[0] + "</span>";
			dadosCuidador += "<br/>";
			dadosCuidador += "<span>Link Currículo:</span>";
			dadosCuidador += "<span class='curriculoCuidador' style='color: gray'>" + adm.linkCurriculo[0] + "</span>";
			dadosCuidador += "</div>";
			dadosCuidador += "</div>";
            dadosCuidador += "</div>";
            dadosCuidador += "</div>";

            Response.Write(dadosCuidador);
        }
    }
}