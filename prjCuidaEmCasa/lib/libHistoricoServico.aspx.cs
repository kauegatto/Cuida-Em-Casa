using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libHistoricoServico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string emailCuidador = Request["email"];
            string filtro = Request["filtro"];
            string listaServicos = "";
            string tinhaImg; 
            string imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            clsCuidador cuidador = new clsCuidador();

            if (filtro == "true")
            {
                if (!(cuidador.historicoRecente(emailCuidador)))
                {
                    Response.Write("false");
                    return;
                }
                
            }
            else
            {
                if (!(cuidador.historicoAntigo(emailCuidador)))
                {
                    Response.Write("false");
                    return;
                }
               
            }
            for (int i = 0; i < cuidador.nm_paciente.Count; i++)
            {
                listaServicos += "<div class='areaHistorico "+ cuidador.cd_servico[0]+ "'>";
                listaServicos += "<span class='dataHistorico'>" + cuidador.dt_inicio_servico[i] + " - " + cuidador.hr_inicio_servico[i] + " às " + cuidador.hr_fim_servico[i] + "</span>";
                listaServicos += "<div class='dadosHistorico'>";
                if (cuidador.base64String[i] == imgPadrao) { tinhaImg = "false"; } else { tinhaImg = "true"; }
                listaServicos += "<div class='areaImagemPaciente'></div>";
                listaServicos += "<div class='invi' style='display: none'>" + cuidador.base64String[i]+ "</div>";
                listaServicos += "<div class='areaDadosHistorico'>";
                listaServicos += "<h3 class='nomePacienteHistorico'>" + cuidador.nm_paciente[i] + "</h3>";
                string duracao = cuidador.duracaoServico[i];
                string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
                string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
                double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
                double valorTotal = horaFinal * double.Parse(cuidador.vl_cuidador[i]);
                listaServicos += "<h3 class='detalheHistorico'>Serviço realizado no dia " + cuidador.dt_inicio_servico[i] + ", duração de " + cuidador.duracaoServico[i] + " horas.</h3>";
                listaServicos += "<span class='valorRecebido'>Valor Recebido: </span><span class='valor'>" + valorTotal.ToString("C") + "</span>";
                listaServicos += "</div>";
                listaServicos += "</div>";
                listaServicos += "</div>";
            }
            Response.Write(listaServicos);
        }
    }
}