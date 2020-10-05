using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libDadosAgendamento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
              #region verificacao
            if (Request["d"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["d"] == "")
            {
                Response.Write("erro");
                return;
            }

            if (Request["hi"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["hi"] == "")
            {
                Response.Write("erro");
                return;
            }

            if (Request["hf"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["hf"] == "")
            {
                Response.Write("erro");
                return;
            }
#endregion
             //d: localStorage.getItem("data"), hi: localStorage.getItem("horaInicio"), qt: localStorage.getItem("qtdHoras") 
            string dataInicio = Request["d"].ToString();
            string horaInicio = Request["hi"].ToString();
            string horaFim = Request["hf"].ToString();
            string qtdHoras = Request["qtd"].ToString();

            Session["dataInicio"] = dataInicio ;
            Session["horaInicio"] = horaInicio;
            Session["horaFim"] = horaFim ;
            Session["qtdHoras"] = qtdHoras;

            string[] dataSeparada = dataInicio.Split('-');

            string[] horaSeparadaInicio = horaInicio.Split(':');

            string[] horaSeparadaFim = horaFim.Split(':');

            var dataI = new DateTime(int.Parse(dataSeparada[0]), int.Parse(dataSeparada[1]), int.Parse(dataSeparada[2]), int.Parse(horaSeparadaInicio[0]), int.Parse(horaSeparadaInicio[1]), 00);
            var dataF = new DateTime(int.Parse(dataSeparada[0]), int.Parse(dataSeparada[1]), int.Parse(dataSeparada[2]), int.Parse(horaSeparadaFim[0]), int.Parse(horaSeparadaFim[1]), 00);

            if (DateTime.Compare(dataF, dataI) < 0)
            {

                var dataInicioSoma = new DateTime(int.Parse(dataSeparada[0]), int.Parse(dataSeparada[1]), int.Parse(dataSeparada[2]));

                dataInicioSoma = dataInicioSoma.AddDays(1);

                Response.Write(dataInicioSoma.Day + "/" + dataInicioSoma.Month);
            }
            else 
            {
                Response.Write(dataI.Day + "/" + dataI.Month);
            }

          
            
            

            //clsCuidador cuidador = new clsCuidador();

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

            //Response.Write(listaCuidadores);
            //return;
            
        }
        
    }
}