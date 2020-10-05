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
    public partial class confirmarEndereco : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Request["cdPaciente"] == null)
            //{
            //    Response.Write("erro");
            //    return;
            //}

            //if (Request["cdPaciente"].ToString() == "")
            //{
            //    Response.Write("erro");
            //    return;
            //}

            //string codigoPacienteSelecionada = Request["cdPaciente"].ToString();

            //clsPaciente paciente = new clsPaciente();

            //if (!paciente.confirmarEndereco(codigoPacienteSelecionada))
            //{
            //    Response.Write("erro");
            //    return;
            //}

            //litRua.Text = paciente.nm_rua;
            //litNum.Text = paciente.nm_num;
            //litComplemento.Text = paciente.nm_complemento;
            //litCidade.Text = paciente.nm_cidade[0];
            //litEstado.Text = paciente.nm_estado[0];
        }
    }
}