﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libPacientesEmServico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Verificação
            if (Request["usuarioLogado"] != null)
            {
                if (Request["usuarioLogado"].ToString() == "")
                {
                    Response.Write("usuarioIncorreto");
                    return;
                }
            }
            else
            {
                Response.Write("usuarioIncorreto");
                return;
            }
            #endregion

            clsPaciente paciente = new clsPaciente();

            string usuarioLogado = Request["usuarioLogado"].ToString();

            if (!paciente.buscarPacientesEmServico(usuarioLogado))
            {
                return;
            }

            string listaPacientes = "";

            for (int i = 0; i < paciente.cd_servico.Count; i++)
            {
                listaPacientes += "<div class='areaPaciente " + paciente.cd_servico[i] + "'>";
                listaPacientes += "<div class='areaImagemPaciente'></div>";
                listaPacientes += "<h3 class='nomePaciente'>" + paciente.nm_paciente[i] + "</h3>";
                listaPacientes += "<span class='enderecoPaciente'>" + paciente.nm_cidade[i] + " - " + paciente.nm_estado[i] + "</span>";
                listaPacientes += "<div class='invi' style='display: none'>" + paciente.base64String[i] + "</div>";
                listaPacientes += "</div>";
            }

            Response.Write(listaPacientes);
        }
    }
}