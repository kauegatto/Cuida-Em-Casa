using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

namespace prjCuidaEmCasa.lib
{
    public partial class libContratarCuidador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Validação
            if (Request["control"] == null)
            {
                Response.Write("false");
                return;
            }

            if (Request["control"].ToString() == "")
            {
                Response.Write("false");
                return;
            }

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

            string control = Request["control"].ToString();
            string emailCuidador = Request["emailCuidador"];

            clsAdministrador adm = new clsAdministrador();

            if (control == "0")
            {
                if (!(adm.contratarCuidador(emailCuidador)))
                {
                    Response.Write("false");
                    return;
                }

                Response.Write("true");
            }
            else
            {
                if (control == "1")
                {
                    if (!(adm.recusarCuidador(emailCuidador)))
                    {
                        Response.Write("false");
                        return;
                    }

                    Response.Write("true");
                }
                else
                {
                    if (!(adm.listarCuidadoresContrato()))
                    {
                        Response.Write("false");
                        return;
                    }

                    string listaCuidadoresContrato = "";

                    for (int i = 0; i < adm.nomeCuidador.Count; i++)
                    {
                        listaCuidadoresContrato += "<div class='areaCuidador' >";
                        listaCuidadoresContrato += "<div class='areaImagemCuidador' style='background-image: url('img/imgCuidador1.jfif'); margin-top: 10px; margin-left: 16px;'></div>";
                        listaCuidadoresContrato += "<a href='infoCuidadorContrato.html'>";
                        listaCuidadoresContrato += "<img src='../../img/icones/cuidador/iconeInformacao.png' class='iconeInformacao " + adm.nmEmailCuidador[i] + "'>";
                        listaCuidadoresContrato += "<div class='areaInfoCuidador'>";
                        listaCuidadoresContrato += "</a>";
                        listaCuidadoresContrato += "<div class='areaNomeCuidador' style='width: 375px;'>";
                        listaCuidadoresContrato += "<h3 class='nomeCuidador'>" + adm.nomeCuidador[i] + "</h3>";
                        listaCuidadoresContrato += "</div>";
                        listaCuidadoresContrato += "<div class='hora' style='width: 375px;'>";
                        listaCuidadoresContrato += "<img src='../../img/icones/cuidador/iconeCifrao.png' class='iconeCifrao'>";
                        listaCuidadoresContrato += "<span style='margin-left: 9px;'>" + adm.vlHora[i] + " / Hora</span>";
                        listaCuidadoresContrato += "</div>";
                        listaCuidadoresContrato += "<div class='valorHora' style='width: 375px;'>";
                        listaCuidadoresContrato += "<img src='../../img/icones/agenda/iconeMaleta.png'>";
                        listaCuidadoresContrato += "<span class='especializacao'>" + adm.especiazalicaoCuidador[i] + "</span>";
                        listaCuidadoresContrato += "</div>";
                        listaCuidadoresContrato += "</div>";
                        listaCuidadoresContrato += "<div class='areaBotao'>";
                        listaCuidadoresContrato += "<button class='btnAceitar " + adm.nmEmailCuidador[i] + "' type='submit'>Contratar</button>";
                        listaCuidadoresContrato += "<button class='btnRejeitar " + adm.nmEmailCuidador[i] + "' type='submit'>Rejeitar</button>";
                        listaCuidadoresContrato += "</div>";
                        listaCuidadoresContrato += "</div>";
                    }

                    Response.Write(listaCuidadoresContrato);
                }
            }
        }
    }
}