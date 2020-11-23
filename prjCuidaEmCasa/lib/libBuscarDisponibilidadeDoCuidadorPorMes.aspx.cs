using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libBuscarDisponibilidadeDoCuidadorPorMes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação do Request -> usuario logado
            if (Request["usuarioLogado"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["usuarioLogado"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string emailCuidador = Request["usuarioLogado"].ToString();
            #endregion
            #region Validação do Request -> numero do mes
            if (Request["intMes"] == null)
            {
                Response.Write("erro");
                return;
            }

            if (Request["intMes"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string intMes = Request["intMes"].ToString();
            #endregion

            clsCuidador classeCuidador = new clsCuidador();

            if (!classeCuidador.buscarDisponibilidadesMes(emailCuidador, intMes))
            {
                Response.Write("erro");
                return;
            }

            string listaAgendaCliente = "";

            for (int i = 0; i < classeCuidador.dt_disponibilidade.Count; i++)
            {
                listaAgendaCliente += "[" + classeCuidador.dt_disponibilidade[i] + "," + classeCuidador.hr_inicio_disponibilidade[i] + "," + classeCuidador.hr_fim_disponibilidade[i] + "]|";
            }

            Response.Write(listaAgendaCliente);

        }
    }
}