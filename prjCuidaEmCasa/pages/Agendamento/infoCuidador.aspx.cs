using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;
using prjCuidaEmCasa.lib;
namespace prjCuidaEmCasa.pages.Agendamento
{
    public partial class infoCuidador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string emailCuidadorSelecionado = (string)Session["emailCuidador"];

            clsCuidador classeCuidador = new clsCuidador();


            if (!classeCuidador.BuscarCuidador(emailCuidadorSelecionado))
            {
                return;
            }

            string teste = classeCuidador.nm_cuidador[0];

            //clsCuidador classeCuidador = new clsCuidador();
            //string emailCuidadorSelecionado = (string)Session["emailCuidadorSelecionado"];

            //if (!classeCuidador.BuscarCuidador(emailCuidadorSelecionado))
            //{
            //    Response.Redirect("google.com");
            //    return;
            //}
            

           // = classeCuidador.vl_cuidador[0] ;
           // = classeCuidador.nm_cuidador[0] ;
           // = classeCuidador.nm_especializacao[0];
           // = classeCuidador.nm_genero[0] ;
            //nm_experiencia_cuidador += classeCuidador.ds_experiencia[0];
           // = classeCuidador.ds_usuario[0] ;
            //= dadosCuidador.Substring(0, dadosCuidador.Length - 1);
        }
    }
}