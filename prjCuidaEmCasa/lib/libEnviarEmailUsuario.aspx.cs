using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
using prjCuidaEmCasa.classes.Agendamento;

namespace prjCuidaEmCasa.lib
{
    public partial class libEnviarEmailUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            #region Validação do email no post
            if (Request["emailUsuario"] == null)
	        {
                Response.Write("erro");
                return;
	        }

            if (Request["emailUsuario"].ToString() == "")
            {
                Response.Write("erro");
                return;
            }

            string emailDestinatario = Request["emailUsuario"].ToString();

            #endregion

            #region classeUsuario

            clsUsuario classeUsuario = new clsUsuario();

            if (!classeUsuario.codigoRecuperarSenha(emailDestinatario))
            {
                Response.Write("erro");
                return;
            }

            #endregion

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

            #region Configuração do Email 

            MailMessage mandarEmail = new MailMessage();
            mandarEmail.To.Add(emailDestinatario);
            mandarEmail.From = new MailAddress(remetente, "Contato Via Cuida Em Casa", System.Text.Encoding.UTF8);
            mandarEmail.Subject = "Recuperação de Senha";
            mandarEmail.SubjectEncoding = System.Text.Encoding.UTF8;

            string conteudo = "<html><body>O código de recuperação é: " + classeUsuario.cdRecuperarSenha[0];
            conteudo += "</body></html>";

            mandarEmail.Body = conteudo;
            mandarEmail.BodyEncoding = System.Text.Encoding.UTF8;
            mandarEmail.IsBodyHtml = true;
            mandarEmail.Priority = MailPriority.High; 

            #endregion 

            #region Envio do Email

            try
            {
                client.Send(mandarEmail);
            }
            catch (Exception)
            {
                Response.Write("erro");
                return;
            }


            #endregion

        }
    }
}