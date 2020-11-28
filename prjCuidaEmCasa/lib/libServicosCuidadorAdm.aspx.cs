using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libServicosCuidadorAdm : System.Web.UI.Page
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

            if (!(adm.listarServicosCuidador(emailCuidador)))
            {
                Response.Write("false");
                return;
            }

            string servicosCuidador = "";
            string imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
            string tinhaImg = "";

            servicosCuidador += "<div class='areaCuidador'>";
            servicosCuidador += "<div class='areaImagemCuidador' style='margin-top: 10px; margin-left: 16px;'></div>";
            if (adm.base64String[0] == imgPadrao) { tinhaImg = "false"; } else { tinhaImg = "true"; }
            servicosCuidador += "<div class='invi' style='display: none'>" + adm.base64String[0] + "#" + tinhaImg + "</div>";
            servicosCuidador += "<div class='areaNomeCuidador'>";
            servicosCuidador += "<h3 class='nomeCuidador' style='width: 400px'>" + adm.nomeCuidador[0] + "</h3>";					
            servicosCuidador += "</div>";
            servicosCuidador += "</div>";
            servicosCuidador += "<div class='tituloConteudo'><span>Serviços</span></div>";

            for (int i = 0; i < adm.dtFimServico.Count; i++)
            {
                servicosCuidador += "<div class='areaServico'>";
                servicosCuidador += "<div class='tituloServico'><span>Cliente:</span><span class='emailClienteServico'>" + adm.emailCliente[i] + "</span></div>";
                servicosCuidador += "<div class='areaInfoServico'>";
                servicosCuidador += "<span>Data de início:</span><span class='dataInicioServico'>" + adm.dtInicioServico[i] + "</span>";
                servicosCuidador += "<br/>";
                servicosCuidador += "<span>Data de fim:</span> <span class='dataFimServico'>" + adm.dtFimServico[i] + "</span>";
                servicosCuidador += "<br/>";
                servicosCuidador += "<span>Duração</span><span class='dataInicioServico'>" + adm.hrInicioServico[i] + " - </span><span class='dataFimServico'>" + adm.hrFimServico[i] + "</span>";
                servicosCuidador += "<br/>";
                string duracao = adm.duracaoServico[i];
                string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
                string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
                double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
                double valorTotal = horaFinal * double.Parse(adm.vlHora[0]);
                if (adm.statusServico[i] != "Cancelado")
                {
                    servicosCuidador += "<span>Valor Total:</span><span class='valorTotalServico'>" + valorTotal.ToString("C") + "</span>";
                    servicosCuidador += "<br/>";
                }
                if (adm.statusServico[i] == "Finalizado")
                {
                    servicosCuidador += "<span>Status:</span><span class='statusServico finalziado'>" + adm.statusServico[i] + "</span>";
                }
                if (adm.statusServico[i] == "Em Andamento" || adm.statusServico[i] == "Pendente")
                {
                    servicosCuidador += "<span>Status:</span><span class='statusServico pendente'>" + adm.statusServico[i] + "</span>";
                }
                if (adm.statusServico[i] == "Cancelado")
                {
                    servicosCuidador += "<span>Status:</span><span class='statusServico cancelado'>" + adm.statusServico[i] + "</span>";
                }
                servicosCuidador += "</div>";
                servicosCuidador += "</div>";
            }

            servicosCuidador += "</div>";
            servicosCuidador += "</div>";

            Response.Write(servicosCuidador);
        }
    }
}