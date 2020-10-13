using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libBuscarCuidador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //#region verificacao
            //if (Request["d"] == null)
            //{
            //    Response.Write("false");
            //    return;
            //}

            //if (Request["d"].ToString() == "")
            //{
            //    Response.Write("false");
            //    return;
            //}
            //if (Request["hi"] == null)
            //{
            //    Response.Write("false");
            //    return;
            //}

            //if (Request["hi"].ToString() == "")
            //{
            //    Response.Write("false");
            //    return;
            //}
            //if (Request["hf"] == null)
            //{
            //    Response.Write("false");
            //    return;
            //}

            //if (Request["hf"].ToString() == "")
            //{
            //    Response.Write("false");
            //    return;
            //}
            //if (Request["qtd"] == null)
            //{
            //    Response.Write("false");
            //    return;
            //}

            //if (Request["qtd"].ToString() == "")
            //{
            //    Response.Write("false");
            //    return;
            //}
            //#endregion

            #region pegar dataFim serviço
            string dataInicio = Request["d"].ToString();
            string horaInicio = Request["hi"].ToString();
            string horaFim = Request["hf"].ToString();
            bool virarDia = false;

            string[] dataSeparada = dataInicio.Split('-');

            string[] horaSeparadaInicio = horaInicio.Split(':');

            string[] horaSeparadaFim = horaFim.Split(':');

            var dataI = new DateTime(int.Parse(dataSeparada[0]), int.Parse(dataSeparada[1]), int.Parse(dataSeparada[2]), int.Parse(horaSeparadaInicio[0]), int.Parse(horaSeparadaInicio[1]), 00);
            var dataF = new DateTime(int.Parse(dataSeparada[0]), int.Parse(dataSeparada[1]), int.Parse(dataSeparada[2]), int.Parse(horaSeparadaFim[0]), int.Parse(horaSeparadaFim[1]), 00);

            if (DateTime.Compare(dataF, dataI) < 0)
            {
                var dataInicioSoma = new DateTime(int.Parse(dataSeparada[0]), int.Parse(dataSeparada[1]), int.Parse(dataSeparada[2]));
                dataInicioSoma = dataInicioSoma.AddDays(1);
                virarDia = true;
            }
            else {
                virarDia = false;
            }

            #endregion
            Session["virarDia"] = virarDia;

            clsCuidador classeCuidador = new clsCuidador();


            #region Busca com Filtro
            try
            {
                if (Request["filtro"] == "true")
                {
                    string vE, vP, vG, vA;
                    vE = Request["vE"]; vP = Request["vP"]; vG = Request["vG"]; vA = Request["vA"];

                    string vEspecializacao, vPreco, vAvaliacao, vGenero;
                    vEspecializacao = Request["vEspecializacao"];
                    vPreco = Request["vPreco"];
                    vAvaliacao = Request["vAvaliacao"];
                    vGenero = Request["vGenero"];
                    if (!classeCuidador.listarCuidadoresFiltro(dataInicio, horaInicio, horaFim, vE, vP, vA, vG, vEspecializacao, vPreco, vAvaliacao, vGenero, virarDia))
                    {
                        Response.Write("false");
                        return;
                    }
                }
            #endregion
            #region Busca Sem Filtro
                else
                {
                    if (!classeCuidador.listarCuidadores(dataInicio, horaInicio, horaFim, virarDia))
                    {
                        Response.Write("false");
                        return;
                    }
                }
            }
            catch {
                if (!classeCuidador.listarCuidadores(dataInicio, horaInicio, horaFim, virarDia))
                {
                    Response.Write("false");
                    return;
                }
            }
                #endregion


            string listaCuidadores = "";

            for (int i = 0; i < classeCuidador.nm_cuidador.Count; i++)
            {
                listaCuidadores += "<div class='areaCuidador " + classeCuidador.nm_email_cuidador[i] + "'>";
                listaCuidadores += "<div class='areaImagemCuidador'></div>";
                listaCuidadores += "<div class='areaInfoCuidador'>";
                listaCuidadores += "<h3>" + classeCuidador.nm_cuidador[i] + "</h3>";

                #region colocarestrela
                listaCuidadores += "<div class='avaliacao'>";

                double qtEstrelas = 00.00;
                if (double.TryParse(classeCuidador.cd_avaliacao[i], out qtEstrelas))
                {

                    for (int j = 0; j <= qtEstrelas - 1; qtEstrelas--)
                    {
                        listaCuidadores += "<img src='../../img/icones/cuidador/estrela.png' class='iconeEstrela'>";
                    }

                    if (qtEstrelas != 0 && qtEstrelas > 0)
                    {
                        if (qtEstrelas == 0.5)
                        {
                            listaCuidadores += "<img src='../../img/icones/cuidador/meiaestrela.png' class='iconeEstrela'>";
                        }
                    }
                }

                listaCuidadores += "</div>";
                #endregion

                listaCuidadores += "<div class='hora'>";
                listaCuidadores += "<img src='../../img/icones/cuidador/iconeCifrao.png' class='iconeCifrao' style='margin-left:0px !important'>";
                listaCuidadores += "<span style='margin-left: 9px;'>" + classeCuidador.vl_cuidador[i] + " / Hora</span>";
                listaCuidadores += "</div>";
                listaCuidadores += "<div class='especializacao'>";
                listaCuidadores += "<img src='../../img/icones/cuidador/iconeMaleta.png' class='iconeMaleta'>";
                listaCuidadores += "<span>" + classeCuidador.nm_especializacao[i] + "</span>";
                listaCuidadores += "</div>";


                listaCuidadores += "</div>";
                listaCuidadores += "<div class='invi' style='display: none'>" + classeCuidador.base64String[i] + "</div>";
                listaCuidadores += "</div>";
            }

            listaCuidadores += "|" + dataI.Day + "/" + dataI.Month;

            Response.Write(listaCuidadores);
        }
    }
}