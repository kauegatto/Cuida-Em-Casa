using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace prjCuidaEmCasa.classes
{
    public class clsAdministrador: clsBanco_32623
    {
        public List<string> base64String { get; set; }
        public string base64standard { get; set; }
        public List<string> nomeCuidador { get; set; }
        public List<string> vlHora { get; set; }
        public List<string> especiazalicaoCuidador { get; set; }
        public List<string> nmEmailCuidador { get; set; }
        public List<string> generoCuidador { get; set; }
        public List<string> cpfCuidador { get; set; }
        public List<string> telCuidador { get; set; }
        public List<string> dsUsuario { get; set; }
        public List<string> linkCurriculo { get; set; }
        public List<string> situacaoUsuario { get; set; }
        public string qtdOcorrencias { get; set; }
        public string qtdAdvertencias { get; set; }
        public List<string> dtInicioServico { get; set; }
        public List<string> dtFimServico { get; set; }
        public List<string> hrInicioServico { get; set; }
        public List<string> hrFimServico { get; set; }
        public List<string> duracaoServico { get; set; }
        public List<string> statusServico { get; set; }
        public List<string> emailCliente { get; set; }
        

        public clsAdministrador(): base()
        {
            base64String = new List<string>();
            base64standard = "";
            nomeCuidador = new List<string>();
            vlHora = new List<string>();
            especiazalicaoCuidador = new List<string>();
            nmEmailCuidador = new List<string>();
            generoCuidador = new List<string>();
            cpfCuidador = new List<string>();
            telCuidador = new List<string>();
            dsUsuario = new List<string>();
            linkCurriculo = new List<string>();
            situacaoUsuario = new List<string>();
            qtdOcorrencias = "";
            qtdAdvertencias = "";
            dtInicioServico = new List<string>();
            dtFimServico = new List<string>();
            hrInicioServico = new List<string>();
            hrFimServico = new List<string>();
            duracaoServico = new List<string>();
            statusServico = new List<string>();
            emailCliente = new List<string>();
        }

        #region Listar cuidadores para cadastro
        public bool listarCuidadoresContrato()
        {
            MySqlDataReader dados = null;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            if (!Procedure("listarCuidadoresContrato", false, null, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    if (!Convert.IsDBNull(dados[0]))
                    {
                        byte[] imagem = (byte[])dados[0];

                        base64String.Add(Convert.ToBase64String(imagem, 0, imagem.Length));
                    }
                    else { base64String.Add(base64standard); }
                    nomeCuidador.Add(dados[1].ToString());
                    vlHora.Add(dados[2].ToString());
                    especiazalicaoCuidador.Add(dados[3].ToString());
                    nmEmailCuidador.Add(dados[4].ToString());
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
            }

            return true;
        }
        #endregion

        #region Informações do cuidador selecionado no contrato pelo adm
        public bool infoCuidadorContrato(string emailCuidador)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = emailCuidador;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            if (!Procedure("infoCuidadorContrato", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    if (!Convert.IsDBNull(dados[0]))
                    {
                        byte[] imagem = (byte[])dados[0];

                        base64String.Add(Convert.ToBase64String(imagem, 0, imagem.Length));
                    }
                    else { base64String.Add(base64standard); }
                    nomeCuidador.Add(dados[1].ToString());
                    generoCuidador.Add(dados[2].ToString());
                    cpfCuidador.Add(dados[3].ToString());
                    telCuidador.Add(dados[4].ToString());
                    nmEmailCuidador.Add(dados[5].ToString());
                    dsUsuario.Add(dados[6].ToString());
                    especiazalicaoCuidador.Add(dados[7].ToString());
                    vlHora.Add(dados[8].ToString());
                    linkCurriculo.Add(dados[9].ToString());
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
            }

            return true;
        }
        #endregion

        #region Contratar cuidador
        public bool contratarCuidador(string emailCuidador)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = emailCuidador;

            if (!Procedure("contratarCuidador", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true; 
        }
        #endregion

        #region Recusar cuidador
        public bool recusarCuidador(string emailCuidador)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = emailCuidador;

            if (!Procedure("recusarCuidador", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true;
        }
        #endregion

        #region Listar todos os cuidadores
        public bool listarTodosCuidadores()
        {
            MySqlDataReader dados = null;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            if (!Procedure("listarCuidadores", false, null, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    if (!Convert.IsDBNull(dados[0]))
                    {
                        byte[] imagem = (byte[])dados[0];

                        base64String.Add(Convert.ToBase64String(imagem, 0, imagem.Length));
                    }
                    else { base64String.Add(base64standard); }
                    nomeCuidador.Add(dados[1].ToString());
                    vlHora.Add(dados[2].ToString());
                    especiazalicaoCuidador.Add(dados[3].ToString());
                    situacaoUsuario.Add(dados[4].ToString());
                    nmEmailCuidador.Add(dados[5].ToString());
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
            }

            return true;
        }
        #endregion

        #region Listar quantidade de ocorrências do cuidador
        public bool listarQuantidadeOcorrencias(string emailCuidador)
        { 
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = emailCuidador;

            if (!Procedure("listarOcorrencia", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    qtdOcorrencias = dados[0].ToString();
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
            }

            return true;
        }
        #endregion

        #region Listar quantidade de advertências do cuidador
        public bool listarQuantidadeAdvertencias(string emailCuidador)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = emailCuidador;

            if (!Procedure("listarAdvertencia", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    qtdAdvertencias = dados[0].ToString();
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
            }

            return true;
        }
        #endregion

        #region Listar todos os serviços do cuidador
        public bool listarServicosCuidador(string emailCuidador)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = emailCuidador;

            if (!Procedure("infoServicoCuidador", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    emailCliente.Add(dados[0].ToString());
                    dtInicioServico.Add(dados[1].ToString());
                    dtFimServico.Add(dados[2].ToString());
                    hrInicioServico.Add(dados[3].ToString());
                    hrFimServico.Add(dados[4].ToString());
                    duracaoServico.Add(dados[5].ToString());
                    vlHora.Add(dados[6].ToString());
                    statusServico.Add(dados[7].ToString());
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
            }

            return true;
        }
        #endregion
    }
}