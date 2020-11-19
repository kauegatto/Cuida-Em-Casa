using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libServicoAtual : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["cdServico"] == null)
            {
                Response.Write("false");
            }

            if (Request["cdServico"].ToString() == "")
            {
                Response.Write("false");
            }
            #endregion

            clsServico servico = new clsServico();

            string cdServico = Request["cdServico"].ToString();

            if (!(servico.infoServicoAtual(cdServico)))
	        {
		        Response.Write("false");
                return;
	        }

            string dadosServicoAtual = "";

            dadosServicoAtual += "<h3 class='tituloServicoAtual'>Serviço Atual</h3>";
			dadosServicoAtual += "<div class='areaInfoPaciente' style='height: 131px'>";
			dadosServicoAtual += "<div class='areaImagemPaciente'></div>";
            dadosServicoAtual += "<div class='invi'>" + servico.base64String[0] + "</div>";
			dadosServicoAtual += "<div class='areaDadosPaciente'>";
			dadosServicoAtual += "<h3 class='nomePaciente'>" + servico.nm_paciente[0] + "</h3>";
			dadosServicoAtual += "<h3 class='necessidadePaciente'>" + servico.nm_necessidade + "</h3>";
            string duracao = servico.duracaoServico[0];
            string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
            string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
            double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
            double valorTotal = horaFinal * double.Parse(servico.vl_cuidador[0]);
			dadosServicoAtual += "<h3 class='enderecoPaciente'>" + servico.nm_rua_servico[0] + " " + servico.nm_num_servico + " - " + servico.nm_comp_servico + " - " + servico.dt_inicio_servico[0] + " - " + servico.diaDaSemana + " | " + servico.hr_inicio_servico[0] + " - " + servico.hr_fim_servico[0] + " | " + valorTotal.ToString("C") + "</h3>";
			dadosServicoAtual += "</div>";
			dadosServicoAtual += "</div>";
			dadosServicoAtual += "<div class='areaMapa'>";
			dadosServicoAtual += "</div>";
			dadosServicoAtual += "<button class='btnCheckin 0'>Fazer Check-In</button>";
            dadosServicoAtual += "<button class='btnCheckout 1' style='display:none'>Fazer Checkout</button>";

            Response.Write(dadosServicoAtual);
        }
    }
}