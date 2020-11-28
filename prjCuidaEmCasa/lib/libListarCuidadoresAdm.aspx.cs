using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libListarCuidadoresAdm : System.Web.UI.Page
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
            #endregion

            string control = Request["control"].ToString();

            clsAdministrador adm = new clsAdministrador();

            if (control == "0")
            {
                if (!(adm.listarTodosCuidadores()))
                {
                    Response.Write("false");
                    return;
                }
            }
            else
            {
                #region Validação
                if (Request["vE"] == null)
                {
                    Response.Write("false");
                    return;
                }

                if (Request["vE"].ToString() == "")
                {
                    Response.Write("false");
                    return;
                }

                if (Request["vS"] == null)
                {
                    Response.Write("false");
                    return;
                }

                if (Request["vS"].ToString() == "")
                {
                    Response.Write("false");
                    return;
                }

                if (Request["vP"] == null)
                {
                    Response.Write("false");
                    return;
                }

                if (Request["vP"].ToString() == "")
                {
                    Response.Write("false");
                    return;
                }

                if (Request["vA"] == null)
                {
                    Response.Write("false");
                    return;
                }

                if (Request["vA"].ToString() == "")
                {
                    Response.Write("false");
                    return;
                }

                if (Request["vEm"] == null)
                {
                    Response.Write("false");
                    return;
                }

                if (Request["vEm"].ToString() == "")
                {
                    Response.Write("false");
                    return;
                }

                if (Request["vG"] == null)
                {
                    Response.Write("false");
                    return;
                }

                if (Request["vG"].ToString() == "")
                {
                    Response.Write("false");
                    return;
                }

                if (Request["especializacao"] == null)
                {
                    Response.Write("false");
                    return;
                }

                if (Request["especializacao"].ToString() == "")
                {
                    Response.Write("false");
                    return;
                }

                if (Request["status"] == null)
                {
                    Response.Write("false");
                    return;
                }

                if (Request["status"].ToString() == "")
                {
                    Response.Write("false");
                    return;
                }

                if (Request["preco"] == null)
                {
                    Response.Write("false");
                    return;
                }

                if (Request["preco"].ToString() == "")
                {
                    Response.Write("false");
                    return;
                }

                if (Request["avaliacao"] == null)
                {
                    Response.Write("false");
                    return;
                }

                if (Request["avaliacao"].ToString() == "")
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

                if (Request["genero"] == null)
                {
                    Response.Write("false");
                    return;
                }

                if (Request["genero"].ToString() == "")
                {
                    Response.Write("false");
                    return;
                }
                #endregion

                string vE = Request["vE"].ToString();
                string vS = Request["vS"].ToString();
                string vP = Request["vP"].ToString();
                string vA = Request["vA"].ToString();
                string vEm = Request["vEm"].ToString();
                string vG = Request["vG"].ToString();
                string especializacao = Request["especializacao"].ToString();
                string status = Request["status"].ToString();
                string preco = Request["preco"].ToString();
                string avaliacao = Request["avaliacao"].ToString();
                string emailCuidador = Request["emailCuidador"].ToString();
                string genero = Request["genero"].ToString();

                if (!(adm.filtroTodosCuidadores(vE, vS, vP, vA, vEm, vG, especializacao, status, preco, avaliacao, emailCuidador, genero)))
                {
                    Response.Write("false");
                    return;
                }
            }

            string listaCuidadores = "";
            string imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
            string tinhaImg = "";

            for (int i = 0; i < adm.nmEmailCuidador.Count; i++)
            {
                listaCuidadores += "<div class='areaCuidador'>";
                listaCuidadores += "<div class='areaImagemCuidador' style='margin-top: 10px; margin-left: 16px;'></div>";
                if (adm.base64String[i] == imgPadrao) { tinhaImg = "false"; } else { tinhaImg = "true"; }
                listaCuidadores += "<div class='invi' style='display: none'>" + adm.base64String[i] + "#" + tinhaImg + "</div>";
                listaCuidadores += "<a href='infoCuidadores.html'>";
                listaCuidadores += "<img src='../../img/icones/cuidador/iconeInformacao.png' class='iconeInformacao " + adm.nmEmailCuidador[i] + "'>";
                listaCuidadores += "<div class='areaInfoCuidador'>";
                listaCuidadores += "</a>";
                listaCuidadores += "<div class='areaNomeCuidador' style='width: 375px;'>";
                listaCuidadores += "<h3 class='nomeCuidador'>" + adm.nomeCuidador[i] + "</h3>";
                listaCuidadores += "</div>";
                listaCuidadores += "<div class='hora' style='width: 375px;'>";
                listaCuidadores += "<img src='../../img/icones/cuidador/iconeCifrao.png' class='iconeCifrao'>";
                listaCuidadores += "<span style='margin-left: 9px;'>" + adm.vlHora[i] + " / Hora</span>";
                listaCuidadores += "</div>";
                listaCuidadores += "<div class='areaEspecializacao' style='width: 375px;'>";
                listaCuidadores += "<img src='../../img/icones/agenda/iconeMaleta.png'>";
                listaCuidadores += "<span class='especializacao'>" + adm.especiazalicaoCuidador[i] + "</span>";
                listaCuidadores += "</div>";
                listaCuidadores += "<div class='areaSituacao' style='width: 375px;'>";
                if (adm.situacaoUsuario[i] == "Contratado")
                {
                    listaCuidadores += "<span style='margin-left: 2px'  class='status'> Status: </span><span class='statusAtivo'>" + adm.situacaoUsuario[i] + "</span>";
                }
                if (adm.situacaoUsuario[i] == "Em análise")
                {
                    listaCuidadores += "<span style='margin-left: 2px'  class='status'> Status: </span><span class='statusSuspenso'>" + adm.situacaoUsuario[i] + "</span>";
                }
                if (adm.situacaoUsuario[i] == "Suspenso")
                {
                    listaCuidadores += "<span style='margin-left: 2px'  class='status'> Status: </span><span class='statusSuspenso'>" + adm.situacaoUsuario[i] + "</span>";
                }
                if (adm.situacaoUsuario[i] == "Demitido")
                {
                    listaCuidadores += "<span style='margin-left: 2px'  class='status'> Status: </span><span class='statusBanido'>" + adm.situacaoUsuario[i] + "</span>";
                }
                listaCuidadores += "</div>";
                listaCuidadores += "</div>";
                listaCuidadores += "</div>";
            }

            Response.Write(listaCuidadores);
        }
    }
}