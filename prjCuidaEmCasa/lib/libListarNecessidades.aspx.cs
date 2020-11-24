using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libListarNecessidades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsPaciente classePaciente = new clsPaciente();

            if (!classePaciente.listarNecessidades())
            {
                Response.Write("erro");
            }

            string listaNecessidade = "";

            for (int i = 0; i < classePaciente.cdTipoNecessidade.Count; i++)
            {
                listaNecessidade += "<option value='" + classePaciente.cdTipoNecessidade[i] + "'>" + classePaciente.nmTipoNecessidade[i] + "</option> -->";
            }


            Response.Write(listaNecessidade);

        }
    }
}