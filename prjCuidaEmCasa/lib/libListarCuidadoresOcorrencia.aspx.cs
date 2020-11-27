using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libListarCuidadoresOcorrencia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsAdministrador adm = new clsAdministrador();

            if (!(adm.listarCuidadoresOcorrencia()))
	        {
		        Response.Write("false");
                return;
	        }

            string cuidadoresOcorrencia = "";

            for (int i = 0; i < adm.nomeCuidador.Count; i++)
			{
			    cuidadoresOcorrencia += "<div class='areaCuidador'>";
                cuidadoresOcorrencia += "<div class='areaImagemCuidador' style='background-image: url('img/imgCuidador1.jfif'); margin-top: 10px; margin-left: 16px;'></div>";
                cuidadoresOcorrencia += "<a href='ocorrenciaCuidador.html'>";
                cuidadoresOcorrencia += "<img src='../../img/icones/cuidador/iconeInformacao.png' class='iconeInformacao " + adm.nmEmailCuidador[i] + "'>";
                cuidadoresOcorrencia += "<div class='areaInfoCuidador'>";
                cuidadoresOcorrencia += "</a>";
                cuidadoresOcorrencia += "<h3 class='nomeCuidador' style='width:400px'>" + adm.nomeCuidador[i] + "</h3>";					
                cuidadoresOcorrencia += "<div class='hora'>";
                cuidadoresOcorrencia += "<img src='../../img/icones/cuidador/iconeCifrao.png' class='iconeCifrao'>";
                cuidadoresOcorrencia += "<span style='margin-left: 9px;'>" + adm.vlHora[i] + " / Hora</span>";
                cuidadoresOcorrencia += "</div>";
                cuidadoresOcorrencia += "<img src='../../img/icones/agenda/iconeMaleta.png'>";
                cuidadoresOcorrencia += "<span class='especializacao'>" + adm.especiazalicaoCuidador[i] + "</span>";	
                cuidadoresOcorrencia += "<div class='denuncia'>";
                cuidadoresOcorrencia += "<img src='../../img/icones/cuidador/iconeDenuncia.png'>";
                if (adm.qtdOcorrenciaCuidadores[i] == "1")
	            {
		            cuidadoresOcorrencia += "<span class='especializacao'>" + adm.qtdOcorrenciaCuidadores[i] + " denúncia</span>";	
	            }
                else
	            {
                    cuidadoresOcorrencia += "<span class='especializacao'>" + adm.qtdOcorrenciaCuidadores[i] + " denúncias</span>";	
	            }
                cuidadoresOcorrencia += "</div>";
                cuidadoresOcorrencia += "</div>";
                cuidadoresOcorrencia += "</div>";
                cuidadoresOcorrencia += "</div>";
			}

            Response.Write(cuidadoresOcorrencia);
        }
    }
}