using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libServicosCuidadorAdm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["emailCuidador"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["emailCuidador"].ToString() == "")
            {
                Response.Write("false");
                return;
            }
            #endregion

            string emailCuidador = Request["emailCuidador"].ToString();

            clsAdministrador adm = new clsAdministrador();

            if (!(adm.infoCuidadorContrato(emailCuidador)))
            {
                Response.Write("false");
                return;
            }

            if (!(adm.listarServicosCuidador(emailCuidador)))
            {
                Response.Write("false");
                return;
            }

            string servicosCuidador = "";

            servicosCuidador += "<div class='areaCuidador'>";
            servicosCuidador += "<div class='areaImagemCuidador' style='background-image: url('img/imgCuidador1.jfif'); margin-top: 10px; margin-left: 16px;'></div>";
            servicosCuidador += "<div class='areaNomeCuidador'>";
            servicosCuidador += "<h3 class='nomeCuidador' style='width: 400px'>" + adm.nomeCuidador[0] + "</h3>";					
            servicosCuidador += "</div>";
            servicosCuidador += "</div>";
            servicosCuidador += "<div class='tituloConteudo'><span>Serviços</span></div>";

            for (int i = 0; i < adm.dtFimServico.Count; i++)
            {
                servicosCuidador += "<div class='areaServico'>";
                servicosCuidador += "<div class='tituloServico'><span>Cliente:</span><span class='emailClienteServico'>" + adm.emailCliente[i] + "</span></div>";
                servicosCuidador += "<div class='areaInfoServico'>";
                servicosCuidador += "<span>Data de início:</span><span class='dataInicioServico'>" + adm.dtInicioServico[i] + "</span>";
                servicosCuidador += "<br/>";
                servicosCuidador += "<span>Data de fim:</span> <span class='dataFimServico'>" + adm.dtFimServico[i] + "</span>";
                servicosCuidador += "<br/>";
                servicosCuidador += "<span>Duração</span><span class='dataInicioServico'>" + adm.hrInicioServico[i] + " - </span><span class='dataFimServico'>" + adm.hrFimServico[i] + "</span>";
                servicosCuidador += "<br/>";
                string duracao = adm.duracaoServico[i];
                string duracaoMinutos = duracao[3].ToString() + duracao[4].ToString();
                string duracaoHoras = duracao[0].ToString() + duracao[1].ToString();
                double horaFinal = double.Parse(duracaoHoras) + (double.Parse(duracaoMinutos) / 60);
                double valorTotal = horaFinal * double.Parse(adm.vlHora[0]);
                if (adm.statusServico[i] != "Cancelado")
                {
                    servicosCuidador += "<span>Valor Total:</span><span class='valorTotalServico'>" + valorTotal.ToString("C") + "</span>";
                    servicosCuidador += "<br/>";
                }
                if (adm.statusServico[i] == "Finalizado")
                {
                    servicosCuidador += "<span>Status:</span><span class='statusServico finalziado'>" + adm.statusServico[i] + "</span>";
                }
                if (adm.statusServico[i] == "Em Andamento" || adm.statusServico[i] == "Pendente")
                {
                    servicosCuidador += "<span>Status:</span><span class='statusServico pendente'>" + adm.statusServico[i] + "</span>";
                }
                if (adm.statusServico[i] == "Cancelado")
                {
                    servicosCuidador += "<span>Status:</span><span class='statusServico cancelado'>" + adm.statusServico[i] + "</span>";
                }
                servicosCuidador += "</div>";
                servicosCuidador += "</div>";
            }

            servicosCuidador += "</div>";
            servicosCuidador += "</div>";

            Response.Write(servicosCuidador);
        }
    }
}