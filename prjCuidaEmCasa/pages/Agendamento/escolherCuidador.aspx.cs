using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.pages.Agendamento
{
    public partial class escolherCuidador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //Response.Cache.SetCacheability(HttpCacheability.NoCache);

            //clsCuidador cuidador = new clsCuidador();

            //string dataInicio = (string)Session["dataInicio"];
            //string horaInicio = (string)Session["horaInicio"];
            //string horaFim = (string)Session["horaFim"];

            //if (!cuidador.listarCuidadores(dataInicio, horaInicio, horaFim, false))
            //{
            //    return;
            //}
            //string listaCuidadores = "";


            //for (int i = 0; i < cuidador.nm_cuidador.Count; i++)
            //{
            //    listaCuidadores += "<div class='areaCuidador " + cuidador.nm_email_cuidador[i] + "'>";
            //    listaCuidadores += "<div class='areaImagemCuidador'></div>";
            //    listaCuidadores += "<div class='areaInfoCuidador'>";
            //    listaCuidadores += "<h3>" + cuidador.nm_cuidador[i] + "</h3>";

            //    #region colocarestrela
            //    listaCuidadores += "<div class='avaliacao'>";

            //    double qtEstrelas = 00.00;
            //    if (double.TryParse(cuidador.cd_avaliacao[i], out qtEstrelas))
            //    {

            //        for (int j = 0; j < qtEstrelas - 1; qtEstrelas--)
            //        {
            //            listaCuidadores += "<img src='../../img/icones/cuidador/estrela.png' class='iconeEstrela'>";
            //        }

            //        if (qtEstrelas != 0 && qtEstrelas > 0)
            //        {
            //            if (qtEstrelas == 0.5)
            //            {
            //                listaCuidadores += "<img src='../../img/icones/cuidador/meiaestrela.png' class='iconeEstrela'>";
            //            }
            //        }
            //    }

            //    listaCuidadores += "</div>";
            //    #endregion

            //    listaCuidadores += "<div class='hora'>";
            //    listaCuidadores += "<img src='../../img/icones/cuidador/iconeCifrao.png' class='iconeCifrao'>";
            //    listaCuidadores += "<span style='margin-left: 9px;'>" + cuidador.vl_cuidador[i] + " / Hora</span>";
            //    listaCuidadores += "</div>";
            //    listaCuidadores += "<div class='especializacao'>";
            //    listaCuidadores += "<img src='../../img/icones/cuidador/iconeMaleta.png' class='iconeMaleta'>";
            //    listaCuidadores += "<span>" + cuidador.nm_especializacao[i] + "</span>";
            //    listaCuidadores += "</div>";
              

            //    listaCuidadores += "</div>";
            //    listaCuidadores += "<div class='invi' style='display: none'>" + cuidador.base64String[i] + "</div>";
            //    listaCuidadores += "</div>";
            //}

            //litCuidadores.Text = listaCuidadores;
        }
    }
}