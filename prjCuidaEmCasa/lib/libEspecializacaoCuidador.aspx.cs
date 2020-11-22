using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libEspecializacaoCuidador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsCuidador classeCuidador = new clsCuidador();

            if (!classeCuidador.listarEspecializacaoCuidador())
            {
                Response.Write("erro");
                return;
            }
            else 
            {
                string listaEspecializacao = "";

                for (int i = 0; i < classeCuidador.cdEspecializacaoCuidador.Count; i++)
                {
                    listaEspecializacao += "<option id='opt" + classeCuidador.nomeEspecializacaoCuidador[i] + "' value='" + classeCuidador.cdEspecializacaoCuidador[i] + "'>" + classeCuidador.nomeEspecializacaoCuidador[i] + "</option>";
                }

                Response.Write(listaEspecializacao);
            }

        }
    }
}