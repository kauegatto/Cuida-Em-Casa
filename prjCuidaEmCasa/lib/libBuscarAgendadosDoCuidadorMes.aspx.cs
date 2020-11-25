using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libBuscarAgendadosDoCuidadorMes : System.Web.UI.Page
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

            clsServico classeServico = new clsServico();

            if (!classeServico.buscarDisponibilidadesServico(emailCuidador, intMes))
            {
                Response.Write("erro");
                return;
            }

            string listaAgendaCliente = "";

            for (int i = 0; i < classeServico.dt_inicio_servico.Count; i++)
            {
                listaAgendaCliente += "[" + classeServico.dt_inicio_servico[i] + "," + classeServico.cd_servico[i] + "]|";
            }
            if (listaAgendaCliente.Length != 0)
            {
                listaAgendaCliente = listaAgendaCliente.Substring(0, listaAgendaCliente.Length - 1);
            }
            Response.Write(listaAgendaCliente);
        }
    }
}