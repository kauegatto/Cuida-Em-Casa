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
        List<string> codigosQueJaForam = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["usuario"] == null)
            {
                Response.Write("erro");
            }

            if (Request["usuario"].ToString() == "")
            {
                Response.Write("erro");
            }

            if (Request["cdUsado"] == null)
            {
                Response.Write("erro");
            }

            if (Request["cdUsado"].ToString() == "")
            {
                Response.Write("erro");
            }
            #endregion

            string usuario = Request["usuario"].ToString();
            
            clsServico servico = new clsServico();

            if (!(servico.codigoServicoAgora()))
            {
                Response.Write("false");
            }

            List<string> cdServico = new List<string>();
            List<string> valorMaximo = new List<string>();
            codigosQueJaForam.Add(Request["cdUsado"].ToString());
            for (int i = 0; i < servico.codigoAgora.Count; i++)
            {
                cdServico.Add(servico.codigoAgora[i].ToString());
                valorMaximo.Add(servico.vl_maximo[i].ToString());
                valorMaximo[i] = valorMaximo[i].Replace(",", ".");
            
            servico.detalhesServicoAgora(cdServico[i]);

            if (!(servico.buscarCuidadorAgora(valorMaximo[i])))
            {
                Response.Write("false");
                return;
            }

            string dadosCuidadorAgora = "";
            for (int h = 0; h < codigosQueJaForam.Count; h++)
            {
                if (codigosQueJaForam[h] != cdServico[i])
                {
                    codigosQueJaForam.Add(cdServico[i]);
                    for (int j = 0; j < servico.emailCuidadorAgora.Count; j++)
                    {
                        if (servico.emailCuidadorAgora[j] == usuario)
                        {
                            dadosCuidadorAgora += "<h3 class='tituloServicoEncontrado'>Serviço Encontrado</h3>";
                            dadosCuidadorAgora += "<h3 class='nomePacienteServicoEncontrado'>" + servico.nm_paciente[0] + "</h3>";
                            dadosCuidadorAgora += "<h3 class='areaInfoServicoEncontrado'>" + servico.duracaoServico[0] + "  de serviço</h3>";
                            dadosCuidadorAgora += "<button class='btnVerMaisServicoEncontrado' type='button'>Ver Mais</button>";
                        }
                    }
                }
            }
            Response.Write(dadosCuidadorAgora + "|" + cdServico[i]);
            }
        }
    }
}