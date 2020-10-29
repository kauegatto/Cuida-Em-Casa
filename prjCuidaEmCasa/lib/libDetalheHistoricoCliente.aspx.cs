using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libDetalheHistoricoCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            #region Validação do Post
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

            string codigoServicoSelecionado = Request["codigoServico"].ToString();
            #endregion

            clsServico classeDetalheHistorico = new clsServico();

            if (!classeDetalheHistorico.mostrarDadosHistorico(codigoServicoSelecionado))
            {
                Response.Write("erro");
                return;
            }

            string duracao = classeDetalheHistorico.duracaoServico[0];
            string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
            string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
            double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
            double valorTotal = horaFinal * double.Parse(classeDetalheHistorico.vl_cuidador[0]);

            Response.Write
            (
                classeDetalheHistorico.base64String[0] + ";" +
                classeDetalheHistorico.nm_cuidador[0]  + ";" +
                classeDetalheHistorico.cd_avaliacao[0] + ";" +
                classeDetalheHistorico.nm_especializacao[0]  + ";" +
                classeDetalheHistorico.nm_genero[0] + ";" +
                classeDetalheHistorico.ds_cuidador[0] + ";" +
                classeDetalheHistorico.nm_rua_servico[0] + ";" +
                classeDetalheHistorico.nm_num_servico  + ";" +
                classeDetalheHistorico.cd_CEP_servico  + ";" +
                classeDetalheHistorico.nm_comp_servico + ";" +
                classeDetalheHistorico.nm_cidade_servico + ";" +
                classeDetalheHistorico.nm_uf_servico + ";" +
                classeDetalheHistorico.hr_inicio_servico[0]  + ";" +
                classeDetalheHistorico.hr_fim_servico[0] + ";" +
                classeDetalheHistorico.duracaoServico[0]  + ";" +
                valorTotal
            );
        }
    }
}