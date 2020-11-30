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
                string cdServico = "";
                string inicio = Request["indice"].ToString() ;
                string valorMaximo = "";

                cdServico = servico.codigoAgora[i].ToString();
                valorMaximo = servico.vl_maximo[i].ToString();
                servico.detalhesServicoAgora(cdServico);

                if (!(servico.buscarCuidadorAgora(valorMaximo)))
                {
                    Response.Write("false");
                    return;
                }

                if (inicio == "0")
                {
                    Session["codigosQueJaForam"] = cdServico;
                    for (int j = 0; j < servico.emailCuidadorAgora.Count; j++)
                    {
                        if (servico.emailCuidadorAgora[j] == usuario)
                        {
                            dadosCuidadorAgora += "<h3 class='tituloServicoEncontrado'>Serviço Encontrado</h3>";
                            dadosCuidadorAgora += "<h3 class='nomePacienteServicoEncontrado'>" + servico.nm_paciente[i] + "</h3>";
                            string duracao = servico.duracaoServico[0];
                            string[] duracaoSplit = duracao.Split(':');
                            if (int.Parse(duracaoSplit[0]) < 0)
                            {
                                int duracaoSomaHora = int.Parse(duracaoSplit[0]) + 24;
                                if (duracaoSomaHora.ToString().Length == 1)
                                {
                                    dadosCuidadorAgora += "<h3 class='areaInfoServicoEncontrado'>0" + duracaoSomaHora + ":" + duracaoSplit[1] + "  de serviço</h3>";
                                }
                                else
                                {
                                    dadosCuidadorAgora += "<h3 class='areaInfoServicoEncontrado'>" + duracaoSomaHora + ":" + duracaoSplit[1] + "  de serviço</h3>";
                                }
                            }
                            else
                            {
                                dadosCuidadorAgora += "<h3 class='areaInfoServicoEncontrado'>" + servico.duracaoServico[0] + "  de serviço</h3>";
                            }
                            dadosCuidadorAgora += "<button class='btnVerMaisServicoEncontrado " + cdServico + "' type='button'>Ver Mais</button>";
                            i = servico.codigoAgora.Count;
                            break;
                        }
                    }
                }
                else
                {
                    int codigo = int.Parse(Session["codigosQueJaForam"].ToString());
                    int codigoServico = int.Parse(cdServico.ToString());

                    if (Session["codigosQueJaForam"].ToString() != cdServico && codigoServico > codigo)
                    {
                        for (int j = 0; j < servico.emailCuidadorAgora.Count; j++)
                        {
                            if (servico.emailCuidadorAgora[j] == usuario)
                            {
                                dadosCuidadorAgora += "<h3 class='tituloServicoEncontrado' >Serviço Encontrado</h3>";
                                dadosCuidadorAgora += "<h3 class='nomePacienteServicoEncontrado'>" + servico.nm_paciente[i] + "</h3>";
                                string duracao = servico.duracaoServico[0];
                                string[] duracaoSplit = duracao.Split(':');
                                if (int.Parse(duracaoSplit[0]) < 0)
                                {
                                    int duracaoSomaHora = int.Parse(duracaoSplit[0]) + 24;
                                    if (duracaoSomaHora.ToString().Length == 1)
                                    {
                                        dadosCuidadorAgora += "<h3 class='areaInfoServicoEncontrado'>0" + duracaoSomaHora + ":" + duracaoSplit[1] + "  de serviço</h3>";
                                    }
                                    else
                                    {
                                        dadosCuidadorAgora += "<h3 class='areaInfoServicoEncontrado'>" + duracaoSomaHora + ":" + duracaoSplit[1] + "  de serviço</h3>";
                                    }
                                }
                                else
                                {
                                    dadosCuidadorAgora += "<h3 class='areaInfoServicoEncontrado'>" + servico.duracaoServico[0] + "  de serviço</h3>";
                                }
                                dadosCuidadorAgora += "<button class='btnVerMaisServicoEncontrado " + cdServico + "' type='button'>Ver Mais</button>";
                                i = servico.codigoAgora.Count;
                                Session["codigosQueJaForam"] = cdServico;
                                break;
                            }
                        }
                    }
                    else
                    {
                        dadosCuidadorAgora = "";
                    }
                }   
            }

            Response.Write(dadosCuidadorAgora);
        }
    }
}