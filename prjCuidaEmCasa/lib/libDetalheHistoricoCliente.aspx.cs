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

            string infoServico = "";

            string duracao = classeDetalheHistorico.duracaoServico[0];
            string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
            string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
            double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
            double valorTotal = horaFinal * double.Parse(classeDetalheHistorico.vl_cuidador[0]);

            infoServico += "<div class='areaInformacoesCuidador'>";
            infoServico += "<h3 class='tituloInformacoesCuidador'>Informações do Cuidador</h3>";
            infoServico += "<div class='areaImagemCuidador' style='margin-top: 10px; margin-left: 16px;'></div>";
            infoServico += "<div class='invi'>" + classeDetalheHistorico.base64String[0] +"</div>";
            infoServico += "<div class='areaDadosCuidador'>";
            infoServico += "<h3 id='nomeCuidador'>" + classeDetalheHistorico.nm_cuidador[0] + "</h3>";
            infoServico += "<div class='areaEstrela'>";

            double qtEstrelas = 00.00;
            if (double.TryParse(classeDetalheHistorico.cd_avaliacao[0], out qtEstrelas))
            {

                for (int j = 0; j <= qtEstrelas - 1; qtEstrelas--)
                {
                    infoServico += "<img src='../../img/icones/cuidador/estrela.png' class='iconeEstrela'>";
                }

                if (qtEstrelas != 0 && qtEstrelas > 0)
                {
                    if (qtEstrelas == 0.5)
                    {
                        infoServico += "<img src='../../img/icones/cuidador/meiaestrela.png' class='iconeEstrela'>";
                    }
                }
            }

            infoServico += "<span id='notaAvaliacao'> " + classeDetalheHistorico.cd_avaliacao[0] +"</span>";
            infoServico += "</div>";
            infoServico += "<div>";
            infoServico += "<img src='../../img/icones/agenda/iconeMaleta.png'>";
            infoServico += "<span id='especializacao'>" + classeDetalheHistorico.nm_especializacao[0] + "</span>";
            infoServico += "</div>";
            infoServico += "<div>";
            infoServico += "<span>Gênero: </span><span style='font-weight: normal' id='genero'>" + classeDetalheHistorico.nm_genero[0] +"</span>";
            infoServico += "</div>";
            infoServico += "</div>";
            infoServico += "<div class='areaDescricao'>";
            infoServico += "<h3>Descrição:</h3>";
            infoServico += "<p id='descricao'>" + classeDetalheHistorico.ds_cuidador[0] +"</p>";
            infoServico += "</div>";
            infoServico += "<div class='linha'></div>";
            infoServico += "<h3 class='tituloInformacoesCuidador' style='margin-top: 0px;'>Informações do Serviço</h3>";
            infoServico += "<div class='areaEndereco'>";
            infoServico += "<div class='endereco'>";
            infoServico += "<span class='tituloEndereco'>Endereço: </span> <span class='infoEndereco' id='ruaServico'>" + classeDetalheHistorico.nm_rua_servico[0] + " - " + classeDetalheHistorico.nm_num_servico + " - " + classeDetalheHistorico.cd_CEP_servico + " - " + classeDetalheHistorico.nm_comp_servico + " - " + classeDetalheHistorico.nm_cidade_servico + " - " + classeDetalheHistorico.nm_uf_servico + "</span>";
            infoServico += "</div>";
            infoServico += "<div class='endereco'>";
            infoServico += "<span class='tituloEndereco'>Horário: </span><span class='infoEndereco' id='horario'>" + classeDetalheHistorico.hr_inicio_servico[0] + " - " + classeDetalheHistorico.hr_fim_servico[0] + "</span>";
            infoServico += "</div>";
            infoServico += "<div class='endereco'>";
            infoServico += "<span class='tituloEndereco'>Valor pago: </span><span class='infoEndereco' id='valorTotal'>" + valorTotal +"</span>";
            infoServico += "</div>";
            infoServico += "<div class='linha' style='margin-top: 8px;'></div>";
            infoServico += "<h3 class='tituloInformacoesCuidador' style='margin-top: 0px; margin-left: 49px;'>Avaliação do Serviço</h3>";
            infoServico += "<div class='areaAvaliacao'>";
            infoServico += "<div class='areaEstrela'>";
            infoServico += "<span style='font-size: 16px; margin-left: 5px;'>Sua Avaliação: </span>";
            infoServico += "<img src='../../img/icones/agenda/iconeEstrelaPreenchida.png'>";
            infoServico += "<img src='../../img/icones/agenda/iconeEstrelaPreenchida.png'>";
            infoServico += "<img src='../../img/icones/agenda/iconeEstrelaPreenchida.png'>";
            infoServico += "<img src='../../img/icones/agenda/iconeEstrelaPreenchida.png'>";
            infoServico += "<img src='../../img/icones/agenda/iconeEstrelaVazada.png'>";
            infoServico += "<span>5.0/5.0</span>";
            infoServico += "</div>";
            infoServico += "<span>Comentário: </span><span style='font-size: 14px; font-weight: normal;'>Muito bom  e atencioso!</span>";
            infoServico += "</div>";
            infoServico += "</div>";
            infoServico += "</div>";

            Response.Write(infoServico);
        }
    }
}