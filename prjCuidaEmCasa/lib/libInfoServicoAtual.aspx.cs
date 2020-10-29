using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libInfoServicoAtual : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsPaciente paciente = new clsPaciente();

            string cdServico = "24";

            if (!paciente.infoServicoAtual(cdServico))
            {
                return;
            }

            string infoServico = "";

            infoServico += "<div class='areaDadosBuscandoCuidadores'>";
			infoServico += "<div class='areaImagemCuidador'></div>";
            infoServico += "<div class='invi' style='display: none'>" + paciente.base64String[0] + "</div>";
			infoServico += "<div class='areaDadosCuidador'>";
			infoServico += "<h3>" + paciente.nm_cuidador + "</h3>";
            string duracao = paciente.duracao;
            string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
            string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
            double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
            double valorTotal = horaFinal * double.Parse(paciente.vl_trabalho);
			infoServico += "<h4>" + paciente.nm_rua + " " + paciente.nm_num + " - " + paciente.nm_bairro + " " + paciente.dt_inicio_servico + " - " + paciente.dt_semana + " | " + paciente.hr_inicio_servico + " - " + paciente.hr_fim_servico + " | " + valorTotal.ToString("C") + "</h4>";
			infoServico += "</div>";
			infoServico += "</div>";
			infoServico += "<h3 class='tituloBuscandoCuidadores'>Localização do Cuidador</h3>";
			infoServico += "<div class='areaLocalizacaoCuidador'>";
			infoServico += "<img src='img/mapa.png'>";
			infoServico += "</div>";
			infoServico += "<h3 class='tituloBuscandoCuidadores' style='width: 311px; margin-left: 22px;'>Estimativa de 30 minutos até sua chegada</h3>";
            infoServico += "<button class='btnCancelar' type='button'>Cencelar</button>";
           
            Response.Write(infoServico);
        }
    }
}