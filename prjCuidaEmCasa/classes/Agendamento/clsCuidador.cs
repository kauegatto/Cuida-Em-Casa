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

        /* Propriedades para o histórico do cuidador */

        public List<string> nm_paciente { get; set; }
        public List<string> nm_rua_servico { get; set; }
        public List<string> cd_servico { get; set; }
        public List<string> nm_tipo_necessidade_paciente { get; set; }
        public List<string> dt_inicio_servico { get; set; }
        public List<string> hr_inicio_servico { get; set; }
        public List<string> hr_fim_servico { get; set; }
        public List<string> duracaoServico { get; set; }
        public string nm_necessidade { get; set; }
        public string ds_paciente { get; set; }
        public string cd_CEP_servico { get; set; }
        public string nm_cidade_servico { get; set; }
        public string nm_uf_servico { get; set; }
        public string nm_bairro_servico { get; set; }
        public string nm_num_servico { get; set; }
        public string nm_comp_servico { get; set; }
        public List<string> cd_paciente { get; set; }

        public clsCuidador(): base()
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

            /* Propriedade para o histórico do cuidador */

            nm_paciente = new List<string>();
            nm_rua_servico = new List<string>();
            cd_servico = new List<string>();
            nm_tipo_necessidade_paciente = new List<string>();
            dt_inicio_servico = new List<string>();
            hr_inicio_servico = new List<string>();
            hr_fim_servico = new List<string>();
            duracaoServico = new List<string>();
            nm_necessidade = "";
            ds_paciente = "";
            cd_CEP_servico= "";
            nm_cidade_servico = "";
            nm_uf_servico = "";
            nm_bairro_servico = "";
            nm_num_servico = "";
            nm_comp_servico = "";
            cd_paciente = new List<string>();

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
        public bool listarCuidadoresFiltro(string dataServico, string horaInicio, string horaFim, string vE, string vP, string vA, string vG, string vEspecializacao, string vPreco, string vAvaliacao, string vGenero, bool virarDia)
        {
            #region antigo
            //MySqlDataReader dados = null;
            //string[,] valores = new string[11, 2];
            //valores[0, 0] = "vDataServico";
            //valores[0, 1] = dataServico;
            //valores[1, 0] = "vHoraInicio";
            //valores[1, 1] = horaInicio;
            //valores[2, 0] = "vHoraFim";
            //valores[2, 1] = horaFim; 
            //valores[3, 0] = "vE";
            //valores[3, 1] = vE;
            //valores[4, 0] = "vP";
            //valores[4, 1] = vP;
            //valores[5, 0] = "vA";
            //valores[5, 1] = vA;
            //valores[6, 0] = "vG";
            //valores[6, 1] = vG;
            //valores[7, 0] = "vEspecializacao";
            //valores[7, 1] = vEspecializacao;
            //valores[8, 0] = "vPreco";
            //valores[8, 1] = vPreco;
            //valores[9, 0] = "vAvaliacao";
            //valores[9, 1] = vAvaliacao; 
            //valores[10, 0] = "vGenero";
            //valores[10, 1] = vGenero;
            #endregion
            MySqlDataReader dados = null;
            string[,] valores = new string[11, 2];
            valores[0, 0] = "vDataServico";
            valores[0, 1] = dataServico;
            valores[1, 0] = "vHoraInicio";
            valores[1, 1] = horaInicio;
            valores[2, 0] = "vHoraFim";
            valores[2, 1] = horaFim;
            
            
            valores[3, 0] = "vE";

            if (vE == "false")
            {
                valores[3, 1] = "0";
            }
            else 
            {
                valores[3, 1] = "1";
            }
            valores[4, 0] = "vP";

            if (vP == "false")
            {
                valores[4, 1] = "0";
            }
            else
            {
                valores[4, 1] = "1";
            }

            valores[5, 0] = "vA";

            if (vA == "false")
            {
                valores[5, 1] = "0";
            }
            else
            {
                valores[5, 1] = "1";
            }
            valores[6, 0] = "vG";
            if (vG == "false")
            {
                valores[6, 1] = "0";
            }
            else
            {
                valores[6, 1] = "1";
            }
            valores[7, 0] = "vEspecializacao";
            valores[7, 1] = vEspecializacao;
            valores[8, 0] = "vPreco";
            valores[8, 1] = vPreco;
            valores[9, 0] = "vAvaliacao";
            valores[9, 1] = vAvaliacao;
            valores[10, 0] = "vGenero";
            valores[10, 1] = vGenero;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            //vira o dia

            if (virarDia)
            {
                if (!Procedure("filtrarCuidadoresVirarDia", true, valores, ref dados))
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
                if (!Procedure("filtrarCuidadores", true, valores, ref dados))
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
                    }
                    vl_cuidador.Add(dados[1].ToString());
                    nm_cuidador.Add(dados[2].ToString());
                    nm_especializacao.Add(dados[3].ToString());
                    nm_genero.Add(dados[4].ToString());
                    ds_experiencia.Add(dados[5].ToString());
                    ds_usuario.Add(dados[6].ToString());
                }
                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
                return true;
            }
            return false;
        }
        #endregion

        #region Histórico serviço antigos
        public bool historicoAntigo(string emailCuidador)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = emailCuidador;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";        

            if (!Procedure("listarServicosFinalizadosAntigos", true, valores, ref dados))
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
                    nm_paciente.Add(dados[1].ToString());
                    nm_rua_servico.Add(dados[2].ToString());
                    cd_servico.Add(dados[3].ToString());
                    nm_tipo_necessidade_paciente.Add(dados[4].ToString());
                    dt_inicio_servico.Add(dados[5].ToString());
                    hr_inicio_servico.Add(dados[6].ToString());
                    hr_fim_servico.Add(dados[7].ToString());
                    vl_cuidador.Add(dados[8].ToString());
                    duracaoServico.Add(dados[9].ToString());
                }
                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
                return true;
            }
            return false;
        }
        #endregion 

        #region Histórico serviço recentes
        public bool historicoRecente(string emailCuidador)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = emailCuidador;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            if (!Procedure("listarServicosFinalizadosRecentes", true, valores, ref dados))
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
                    nm_paciente.Add(dados[1].ToString());
                    nm_rua_servico.Add(dados[2].ToString());
                    cd_servico.Add(dados[3].ToString());
                    nm_tipo_necessidade_paciente.Add(dados[4].ToString());
                    dt_inicio_servico.Add(dados[5].ToString());
                    hr_inicio_servico.Add(dados[6].ToString());
                    hr_fim_servico.Add(dados[7].ToString());
                    vl_cuidador.Add(dados[8].ToString());
                    duracaoServico.Add(dados[9].ToString());
                    cd_paciente.Add(dados[10].ToString());
                }
                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
                return true;
            }
            return false;
        }
        #endregion 

        #region Histórico serviço filtrado por data
        public bool historicoData(string emailCuidador, string dataServico)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[2, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = emailCuidador;
            valores[1, 0] = "vDataServico";
            valores[1, 1] = dataServico;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            if (!Procedure("listarServicosFinalizadosData", true, valores, ref dados))
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
                    nm_paciente.Add(dados[1].ToString());
                    nm_rua_servico.Add(dados[2].ToString());
                    cd_servico.Add(dados[3].ToString());
                    nm_tipo_necessidade_paciente.Add(dados[4].ToString());
                    dt_inicio_servico.Add(dados[5].ToString());
                    hr_inicio_servico.Add(dados[6].ToString());
                    hr_fim_servico.Add(dados[7].ToString());
                    vl_cuidador.Add(dados[8].ToString());
                    duracaoServico.Add(dados[9].ToString());
                    cd_paciente.Add(dados[10].ToString());
                }
                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
                return true;
            }
            return false;
        }
        #endregion 
    }
}