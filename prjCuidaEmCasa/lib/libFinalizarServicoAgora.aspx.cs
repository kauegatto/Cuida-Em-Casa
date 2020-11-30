using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libFinalizarServicoAgora : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsServico servico = new clsServico();

            string controle = Request["control"].ToString();

            if (controle == "0")
            {
                string dataAtual = Request["diaAtual"].ToString();
                string horaAtual = Request["horaAtual"].ToString();
                string horaFinal = Request["horaFim"].ToString();

                string[] dataSeparada = dataAtual.Split('-');

                string[] horaSeparadaInicio = horaAtual.Split(':');

                string[] horaSeparadaFim = horaFinal.Split(':');

                var dataI = new DateTime(int.Parse(dataSeparada[0]), int.Parse(dataSeparada[1]), int.Parse(dataSeparada[2]), int.Parse(horaSeparadaInicio[0]), int.Parse(horaSeparadaInicio[1]), 00);
                var dataF = new DateTime(int.Parse(dataSeparada[0]), int.Parse(dataSeparada[1]), int.Parse(dataSeparada[2]), int.Parse(horaSeparadaFim[0]), int.Parse(horaSeparadaFim[1]), 00);

                if (DateTime.Compare(dataF, dataI) < 0)
                {

                    var dataInicioSoma = new DateTime(int.Parse(dataSeparada[0]), int.Parse(dataSeparada[1]), int.Parse(dataSeparada[2]));

                    dataInicioSoma = dataInicioSoma.AddDays(1);

                    Response.Write(dataInicioSoma.Year + "-" + dataInicioSoma.Month + "-" + dataInicioSoma.Day);
                }
                else
                {
                    Response.Write(dataI.Year + "-" + dataI.Month + "-" + dataI.Day);
                }
            }
            else
            {
                #region Variáveis com dados para realização do agendamento
                servico.proxCodigo();
                string proxCodigo = servico.codigo;

                string dataAtual = Request["diaAtual"].ToString();
                string dataFinal = Request["dataFinal"].ToString();
                string hrFim = Request["horaFim"].ToString();
                string cep = Request["cep"].ToString();
                string cidade = Request["cidade"].ToString();
                string bairro = Request["bairro"].ToString();
                string rua = Request["rua"].ToString();
                string num = Request["num"].ToString();
                string uf = Request["estado"].ToString();
                string comp = Request["comp"].ToString();
                string emailCliente = Request["cliente"].ToString();
                string cdPaciente = Request["cdPaciente"].ToString();
                string vlMaximo = Request["valorMaximo"].ToString();
                #endregion

                bool virarDia;

                if (dataFinal != dataAtual)
                {
                    virarDia = true;
                }
                else
                {
                    virarDia = false;
                }
                
                if (!(servico.finalizarServicoAgora(proxCodigo, hrFim, cep, cidade, bairro, rua, num, uf, comp, emailCliente, cdPaciente, vlMaximo, virarDia)))
                {
                    Response.Write("false | " + proxCodigo);
                }

                Response.Write("true | " + proxCodigo);
            }
           

            
        }
    }
}