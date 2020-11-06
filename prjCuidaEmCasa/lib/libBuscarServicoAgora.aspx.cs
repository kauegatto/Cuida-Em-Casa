using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjCuidaEmCasa.lib
{
    public partial class libBuscarServicoAgora : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region verificacao
            if (Request["du"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["du"] == "")
            {
                Response.Write("erro");
                return;
            }

            if (Request["ha"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["ha"] == "")
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

            if (Request["da"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["da"] == "")
            {
                Response.Write("erro");
                return;
            }
            #endregion

            string dataInicio = Request["da"].ToString();
            string horaInicio = Request["ha"].ToString();
            string horaFim = Request["hf"].ToString();
            string qtdHoras = Request["du"].ToString();

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
        }
    }
}