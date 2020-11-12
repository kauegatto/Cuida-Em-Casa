using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libBuscarCuidadorAgora : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["vl"] == null)
            {
                Response.Write("erro");
            }

            if (Request["vl"].ToString() == "")
            {
                Response.Write("erro");
            }

            if (Request["usuario"] == null)
            {
                Response.Write("erro");
            }

            if (Request["usuario"].ToString() == "")
            {
                Response.Write("erro");
            }

            if (Request["cd"] == null)
            {
                Response.Write("erro");
            }

            if (Request["cd"].ToString() == "")
            {
                Response.Write("erro");
            }
            #endregion

            string valorMaximo = Request["vl"].ToString();
            string usuario = Request["usuario"].ToString();
            string cdServico = Request["cd"].ToString();

            clsServico servico = new clsServico();

            if (!(servico.buscarCuidadorAgora(valorMaximo)))
            {
                Response.Write("false");
                return;
            }

            servico.detalhesServicoHistoricoCuidador(cdServico);
            string dadosCuidadorAgora = "";
            for (int i = 0; i < servico.emailCuidador.Count; i++)
            {
                if (servico.emailCuidador[i] == usuario)
                {
                    dadosCuidadorAgora += "<h3 class='tituloServicoEncontrado'>Serviço Encontrado</h3>";
				    dadosCuidadorAgora += "<h3 class='nomePacienteServicoEncontrado'>" + servico.nm_paciente[0] + "</h3>";
				    dadosCuidadorAgora += "<h3 class='areaInfoServicoEncontrado'>" + servico.duracaoServico[0] + "  de serviço</h3>";
                    dadosCuidadorAgora += "<button class='btnVerMaisServicoEncontrado' type='button'>Ver Mais</button>";
                }
            }
            Response.Write(dadosCuidadorAgora);
        }
    }
}