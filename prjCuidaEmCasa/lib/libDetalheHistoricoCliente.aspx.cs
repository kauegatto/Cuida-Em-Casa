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

            if (!classeDetalheHistorico.listarAvaliacao(classeDetalheHistorico.emailCuidador[0]))
            {
                Response.Write("erro");
                return;
            }

            double contadorAvaliacao = 0;

            for (int i = 0; i < classeDetalheHistorico.cd_avaliacaoNota.Count; i++)
            {
                contadorAvaliacao += double.Parse(classeDetalheHistorico.cd_avaliacaoNota[i]);
            }

            double qtEstrelas = 0;

            qtEstrelas = contadorAvaliacao / classeDetalheHistorico.cd_avaliacaoNota.Count;

            double notaAvaliacao = qtEstrelas;

            string imagemEstrela = "";

            for (int j = 0; j <= qtEstrelas - 1; qtEstrelas--)
            {
                imagemEstrela += "<img src='../../img/icones/cuidador/estrela.png' class='iconeEstrela'>";
            }

            if (qtEstrelas != 0 && qtEstrelas > 0)
            {
                if (qtEstrelas >= 0.5 && qtEstrelas < 1)
                {
                    imagemEstrela += "<img src='../../img/icones/cuidador/meiaestrela.png' class='iconeEstrela'>";
                }
            }
            

            string duracao = classeDetalheHistorico.duracaoServico[0];
            string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
            string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
            double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
            double valorTotal = horaFinal * double.Parse(classeDetalheHistorico.vl_cuidador[0]);



            //double qtEstrelas = 00.00;
            //if (double.TryParse(classeDetalheHistorico.cd_avaliacao[0], out qtEstrelas))
            //{

            //    for (int j = 0; j <= qtEstrelas - 1; qtEstrelas--)
            //    {
            //        imagemEstrela += "<img src='../../img/icones/cuidador/estrela.png' class='iconeEstrela'>";
            //    }

            //    if (qtEstrelas != 0 && qtEstrelas > 0)
            //    {
            //        if (qtEstrelas == 0.5)
            //        {
            //            imagemEstrela += "<img src='../../img/icones/cuidador/meiaestrela.png' class='iconeEstrela'>";
            //        }
            //    }
            //}

            Response.Write(
                classeDetalheHistorico.base64String[0] + ";" + 
                classeDetalheHistorico.nm_cuidador[0]  + ";" + 
                imagemEstrela  + ";" +
                notaAvaliacao + ";" + 
                classeDetalheHistorico.nm_especializacao[0]  + ";" + 
                classeDetalheHistorico.nm_genero[0]  + ";" + 
                classeDetalheHistorico.ds_cuidador[0]  + ";" + 
                classeDetalheHistorico.nm_rua_servico[0]  + ";" + 
                classeDetalheHistorico.nm_num_servico  + ";" + 
                classeDetalheHistorico.cd_CEP_servico  + ";" + 
                classeDetalheHistorico.nm_comp_servico  + ";" + 
                classeDetalheHistorico.nm_cidade_servico  + ";" + 
                classeDetalheHistorico.nm_uf_servico + ";" + 
                classeDetalheHistorico.hr_inicio_servico[0]  + ";" + 
                classeDetalheHistorico.hr_fim_servico[0] + ";" + 
                valorTotal + ";" + 
                classeDetalheHistorico.emailCuidador[0] + ";" +
                classeDetalheHistorico.situacaoServico[0]
            );
        }
    }
}