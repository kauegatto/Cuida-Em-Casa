using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libContratarCuidador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["control"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["control"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

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

            string control = Request["control"].ToString();
            string emailCuidador = Request["emailCuidador"];

            clsAdministrador adm = new clsAdministrador();

            if (control == "0")
            {
                if (!(adm.contratarCuidador(emailCuidador)))
                {
                    Response.Write("false");
                    return;
                }

                Response.Write("true");
            }
            else
            {
                if (control == "1")
                {
                    if (!(adm.recusarCuidador(emailCuidador)))
                    {
                        Response.Write("false");
                        return;
                    }

                    Response.Write("true");
                }
                else
                {
                    if (!(adm.listarCuidadoresContrato()))
                    {
                        Response.Write("false");
                        return;
                    }

                    string listaCuidadoresContrato = "";
                    string imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
           
                    for (int i = 0; i < adm.nomeCuidador.Count; i++)
                    {
                        string tinhaImg = "";
                        listaCuidadoresContrato += "<div class='areaCuidador' >";
                        listaCuidadoresContrato += "<div class='areaImagemCuidador' style='margin-top: 10px; margin-left: 16px;'></div>";
                        if (adm.base64String[i] == imgPadrao) { tinhaImg = "false"; } else { tinhaImg = "true"; }
                        listaCuidadoresContrato += "<div class='invi' style='display: none'>" + adm.base64String[i] + "#" + tinhaImg +"</div>";
                        listaCuidadoresContrato += "<a href='infoCuidadorContrato.html'>";
                        listaCuidadoresContrato += "<img src='../../img/icones/cuidador/iconeInformacao.png' class='iconeInformacao " + adm.nmEmailCuidador[i] + "'>";
                        listaCuidadoresContrato += "<div class='areaInfoCuidador'>";
                        listaCuidadoresContrato += "</a>";
                        listaCuidadoresContrato += "<div class='areaNomeCuidador' style='width: 375px;'>";
                        listaCuidadoresContrato += "<h3 class='nomeCuidador'>" + adm.nomeCuidador[i] + "</h3>";
                        listaCuidadoresContrato += "</div>";
                        listaCuidadoresContrato += "<div class='hora' style='width: 375px;'>";
                        listaCuidadoresContrato += "<img src='../../img/icones/cuidador/iconeCifrao.png' class='iconeCifrao'>";
                        listaCuidadoresContrato += "<span style='margin-left: 9px;'>" + adm.vlHora[i] + " / Hora</span>";
                        listaCuidadoresContrato += "</div>";
                        listaCuidadoresContrato += "<div class='valorHora' style='width: 375px;'>";
                        listaCuidadoresContrato += "<img src='../../img/icones/agenda/iconeMaleta.png'>";
                        listaCuidadoresContrato += "<span class='especializacao'>" + adm.especiazalicaoCuidador[i] + "</span>";
                        listaCuidadoresContrato += "</div>";
                        listaCuidadoresContrato += "</div>";
                        listaCuidadoresContrato += "<div class='areaBotao'>";
                        listaCuidadoresContrato += "<button class='btnAceitar " + adm.nmEmailCuidador[i] + "' type='submit'>Contratar</button>";
                        listaCuidadoresContrato += "<button class='btnRejeitar " + adm.nmEmailCuidador[i] + "' type='submit'>Rejeitar</button>";
                        listaCuidadoresContrato += "</div>";
                        listaCuidadoresContrato += "</div>";
                    }

                    Response.Write(listaCuidadoresContrato);
                }
            }
        }
    }
}