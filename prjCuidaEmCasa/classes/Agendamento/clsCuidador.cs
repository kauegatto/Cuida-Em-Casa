using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace prjCuidaEmCasa.classes.Agendamento
{
    public class clsCuidador : clsBanco_32623
    {
        public List<string> base64String { get; set; }
        public string base64standard { get; set; }
        public List<string> nm_cuidador { get; set; }
        public List<string> vl_cuidador { get; set; }
        public List<string> nm_especializacao { get; set; }
        public List<string> nm_email_cuidador { get; set; }
        public List<string> nm_genero { get; set; }
        public List<string> ds_usuario { get; set; }
        public List<string> ds_experiencia { get; set; }
        public List<string> cd_avaliacao { get; set; }
        public string nm_email_cuidador_selecionado { get; set; }
        public clsCuidador()
            : base()
        {
            base64String = new List<string>();
            base64standard = "";
            nm_cuidador = new List<string>();
            vl_cuidador = new List<string>();
            nm_especializacao = new List<string>();
            nm_email_cuidador = new List<string>();
            nm_genero = new List<string>();
            ds_usuario = new List<string>();
            ds_experiencia = new List<string>();
            cd_avaliacao = new List<string>();
            nm_email_cuidador_selecionado = "";
        }

        #region Listar Cuidadores

        public bool listarCuidadores(string dataServico, string horaInicio, string horaFim, bool virarDia)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[3, 2];
            valores[0, 0] = "vDataServico";
            valores[0, 1] = dataServico;
            valores[1, 0] = "vHoraInicio";
            valores[1, 1] = horaInicio;
            valores[2, 0] = "vHoraFim";
            valores[2, 1] = horaFim;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";        
            
            //vira o dia

            if (virarDia)
            {
                if (!Procedure("buscarCuidadoresVirarDia", true, valores, ref dados))
                {
                    Desconectar();
                    return false;
                }

                if (dados.HasRows)
                {
                    while (dados.Read())
                    {
                        nm_email_cuidador.Add(dados[0].ToString());
                        if (!Convert.IsDBNull(dados[1]))
                        {
                            byte[] imagem = (byte[])dados[1];

                            base64String.Add(Convert.ToBase64String(imagem, 0, imagem.Length));
                        }
                        else { base64String.Add(base64standard); }
                        nm_cuidador.Add(dados[2].ToString());
                        vl_cuidador.Add(dados[3].ToString());
                        cd_avaliacao.Add(dados[4].ToString());
                        nm_especializacao.Add(dados[5].ToString());
                    }

                    if (!dados.IsClosed) { dados.Close(); }
                    Desconectar();
                }
            }

            // nao vira o dia
            else
            {
                if (!Procedure("buscarCuidadores", true, valores, ref dados))
                {
                    Desconectar();
                    return false;
                }

                if (dados.HasRows)
                {
                    while (dados.Read())
                    {
                        nm_email_cuidador.Add(dados[0].ToString());
                        if (!Convert.IsDBNull(dados[1]))
                        {
                            byte[] imagem = (byte[])dados[1];

                            base64String.Add(Convert.ToBase64String(imagem, 0, imagem.Length));
                        }
                        else { base64String.Add(base64standard); }
                        nm_cuidador.Add(dados[2].ToString());
                        vl_cuidador.Add(dados[3].ToString());
                        cd_avaliacao.Add(dados[4].ToString());
                        nm_especializacao.Add(dados[5].ToString());
                    }

                    if (!dados.IsClosed) { dados.Close(); }
                    Desconectar();
                }
            }

            return true;
        }

        #endregion
        #region Buscar Cuidador
        public bool BuscarCuidador(string emailCuidador)
        {
            string base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";   
       
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = emailCuidador;
          
            if (!Procedure("cuidadorEscolhido", true, valores, ref dados))
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
                    else
                    {
                        base64String.Add(base64standard);
                        vl_cuidador.Add(dados[1].ToString());
                        nm_cuidador.Add(dados[2].ToString());
                        nm_especializacao.Add(dados[3].ToString());
                        nm_genero.Add(dados[4].ToString());
                        ds_experiencia.Add(dados[5].ToString());
                        ds_usuario.Add(dados[6].ToString());
                    }
                }
                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
                return true;
            }
            return false;
        #endregion
        }
    }
}