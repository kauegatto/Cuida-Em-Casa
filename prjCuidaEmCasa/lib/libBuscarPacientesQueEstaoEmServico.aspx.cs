using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libBuscarPacientesQueEstaoEmServico : System.Web.UI.Page
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

            if (!paciente.buscarPacientesQueEstaoEmServico(usuarioLogado))
            {
                Response.Write("erro erro ");
                return;
            }

            var listaPacienteServico = new List<string>();

            for (int i = 0; i < paciente.cd_paciente.Count; i++)
            {
                listaPacienteServico.Add(paciente.cd_paciente[i]);
            }


            clsPaciente classePaciente = new clsPaciente();

            if (!classePaciente.buscarPacientes(usuarioLogado))
            {
                return;
            }

            string listaPacientes = "";

            for (int i = 0; i < classePaciente.nm_paciente.Count; i++)
            {
                if (!listaPacienteServico.Contains(classePaciente.cd_paciente[i]))
                {
                    listaPacientes += "<div class='areaPaciente " + classePaciente.cd_paciente[i] + "'>";
                    listaPacientes += "<div class='areaImagemPaciente' style='margin-left: 5px;'></div>";
                    listaPacientes += "<h3 class='nomePaciente'>" + classePaciente.nm_paciente[i] + "</h3>";
                    listaPacientes += "<span class='enderecoPaciente'>" + classePaciente.nm_cidade[i] + " - " + classePaciente.nm_estado[i] + "</span>";
                    listaPacientes += "<div class='invi' style='display: none'>" + classePaciente.base64String[i] + "</div>";
                    listaPacientes += "</div>";
                }
            }
            if (classePaciente.cd_paciente.Count == 0)
            {
                Response.Write("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Você não tem pacientes cadastrados!</h2>");
            }
            else
            {
                if (listaPacientes == "")
                {
                    
                    Response.Write("<h2 style='font-family: Rubik;text-align:center;margin:60px auto;width:80%'>Todos seus pacientes cadastrados estão em serviço</h2>");
                }
                else
                {
                    Response.Write(listaPacientes);
                }
            }
        }
    }
}