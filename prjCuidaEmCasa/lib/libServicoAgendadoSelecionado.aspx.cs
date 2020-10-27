using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.ServicoAgendado;

namespace prjCuidaEmCasa.lib
{
    public partial class libServicoAgendadoSelecionado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação 

            if (Request["codigoServico"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["codigoServico"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string codigoServico = "";

            codigoServico = Request["codigoServico"].ToString();
            #endregion

            clsServicoAgendado classeServicoAgendado = new clsServicoAgendado();

            if (!classeServicoAgendado.listarServicoSelecionado(codigoServico))
            {
                Response.Write("erro");
                return;
            }

            string duracao = classeServicoAgendado.duracaoServico[0];
            string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
            string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
            double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
            double valorTotal = horaFinal * double.Parse(classeServicoAgendado.valorHora[0]);

            Response.Write
            (
                classeServicoAgendado.base64String[0] + ";" + 
                classeServicoAgendado.nomePaciente[0] + ";" + 
                classeServicoAgendado.necessidadePaciente[0] + ";" + 
                classeServicoAgendado.descricaoPaciente[0] + ";" + 
                classeServicoAgendado.cepServico[0] + ";" + 
                classeServicoAgendado.bairroServico[0] + ";" + 
                classeServicoAgendado.nomeRuaPaciente[0] + ";" + 
                classeServicoAgendado.numeroCasaPaciente[0] + ";" + 
                classeServicoAgendado.cidadeServico[0] + ";" + 
                classeServicoAgendado.ufServico[0] + ";" +
                classeServicoAgendado.complementoCasaServico[0] + ";" +
                classeServicoAgendado.horaInicioServico[0] + ";" +
                classeServicoAgendado.horaFimServico[0] + ";" +
                classeServicoAgendado.duracaoServico[0] + ";" +
                valorTotal + ";" +
                classeServicoAgendado.situacaoServico[0] + ";" +
                classeServicoAgendado.valorHora[0]
            ); 
        }
    }
}