using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libAgendadosAgendaCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação do Request 
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

            clsServico classeAgendaCliente = new clsServico();

            if (!classeAgendaCliente.listarAgendaCliente(emailCliente,false))
            {
                Response.Write("erro");
                return;
            }

            string listaAgendaCliente = "";

            for (int i = 0; i < classeAgendaCliente.nm_cuidador.Count; i++)
            {
                listaAgendaCliente += "<div class='areaDadosAgendados " + classeAgendaCliente.cd_servico[i].ToString() + "'>";
                listaAgendaCliente += "   <div class='iconeRelogio'>";
                listaAgendaCliente += "       <img src='../../img/icones/agenda/iconeRelogio.png' >";
                listaAgendaCliente += "   </div>";
                listaAgendaCliente += "   <h3 class='dataServico'>Serviço agendado para " + classeAgendaCliente.diferencaData[i].ToString() +" dias</h3>";
                listaAgendaCliente += "   <div class='areaImagemCuidador'); margin-top: 10px; margin-left: 16px;'></div>";
                listaAgendaCliente += "       <div class='areaInfoAgenda'>";
                listaAgendaCliente += "           <h3>"+ classeAgendaCliente.nm_cuidador[i].ToString() +"</h3>";
                listaAgendaCliente += "           <img src='../../img/icones/agenda/iconeMaleta.png'>";
                listaAgendaCliente += "           <span class='especializacao'>" + classeAgendaCliente.nm_especializacao[i].ToString() + "</span>";
                listaAgendaCliente += "           <p>Serviço agendado para " + classeAgendaCliente.dt_inicio_servico[i].ToString() +", das " + classeAgendaCliente.hr_inicio_servico[i].ToString() + " ás " + classeAgendaCliente.hr_fim_servico[i].ToString() + " horas para paciente " + classeAgendaCliente.nm_paciente[i].ToString() + "</p>";
                listaAgendaCliente += "           <span class='status'>Status: </span><span class='statusAgendado'>" + classeAgendaCliente.situacaoServico[i].ToString() + "</span>";
                listaAgendaCliente += "           <div class='valor'>";
                string duracao = classeAgendaCliente.duracaoServico[i];
                string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
                string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
                double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
                double valorTotal = horaFinal * double.Parse(classeAgendaCliente.vl_cuidador[i]);
                listaAgendaCliente += "               <span>Total: </span><span>" + valorTotal.ToString() + " Reais</span>";
                listaAgendaCliente += "           </div>";
                listaAgendaCliente += "   </div>";
                listaAgendaCliente += "   <div class='invi'>" + classeAgendaCliente.base64String[i].ToString() +"</div>";
                listaAgendaCliente += "</div>";
            }

            Response.Write(listaAgendaCliente);

        }
    }
}