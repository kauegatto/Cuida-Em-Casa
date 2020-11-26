using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libListarCuidadoresAdm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsAdministrador adm = new clsAdministrador();

            if (!(adm.listarTodosCuidadores()))
            {
                Response.Write("false");
                return;
            }

            string listaCuidadores = "";

            for (int i = 0; i < adm.nmEmailCuidador.Count; i++)
            {
                listaCuidadores += "<div class='areaCuidador' >";
                listaCuidadores += "<div class='areaImagemCuidador' style='background-image: url('img/imgCuidador1.jfif'); margin-top: 10px; margin-left: 16px;'></div>";
                listaCuidadores += "<a href='infoCuidadores.html'>";
                listaCuidadores += "<img src='../../img/icones/cuidador/iconeInformacao.png' class='iconeInformacao " + adm.nmEmailCuidador[i] + "'>";
                listaCuidadores += "<div class='areaInfoCuidador'>";
                listaCuidadores += "</a>";
                listaCuidadores += "<div class='areaNomeCuidador' style='width: 375px;'>";
                listaCuidadores += "<h3 class='nomeCuidador'>" + adm.nomeCuidador[i] + "</h3>";
                listaCuidadores += "</div>";
                listaCuidadores += "<div class='hora' style='width: 375px;'>";
                listaCuidadores += "<img src='../../img/icones/cuidador/iconeCifrao.png' class='iconeCifrao'>";
                listaCuidadores += "<span style='margin-left: 9px;'>" + adm.vlHora[i] + " / Hora</span>";
                listaCuidadores += "</div>";
                listaCuidadores += "<div class='areaEspecializacao' style='width: 375px;'>";
                listaCuidadores += "<img src='../../img/icones/agenda/iconeMaleta.png'>";
                listaCuidadores += "<span class='especializacao'>" + adm.especiazalicaoCuidador[i] + "</span>";
                listaCuidadores += "</div>";
                listaCuidadores += "<div class='areaSituacao' style='width: 375px;'>";
                if (adm.situacaoUsuario[i] == "Contratado")
                {
                    listaCuidadores += "<span style='margin-left: 2px'  class='status'> Status: </span><span class='statusAtivo'>" + adm.situacaoUsuario[i] + "</span>";
                }
                if (adm.situacaoUsuario[i] == "Em análise")
                {
                    listaCuidadores += "<span style='margin-left: 2px'  class='status'> Status: </span><span class='statusSuspenso'>" + adm.situacaoUsuario[i] + "</span>";
                }
                if (adm.situacaoUsuario[i] == "Em advertência")
                {
                    listaCuidadores += "<span style='margin-left: 2px'  class='status'> Status: </span><span class='statusSuspenso'>" + adm.situacaoUsuario[i] + "</span>";
                }
                if (adm.situacaoUsuario[i] == "Demitido")
                {
                    listaCuidadores += "<span style='margin-left: 2px'  class='status'> Status: </span><span class='statusBanido'>" + adm.situacaoUsuario[i] + "</span>";
                }
                listaCuidadores += "</div>";
                listaCuidadores += "</div>";
                listaCuidadores += "</div>";
            }

            Response.Write(listaCuidadores);
        }
    }
}