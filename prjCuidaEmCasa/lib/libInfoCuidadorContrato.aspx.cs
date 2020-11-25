using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libInfoCuidadorContrato : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["emailCuidador"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["emailCuidador"].ToString() == "")
            {
                Response.Write("false");
                return;
            }
            #endregion

            string emailCuidador = Request["emailCuidador"].ToString();

            clsAdministrador adm = new clsAdministrador();

            if (!(adm.infoCuidadorContrato(emailCuidador)))
            {
                Response.Write("false");
                return;
            }

            string dadosCuidador = "";

            dadosCuidador += "<div class='areaImagemCuidador' style='background-image: url('img/imgCuidador1.jfif'); margin-top: 10px; margin-left: 16px;'></div>";
			dadosCuidador += "<div class='areaNomeCuidador'>";
			dadosCuidador += "<h3 class='nomeCuidador'>" + adm.nmEmailCuidador[0] + "</h3>";			
	 		dadosCuidador += "</div>";	
			dadosCuidador += "</div>";
			dadosCuidador += "<div class='tituloConteudo'><span>Informações Básicas</span></div>";
			dadosCuidador += "<div class='areaInfoCuidador'>";
			dadosCuidador += "<div class='areaInfoBasicas'>";
			dadosCuidador += "<span>Gênero:</span>";
		    dadosCuidador += "<span class='generoCuidador' style='color: gray'>" + adm.generoCuidador[0] + "</span>";
		    dadosCuidador += "<span style='margin-left: 20px'>Telefone:</span>";
		    dadosCuidador += "<span class='telefoneCuidador' style='color: gray'>" + adm.telCuidador[0] + "</span>";
		    dadosCuidador += "<span style='margin-left: 20px'>CPF:</span>";
		    dadosCuidador += "<span class='cpfCuidador' style='color: gray'>" + adm.cpfCuidador[0] + "</span>";
		    dadosCuidador += "<span>Email:</span><span class='emailCuidador' style='color: gray'>" + adm.nmEmailCuidador[0] + "</span>"; 
		    dadosCuidador += "<br/>";
		    dadosCuidador += "<span>Descrição:</span>";
		    dadosCuidador += "<span class='descricaoCuidador' style='color: gray'>" + adm.dsUsuario[0] + "</span>";
	        dadosCuidador += "</div>";
			dadosCuidador += "</div>";	
			dadosCuidador += "<div class='tituloConteudo'><span>Informações de Trabalho</span></div>";
			dadosCuidador += "<div class='areaInfoCuidador'>";
			dadosCuidador += "<div class='areaInfoTrabalho'>";
			dadosCuidador += "<span>Especialização:</span>";
    		dadosCuidador += "<span class='especializacaoCuidador' style='color: gray'>" + adm.especiazalicaoCuidador[0] + "</span>";
			dadosCuidador += "<br/>";
			dadosCuidador += "<span>Valor Hora:</span>";
    		dadosCuidador += "<span class='valorHoraCuidador' style='color: gray'>R$ " + adm.vlHora[0] + "</span>";
			dadosCuidador += "<br/>";
			dadosCuidador += "<span>Link Currículo:</span>";
			dadosCuidador += "<span class='curriculoCuidador' style='color: gray'>" + adm.linkCurriculo[0] + "</span>";
			dadosCuidador += "</div>";
			dadosCuidador += "</div>";
            dadosCuidador += "</div>";
            dadosCuidador += "</div>";

            Response.Write(dadosCuidador);
        }
    }
}