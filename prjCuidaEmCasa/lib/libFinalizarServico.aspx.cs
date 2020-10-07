using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libFinalizarServico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsServico servico = new clsServico();

            #region Variáveis com dados para realização do agendamento
            servico.proxCodigo();
            string proxCodigo = servico.codigo; 
            
            string dtInicio = Request["dtInicioServico"].ToString();
            string hrInicio = Request["horaInicio"].ToString();
            string hrFim = Request["horaFim"].ToString();
            string cep = Request["cep"].ToString();
            string cidade = Request["cidade"].ToString();
            string bairro = Request["bairro"].ToString();
            string rua = Request["rua"].ToString();
            string num = Request["num"].ToString();
            string uf = Request["estado"].ToString();
            string comp = Request["comp"].ToString(); 
            string emailCliente = Request["cliente"].ToString();
            string emailCuidador = Request["cuidador"].ToString();
            string cdPaciente = Request["cdPaciente"].ToString();
            #endregion

            if (!(servico.finalizarServico(proxCodigo, dtInicio, hrInicio, hrFim, cep, cidade, bairro, rua, num, uf, comp, emailCliente, emailCuidador, cdPaciente, false)))
            {
                Response.Write("false");
            }

            Response.Write("true");
        }
    }
}