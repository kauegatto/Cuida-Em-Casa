using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libDetalheAgendaCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

            string cdServico = Request["codigoServico"].ToString();

            clsServico classeDetalheAgendados = new clsServico();

            if (!classeDetalheAgendados.mostrarDadosAgendados(cdServico))
            {
                Response.Write("erro");
                return;
            }

            string listaAgenda = "";
            string duracao = classeDetalheAgendados.duracaoServico[0];
            string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
            string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
            double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
            double valorTotal = horaFinal * double.Parse(classeDetalheAgendados.vl_cuidador[0]);

            listaAgenda += "<div class='areaInformacoesCuidador1'>";
            listaAgenda += "<h3 class='tituloInformacoesCuidador'>Informações do Cuidador</h3>";
            listaAgenda += "<div class='areaImagemCuidador' style='margin-top: 10px; margin-left: 16px;'></div>";
            listaAgenda += "<div class='invi'>"+ classeDetalheAgendados.base64String[0]+"</div>";
            listaAgenda += "<div class='areaDadosCuidador'>";
            listaAgenda += "<h3>" + classeDetalheAgendados.nm_cuidador[0] + "</h3>";
            listaAgenda += "<div class='areaEstrela'>";
            double qtEstrelas = 00.00;
            if (double.TryParse(classeDetalheAgendados.cd_avaliacao[0], out qtEstrelas))
            {

                for (int j = 0; j <= qtEstrelas - 1; qtEstrelas--)
                {
                    listaAgenda += "<img src='../../img/icones/cuidador/estrela.png' class='iconeEstrela'>";
                }

                if (qtEstrelas != 0 && qtEstrelas > 0)
                {
                    if (qtEstrelas == 0.5)
                    {
                        listaAgenda += "<img src='../../img/icones/cuidador/meiaestrela.png' class='iconeEstrela'>";
                    }
                }
            }
            listaAgenda += "<span>" + classeDetalheAgendados.cd_avaliacao[0] + "</span>";
            listaAgenda += "</div>";
            listaAgenda += "<div>";
            listaAgenda += "<img src='../../img/icones/agenda/iconeMaleta.png'>";
            listaAgenda += "<span>" + classeDetalheAgendados.nm_especializacao[0] + "</span>";
            listaAgenda += "</div>";
            listaAgenda += "<div>";
            listaAgenda += "<span>Gênero: </span><span style='font-weight: normal'>" + classeDetalheAgendados.nm_genero[0] +"</span>";
            listaAgenda += "</div>";
            listaAgenda += "</div>";
            listaAgenda += "<div class='areaDescricao'>";
            listaAgenda += "<h3>Descrição:</h3>";
            listaAgenda += "<p>" + classeDetalheAgendados.ds_cuidador[0] + "</p>";
            listaAgenda += "</div>";
            listaAgenda += "<div class='linha'></div>";
            listaAgenda += "<h3 class='tituloInformacoesCuidador' style='margin-top: 0px;'>Informações do Serviço</h3>";
            listaAgenda += "<div class='areaEndereco' style='height: 131px'>";
            listaAgenda += "<div class='endereco'>";
            listaAgenda += "<span class='tituloEndereco'>Endereço: </span> <span class='infoEndereco'>" + classeDetalheAgendados.nm_rua_servico[0] + " - " + classeDetalheAgendados.nm_num_servico + " - " + classeDetalheAgendados.cd_CEP_servico + " - " + classeDetalheAgendados.nm_comp_servico + classeDetalheAgendados.nm_cidade_servico + " - " + classeDetalheAgendados.nm_uf_servico + "</span>";
            listaAgenda += "</div>";
            listaAgenda += "<div class='endereco'>";
            listaAgenda += "<span class='tituloEndereco'>Horário: </span><span class='infoEndereco'>" + classeDetalheAgendados.hr_inicio_servico[0] + " - " + classeDetalheAgendados.hr_fim_servico[0] +"</span>";
            listaAgenda += "</div>";
            listaAgenda += "<div class='endereco'>";
            listaAgenda += "<span class='tituloEndereco'>Valor pago: </span><span class='infoEndereco'>" + valorTotal + " reais</span>";
            listaAgenda += "</div>";
            listaAgenda += "<div class='endereco'>";
            listaAgenda += "<span class='tituloEndereco'>Status: </span><span class='infoEndereco' style='color: #27AE60; font-weight: bold;'>" + classeDetalheAgendados.situacaoServico[0] + "</span>";
            listaAgenda += "</div>";
            listaAgenda += "</div>";
            listaAgenda += "</div>";
            listaAgenda += "</div>";

            Response.Write(listaAgenda);
            
        }
    }
}