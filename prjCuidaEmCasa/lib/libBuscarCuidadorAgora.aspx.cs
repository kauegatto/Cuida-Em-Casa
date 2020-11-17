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

        string dadosCuidadorAgora = "";

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
            #endregion

            string usuario = Request["usuario"].ToString();

            clsServico servico = new clsServico();

            if (!(servico.codigoServicoAgora()))
            {
                Response.Write(dadosCuidadorAgora);
            }

            for (int i = 0; i < servico.codigoAgora.Count; i++)
            {
                List<string> cdServico = new List<string>();
                Session["inicio"] = "0";
                List<string> valorMaximo = new List<string>();

                cdServico.Add(servico.codigoAgora[i].ToString());
                valorMaximo.Add(servico.vl_maximo[i].ToString());

                servico.detalhesServicoAgora(cdServico[i]);

                if (!(servico.buscarCuidadorAgora(valorMaximo[i])))
                {
                    Response.Write("false");
                    return;
                }

                if (Session["inicio"].ToString() == "0")
                {
                    Session["codigosQueJaForam"] = cdServico[i];
                    for (int j = 0; j < servico.emailCuidadorAgora.Count; j++)
                    {
                        if (servico.emailCuidadorAgora[j] == usuario)
                        {
                            dadosCuidadorAgora += "<h3 class='tituloServicoEncontrado'>Serviço Encontrado</h3>";
                            dadosCuidadorAgora += "<h3 class='nomePacienteServicoEncontrado'>" + servico.nm_paciente[0] + "</h3>";
                            dadosCuidadorAgora += "<h3 class='areaInfoServicoEncontrado'>" + servico.duracaoServico[0] + "  de serviço</h3>";
                            dadosCuidadorAgora += "<button class='btnVerMaisServicoEncontrado' type='button'>Ver Mais</button>";
                            i = servico.codigoAgora.Count;
                            break;
                        }
                    }
                }
                else
                {
                    int codigo = int.Parse(Session["codigosQueJaForam"].ToString());
                    int codigoServico = int.Parse(cdServico[i].ToString());

                    if (Session["codigosQueJaForam"].ToString() != cdServico[i] && codigo > codigoServico )
                    {
                        for (int j = 0; j < servico.emailCuidadorAgora.Count; j++)
                        {
                            if (servico.emailCuidadorAgora[j] == usuario)
                            {
                                dadosCuidadorAgora += "<h3 class='tituloServicoEncontrado'>Serviço Encontrado</h3>";
                                dadosCuidadorAgora += "<h3 class='nomePacienteServicoEncontrado'>" + servico.nm_paciente[0] + "</h3>";
                                dadosCuidadorAgora += "<h3 class='areaInfoServicoEncontrado'>" + servico.duracaoServico[0] + "  de serviço</h3>";
                                dadosCuidadorAgora += "<button class='btnVerMaisServicoEncontrado' type='button'>Ver Mais</button>";
                                i = servico.codigoAgora.Count;
                                break;
                            }
                        }
                    }
                }   
            }

            if (dadosCuidadorAgora == "")
            {
                Response.Write(dadosCuidadorAgora);
            }

            Response.Write(dadosCuidadorAgora);
        }
    }
}