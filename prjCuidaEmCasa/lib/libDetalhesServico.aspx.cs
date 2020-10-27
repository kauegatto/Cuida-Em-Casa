using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libDetalhesServico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cdServico = Request["cdServico"];
            string detalhesServico = "";
            string tinhaImg;
            string imgPadrao = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            clsServico servico = new clsServico();

            if (!(servico.detalhesServico(cdServico)))
            {
                Response.Write("false");
                return;
            }

            detalhesServico += "<div class='areaDetalhesInformacaoPaciente'>";
			detalhesServico += "<h3 class='tituloInfoPaciente'>Informações do Paciente</h3>";
			detalhesServico += "<div class='areaImagemPaciente' id='areaImagemDetalhes'></div>";
			detalhesServico += "<div class='areaDadosDetalhe'>";
			detalhesServico += "<h3 class='nomePacienteDetalhes'>" + servico.nm_paciente[0] + "</h3>";
            detalhesServico += "<span class='necessidadePacienteDetalhes'>Necessidade: </span><span class='necessidadePaciente'>" + servico.nm_necessidade + "</span>";
			detalhesServico += "</div>";
			detalhesServico += "<div class='areaDescricaoDetalhe'>";
			detalhesServico += "<h3 class='tituloDescricao'>Descrição:</h3>";
            detalhesServico += "<h3 class='descricao'>" + servico.ds_paciente + "</h3>";
			detalhesServico += "</div>";
			detalhesServico += "<h3 class='tituloInfoPaciente'>Informações do Serviço</h3>";
			detalhesServico += "<div class='areaInfoServicoDetalhe'>";
			detalhesServico += "<div class='areaDetalhe'>";
            if (servico.nm_comp_servico != "")
            {
                detalhesServico += "<span class='dadosDetalhe'>Endereço: </span><span class='dadosServicoDetalhe'>" + servico.nm_rua_servico[0] + " " + servico.nm_num_servico + " - " + servico.cd_CEP_servico + " - " + servico.nm_comp_servico + " - " + servico.nm_cidade_servico + " " + servico.nm_uf_servico + "</span>";
            }
            else
            {
                detalhesServico += "<span class='dadosDetalhe'>Endereço: </span><span class='dadosServicoDetalhe'>" + servico.nm_rua_servico[0] + " " + servico.nm_num_servico + " - " + servico.cd_CEP_servico + " - " + servico.nm_cidade_servico + " " + servico.nm_uf_servico + "</span>";
            }
			detalhesServico += "</div>";
			detalhesServico += "<div class='areaDetalhe'>";
            detalhesServico += "<span class='dadosDetalhe'>Horário: </span><span class='dadosServicoDetalhe'>" + servico.hr_inicio_servico[0] + " - " + servico.hr_fim_servico[0] + "</span>";
			detalhesServico += "</div>";
			detalhesServico += "<div class='areaDetalhe'>";
            detalhesServico += "<span class='dadosDetalhe'>Duração: </span><span class='dadosServicoDetalhe'>" + servico.duracaoServico[0] + " hr(s)</span>";
			detalhesServico += "</div>";
			detalhesServico += "<div class='areaDetalhe'>";
            string duracao = servico.duracaoServico[0];
            string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
            string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
            double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
            double valorTotal = horaFinal * double.Parse(servico.vl_cuidador[0]);
			detalhesServico += "<span class='dadosDetalhe'>Valor pago: </span><span class='dadosServicoDetalhe'>" + valorTotal.ToString("C") + "</span>";
			detalhesServico += "</div>";
			detalhesServico += "<div class='areaDetalhe'>";
            detalhesServico += "<span class='dadosDetalhe'>Valor hora: </span><span class='dadosServicoDetalhe'>R$" + servico.vl_cuidador[0] + "</span>";
			detalhesServico += "</div>";
			detalhesServico += "</div>";
			detalhesServico += "</div>";
            detalhesServico += "<button type='submit' class='btnDenunciar'>Denunciar</button>";

            Response.Write(detalhesServico);
        }
    }
}