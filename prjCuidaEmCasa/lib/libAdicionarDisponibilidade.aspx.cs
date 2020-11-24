using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;
namespace prjCuidaEmCasa.lib
{
    public partial class libAdicionarDisponibilidade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region verificação de variáveis do post.
            #region Verificação de variáveis do post-> usuarioLogado
            if (Request["usuarioLogado"] == "" || Request["usuarioLogado"] == null) {
                Response.Write("false");
                return;
            }
            
            #endregion
            #region Verificação de variáveis do post-> dtInicioDisponibilidade
            if (Request["dtInicioDisponibilidade"] == "" || Request["dtInicioDisponibilidade"] == null)
            {
                Response.Write("false");
                return;
            }
            #endregion
            #region Verificação de variáveis do post-> hrInicioDisponibilidade
            if (Request["hrInicioDisponibilidade"] == "" || Request["hrInicioDisponibilidade"] == null)
            {
                Response.Write("false");
                return;
            }
            #endregion
            #region Verificação de variáveis do post-> hrFimDisponibilidade
            if (Request["hrFimDisponibilidade"] == "" || Request["hrFimDisponibilidade"] == null)
            {
                Response.Write("false");
                return;
            }
            #endregion
            #endregion
           
            #region definição de variáveis locais 
            string usuarioLogado = Request["usuarioLogado"];
            string dtInicioDisponibilidade = Request["dtInicioDisponibilidade"];
            string hrInicioDisponibilidade = Request["hrInicioDisponibilidade"];
            string hrFimDisponibilidade = Request["hrFimDisponibilidade"];

            #endregion 

            clsCuidador classeCuidador = new clsCuidador();
            if (classeCuidador.adicionarDisponibilidade(usuarioLogado, dtInicioDisponibilidade, hrInicioDisponibilidade, hrFimDisponibilidade))
            {
                Response.Write("true");
                return;
            }

            else {
                Response.Write("false");
                return;
            }
        }
    }
}