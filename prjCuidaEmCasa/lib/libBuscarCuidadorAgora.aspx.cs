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

            if (Request["indice"] == null)
            {
                Response.Write("erro");
            }

            if (Request["indice"].ToString() == "")
            {
                Response.Write("erro");
            }
            #endregion

            string usuario = Request["usuario"].ToString();
            string indice = Request["indice"].ToString();
            int indiceFor = int.Parse(indice);

            clsServico servico = new clsServico();

            if (!(servico.codigoServicoAgora()))
            {
                Response.Write("false");
            }

            List<string> cdServico = new List<string>();
            string codigosQueJaForam = Request["cdUsado"].ToString();
            List<string> valorMaximo = new List<string>();

            cdServico.Add(servico.codigoAgora[indiceFor].ToString());
            valorMaximo.Add(servico.vl_maximo[indiceFor].ToString());
            //valorMaximo[indiceFor] = valorMaximo[indiceFor].Replace(",", ".");

            servico.detalhesServicoAgora(cdServico[indiceFor]);

            if (!(servico.buscarCuidadorAgora(valorMaximo[indiceFor])))
            {
                Response.Write("false");
                return;
            }

            string dadosCuidadorAgora = "";

            if (codigosQueJaForam != cdServico[indiceFor])
            {
                for (int j = 0; j < servico.emailCuidadorAgora.Count; j++)
                {
                    if (servico.emailCuidadorAgora[j] == usuario)
                    {
                        dadosCuidadorAgora += "<h3 class='tituloServicoEncontrado'>Serviço Encontrado</h3>";
                        dadosCuidadorAgora += "<h3 class='nomePacienteServicoEncontrado'>" + servico.nm_paciente[0] + "</h3>";
                        dadosCuidadorAgora += "<h3 class='areaInfoServicoEncontrado'>" + servico.duracaoServico[0] + "  de serviço</h3>";
                        dadosCuidadorAgora += "<button class='btnVerMaisServicoEncontrado' type='button'>Ver Mais</button>";
                        break;
                    }
                }
            }
                
            if (dadosCuidadorAgora == "")
            {
                Response.Write(dadosCuidadorAgora + "|" + cdServico[indiceFor]);
            }

            Response.Write(dadosCuidadorAgora + "|" + cdServico[indiceFor]);
        }
    }
}