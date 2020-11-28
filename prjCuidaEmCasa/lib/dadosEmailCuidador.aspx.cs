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

            string emailCuidadorSelecionado = Request["e"].ToString();

            clsCuidador classeCuidador = new clsCuidador();

            if (!classeCuidador.BuscarCuidador(emailCuidadorSelecionado))
            {
                Response.Write("false");
                return;
            }

            clsServico classeServico = new clsServico();

            if (!classeServico.listarAvaliacao(emailCuidadorSelecionado))
            {
                Response.Write("erro");
                return;
            }

            double contadorAvaliacao = 0;

            for (int i = 0; i < classeServico.cd_avaliacaoNota.Count; i++)
            {
                contadorAvaliacao += double.Parse(classeServico.cd_avaliacaoNota[i]);
            }

            double qtEstrelas = 0;

            qtEstrelas = contadorAvaliacao / classeServico.cd_avaliacaoNota.Count;

            double notaAvaliacao = qtEstrelas;

            string imagemEstrela = "";

            for (int j = 0; j <= qtEstrelas - 1; qtEstrelas--)
            {
                imagemEstrela += "<img src='../../img/icones/cuidador/estrela.png' class='iconeEstrela'>";
            }

            if (qtEstrelas != 0 && qtEstrelas > 0)
            {
                if (qtEstrelas >= 0.5 && qtEstrelas < 1)
                {
                    imagemEstrela += "<img src='../../img/icones/cuidador/meiaestrela.png' class='iconeEstrela'>";
                }
            }
            

            string dadosCuidador = "";

            dadosCuidador += classeCuidador.vl_cuidador[0] + "|";
            dadosCuidador += classeCuidador.nm_cuidador[0] + "|";
            dadosCuidador += classeCuidador.nm_especializacao[0] + "|";
            dadosCuidador += classeCuidador.nm_genero[0] + "|";
            dadosCuidador += classeCuidador.ds_experiencia[0] + "|";
            dadosCuidador += classeCuidador.ds_usuario[0] + "|";
            dadosCuidador += classeCuidador.base64String[0] + "|";
            dadosCuidador += classeCuidador.cpfCuidador[0] + "|";
            dadosCuidador += classeCuidador.telefoneCuidador[0] + "|";
            dadosCuidador += classeCuidador.linkCurriculo[0] + "|";
            dadosCuidador += imagemEstrela + "|";
            dadosCuidador += notaAvaliacao + "|";
            dadosCuidador = dadosCuidador.Substring(0, dadosCuidador.Length - 1);
            Response.Write(dadosCuidador);
        }
    }
}
    
