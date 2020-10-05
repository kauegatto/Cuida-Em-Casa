using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class dadosEmailCuidador : System.Web.UI.Page
    {
       protected void Page_Load(object sender, EventArgs e)
        {
            #region verificacao
            if (Request["e"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["e"].ToString() == "")
            {
                Response.Write("false");
                return;
            }
            #endregion
            #region implementar dps
           // string emailCuidadorSelecionado = Request["e"].ToString();
           // Session["emailCuidadorSelecionado"] = emailCuidadorSelecionado;
           // clsCuidador classeCuidador = new clsCuidador();

           // if (!classeCuidador.BuscarCuidador(emailCuidadorSelecionado))
           // {
           //     Response.Write("false");
           //     return;
           // }
           // string dadosCuidador = "";

           // dadosCuidador += classeCuidador.vl_cuidador[0] + "/";
           // dadosCuidador += classeCuidador.nm_cuidador[0] + "/";
           // dadosCuidador += classeCuidador.nm_especializacao[0] + "/";
           // dadosCuidador += classeCuidador.nm_genero[0] + "/";
           // dadosCuidador += classeCuidador.ds_experiencia[0] + "/";
           // dadosCuidador += classeCuidador.ds_usuario[0] + "/";
           // dadosCuidador = dadosCuidador.Substring(0, dadosCuidador.Length - 1);
           //Response.Write("teste/teste/teste/testeeeeekkkkk/");
            #endregion
          
            string emailCuidadorSelecionado = Request["e"].ToString();

            Session["emailCuidador"] = emailCuidadorSelecionado;

            clsCuidador classeCuidador = new clsCuidador();

            if (!classeCuidador.BuscarCuidador(emailCuidadorSelecionado))
            {
                Response.Write("false");
                return;
            }

            string dadosCuidador = "";

            dadosCuidador += classeCuidador.vl_cuidador[0] + "/";
            dadosCuidador += classeCuidador.nm_cuidador[0] + "/";
            dadosCuidador += classeCuidador.nm_especializacao[0] + "/";
            dadosCuidador += classeCuidador.nm_genero[0] + "/";
            dadosCuidador += classeCuidador.ds_experiencia[0] + "/";
            dadosCuidador += classeCuidador.ds_usuario[0] + "/";
            dadosCuidador = dadosCuidador.Substring(0, dadosCuidador.Length - 1);
            Response.Write(dadosCuidador);
        }
    }
}
    
