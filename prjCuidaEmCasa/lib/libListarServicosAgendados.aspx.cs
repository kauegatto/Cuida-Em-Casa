using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.ServicoAgendado;

namespace prjCuidaEmCasa.lib
{
    public partial class libListarServicosAgendados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação de Request 
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

            #endregion 
            #region Validação de Request
            if (Request["diaSelecionado"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["diaSelecionado"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            #endregion 
            
            #region Lista dos Serviços Agendados

            string usuarioLogado = Request["e"].ToString();
            string dataServico = Request["diaSelecionado"];
            clsServicoAgendado classeServicoAgendado = new clsServicoAgendado();

            if (!classeServicoAgendado.listarServicosAgendados(usuarioLogado,dataServico))
            {
                Response.Write("erro");
                return;
            }

            string listaServicosAgendados = "";

            for (int i = 0; i < classeServicoAgendado.nomePaciente.Count; i++)
            {
                listaServicosAgendados += "<div class='areaAgendaConteudo " + classeServicoAgendado.codigoServico[i].ToString() + "'>";
                listaServicosAgendados += "    <div class='areaDataAgendamento'>";
                listaServicosAgendados += "        <div class='iconeRelogio'>";
                listaServicosAgendados += "            <img src='../../img/icones/servicoAgendado/iconeRelogio.png' >";
                listaServicosAgendados += "        </div>";
                listaServicosAgendados += "    <h3 class='dataAgendamento'>Daqui " + classeServicoAgendado.diferencaData[i].ToString() + " dias - " + classeServicoAgendado.dataServico[i].ToString() +"</h3>";
                listaServicosAgendados += "    </div>";
                listaServicosAgendados += "    <div class='linha'></div>";
                listaServicosAgendados += "    <div class='areaImagemPacienteAgendamento'></div>";
                listaServicosAgendados += "        <div class='areaDadosServico'>";
                listaServicosAgendados += "            <h3 class='nomePaciente'>" + classeServicoAgendado.nomePaciente[i].ToString() +"</h3>";
                listaServicosAgendados += "            <span class='necessidadePaciente'>" + classeServicoAgendado.necessidadePaciente[i].ToString() +"</span>";
                string duracao = classeServicoAgendado.duracaoServico[i];
                string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
                string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
                double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
                double valorTotal = horaFinal * double.Parse(classeServicoAgendado.valorHora[i]);
                listaServicosAgendados += "            <span class='infoPaciente'>" + classeServicoAgendado.nomeRuaPaciente[i].ToString() + " - " + classeServicoAgendado.numeroCasaPaciente[i].ToString() + " | " + classeServicoAgendado.horaInicioServico[i].ToString() + " - " + classeServicoAgendado.horaFimServico[i].ToString() + " | " + "R$ " + valorTotal.ToString()  +"</span>";
                listaServicosAgendados += "            <div class='areaStatus'>";
                listaServicosAgendados += "                <span class='status'>Status: </span><span class='statusServico'>" + classeServicoAgendado.situacaoServico[i].ToString() +"</span>";
                listaServicosAgendados += "           </div>";
                listaServicosAgendados += "   </div>";
                listaServicosAgendados += "   <div class='invi'> " + classeServicoAgendado.base64String[i].ToString() + "</div>";
                listaServicosAgendados += "</div>";
            }

            Response.Write(listaServicosAgendados);
            #endregion 
        }
    }
}