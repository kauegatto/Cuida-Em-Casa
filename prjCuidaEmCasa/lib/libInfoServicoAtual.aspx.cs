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
            #region validação

            if (Request["cdServico"] == "" || Request["cdServico"] == null)
            {     
                Response.Write("false");
                return;
            }
            #endregion

            string cdServico = Request["cdServico"];

            if (!paciente.infoServicoAtual(cdServico))
            {
                Response.Write("false");
                return;
            }

            string infoServico = "";

            infoServico += "<div class='areaDadosBuscandoCuidadores'>";
			infoServico += "<div class='areaImagemCuidador'></div>";
            
            try
            {
                infoServico += "<div class='invi' style='display: none'>" + paciente.base64String[0] + "</div>";
            }
            catch {
                Response.Write("erro");
                return;
            }

            infoServico += "<div class='areaDadosCuidador'>";
			infoServico += "<h3>" + paciente.nm_cuidador + "</h3>";
            string duracao = paciente.duracao;
            string duracaoMinutos = duracao[4].ToString() + duracao[5].ToString();
            string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
            double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
            double valorTotal = horaFinal * double.Parse(paciente.vl_trabalho);
			infoServico += "<h4>" + paciente.nm_rua + " " + paciente.nm_num + " - " + paciente.nm_bairro + " " + paciente.dt_inicio_servico + " - " + paciente.dt_semana + " | " + paciente.hr_inicio_servico + " - " + paciente.hr_fim_servico + " | " + valorTotal.ToString("C") + "</h4>";
			infoServico += "</div>";
			infoServico += "</div>";
			infoServico += "<h3 class='tituloBuscandoCuidadores'>Localização do Cuidador</h3>";
			infoServico += "<div class='areaLocalizacaoCuidador'>";
			infoServico += "<div id='map'></div>";
            infoServico += "<span id='informacoesEndereco' style='display:none;'>"+ paciente.nm_rua + ' ' + paciente.nm_num + ' '+ paciente.nm_bairro +' ' + paciente.nm_cidade[0] + ' ' +paciente.nm_estado[0] + "</span>";
			infoServico += "</div>";
			infoServico += "<h3 class='tituloBuscandoCuidadores' style='width: 311px; margin-left: 22px;font-size:15px;color:#222;'>Estimativa de 30 minutos até sua chegada</h3>";
            infoServico += "<button class='btnCancelar' type='button'>Cencelar</button>";
           
            Response.Write(infoServico);
        }
    }
}