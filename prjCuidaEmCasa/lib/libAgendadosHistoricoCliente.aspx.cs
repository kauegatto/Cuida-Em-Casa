using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libAgendadosHistoricoCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação do POST

            if (Request["e"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["e"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string emailCliente = Request["e"].ToString();

            #endregion

            clsServico classeHistoricoCliente = new clsServico();

            if (!classeHistoricoCliente.listarAgendaCliente(emailCliente,true))
            {
                Response.Write("erro");
                return;
            }

            string listaHistorico = "";

            for (int i = 0; i < classeHistoricoCliente.nm_paciente.Count; i++)
            {
                listaHistorico += "<div class='areaDadosAgendados " + classeHistoricoCliente.cd_servico[i].ToString() +"'>";
                listaHistorico += "    <h3 class='dataServico'>" + classeHistoricoCliente.dt_inicio_servico[i].ToString() + " - " + classeHistoricoCliente.hr_inicio_servico[i].ToString() + " às " + classeHistoricoCliente.hr_fim_servico[i].ToString() + "</h3>";
                listaHistorico += "    <div class='areaImagemCuidador' style='margin-top: 10px; margin-left: 16px;'></div>";
                listaHistorico += "        <div class='areaInfoAgenda'>";
                listaHistorico += "            <h3>" + classeHistoricoCliente.nm_cuidador[i].ToString() + "</h3>";
                listaHistorico += "            <img src='../../img/icones/agenda/iconeMaleta.png'>";
                listaHistorico += "            <span class='especializacao'>" + classeHistoricoCliente.nm_especializacao[i].ToString() + "</span>";
                listaHistorico += "            <p>Serviço realizado no dia " + classeHistoricoCliente.dt_inicio_servico[i].ToString() + " duração de " + classeHistoricoCliente.duracaoServico[i].ToString() + " horas para paciente " + classeHistoricoCliente.nm_paciente[i].ToString() + ".</p>";
                listaHistorico += "            <span class='status'>Status: </span><span class='status'>" + classeHistoricoCliente.situacaoServico[i].ToString() +"</span>";
                listaHistorico+= "           <div class='valor'>";
                string duracao = classeHistoricoCliente.duracaoServico[i];
                string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
                string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
                double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
                double valorTotal = horaFinal * double.Parse(classeHistoricoCliente.vl_cuidador[i]);
                listaHistorico += "               <span>Total: </span><span>" + valorTotal.ToString() + " Reais</span>";
                listaHistorico += "           </div>";
                listaHistorico += "    </div>";
                listaHistorico += "    <div class='invi'>" + classeHistoricoCliente.base64String[i].ToString() + "</div>";
                listaHistorico += "</div>";
            }

            Response.Write(listaHistorico);
           
        }
    }
}