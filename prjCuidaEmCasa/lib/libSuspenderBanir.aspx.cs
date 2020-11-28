using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;
using System.Net.Mail;
using System.Net;

namespace prjCuidaEmCasa.lib
{
    public partial class libSuspenderBanir : System.Web.UI.Page
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
            #endregion

            string emailCuidador = Request["emailCuidador"].ToString();
            string control = Request["control"].ToString();

            #region CONTA REMETENTE
            string remetente = "3n2k20@gmail.com"; //tirar antes de dar commit
            string senha = "vencedordopovo123";    //tirar antes de dar commit
            #endregion

            #region Configuração do Remetente
            SmtpClient client = new SmtpClient();

            client.Credentials = new NetworkCredential(remetente, senha);
            #endregion

            #region Configuração do Servidor SMTP do GMAIL
            client.Host = "smtp.gmail.com";
            client.Port = 587;
            client.EnableSsl = true;
            #endregion

            clsAdministrador adm = new clsAdministrador();
            MailMessage mandarEmail = new MailMessage();

            if (control == "0")
            {
                if (!(adm.suspenderCuidador(emailCuidador)))
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
                    if (!(adm.removerSuspensao(emailCuidador)))
                    {
                        Response.Write("false");
                        return;
                    }

                    mandarEmail.To.Add(emailCuidador);
                    mandarEmail.From = new MailAddress(remetente, "Contato Cuida Em Casa", System.Text.Encoding.UTF8);
                    mandarEmail.Subject = "Remoção de Suspensão";
                    mandarEmail.SubjectEncoding = System.Text.Encoding.UTF8;

                    string conteudo = "<html><body>A sua suspensão foi retirada, agora você está apto para exercer a sua cuidadoria em nosso aplicativo";
                    conteudo += "</body></html>";

                    mandarEmail.Body = conteudo;
                    mandarEmail.BodyEncoding = System.Text.Encoding.UTF8;
                    mandarEmail.IsBodyHtml = true;
                    mandarEmail.Priority = MailPriority.High;

                    try
                    {
                        client.Send(mandarEmail);
                    }
                    catch (Exception)
                    {
                        Response.Write("erro");
                        return;
                    }

                    Response.Write("true");
                }
                else
                {
                    if (control == "2")
                    {
                        if (!(adm.banirCuidador(emailCuidador)))
                        {
                            Response.Write("false");
                            return;
                        }

                        Response.Write("true");
                    }
                    else
                    {
                        if (!(adm.desbanirCuidador(emailCuidador)))
                        {
                            Response.Write("false");
                        }

                        Response.Write("true");
                    }
                }
            }
        }
    }
}