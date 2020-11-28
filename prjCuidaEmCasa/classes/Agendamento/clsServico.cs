﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace prjCuidaEmCasa.classes.Agendamento
{
    public class clsServico : clsBanco_32623
    {
        
        public string codigo { get; set; }
        /* Propriedade para o histórico do cuidador */
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

        /* Propriedades para o servico de agora */

        public List<string> nm_cuidador { get; set; }
        public List<string> vl_cuidador { get; set; }
        public List<string> base64String { get; set; }
        public string base64standard { get; set; }
        public List<string> nm_especializacao { get; set; }
        public List<string> situacaoServico { get; set; }
        public List<string> diferencaData { get; set; }
        public List<string> cd_avaliacao { get; set; }
        public List<string> nm_genero { get; set; }
        public List<string> ds_cuidador { get; set; }
        public List<string> emailCuidador { get; set; }
        public List<string> vl_maximo { get; set; }
        public List<string> codigoAgora { get; set; }
        public List<string> emailCuidadorAgora { get; set; }
        public List<string> cd_avaliacaoNota { get; set; } 
        public string diaDaSemana { get; set; }
        public string cd_geolocalizao { get; set; }
        public string hr_checkin { get; set; }

        public clsServico(): base() 
        {
            codigo = "";
            /* Propriedade para o histórico do cuidador */
            nm_paciente = new List<string>();
            nm_rua_servico = new List<string>();
            cd_servico = new List<string>();
            nm_tipo_necessidade_paciente = new List<string>();
            dt_inicio_servico = new List<string>();
            hr_inicio_servico = new List<string>();
            hr_fim_servico = new List<string>();
            duracaoServico = new List<string>();
            cd_avaliacaoNota = new List<string>();
            nm_necessidade = "";
            ds_paciente = "";
            cd_CEP_servico = "";
            nm_cidade_servico = "";
            nm_uf_servico = "";
            nm_bairro_servico = "";
            nm_num_servico = "";
            nm_comp_servico = "";
            emailCuidadorAgora = new List<string>();

           /* Propriedades para o servico de agora */

            base64String = new List<string>();
            base64standard = "";
            vl_cuidador = new List<string>();
            nm_cuidador = new List<string>();
            nm_especializacao = new List<string>();
            situacaoServico = new List<string>();
            diferencaData = new List<string>();
            cd_avaliacao = new List<string>();
            nm_genero = new List<string>();
            ds_cuidador = new List<string>();
            emailCuidador = new List<string>();
            vl_maximo = new List<string>();
            codigoAgora = new List<string>();
            diaDaSemana = "";
            cd_geolocalizao = "";
            hr_checkin = "";
        }

        #region Próximo código
        public bool proxCodigo()
        { 
            MySqlDataReader dados = null;
            
            if (!Procedure("proxCodigo", false, null, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    codigo = dados[0].ToString();
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
            }

            return true;
        }
        #endregion

        #region Finalizar serviço
        public bool finalizarServico(string cdServico, string dataServico, string horaInicio, string horaFim, string CEP, string cidade, string bairro, string rua, string num, string UF, string comp, string emailCliente, string emailCuidador, string cdPaciente, bool virarDia)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[14, 2];
            valores[0, 0] = "vCodigo";
            valores[0, 1] = cdServico;
            valores[1, 0] = "vDataServico";
            valores[1, 1] = dataServico;
            valores[2, 0] = "vHoraInicioServico";
            valores[2, 1] = horaInicio;
            valores[3, 0] = "vHoraFimServico";
            valores[3, 1] = horaFim;
            valores[4, 0] = "vCEP";
            valores[4, 1] = CEP;
            valores[5, 0] = "vCidade";
            valores[5, 1] = cidade;
            valores[6, 0] = "vBairro";
            valores[6, 1] = bairro;
            valores[7, 0] = "vRua";
            valores[7, 1] = rua;
            valores[8, 0] = "vNum";
            valores[8, 1] = num;
            valores[9, 0] = "vUF";
            valores[9, 1] = UF;
            valores[10, 0] = "vComp";
            valores[10, 1] = comp;
            valores[11, 0] = "vEmailCliente";
            valores[11, 1] = emailCliente;
            valores[12, 0] = "vEmailCuidador";
            valores[12, 1] = emailCuidador;
            valores[13, 0] = "vCodigoPaciente";
            valores[13, 1] = cdPaciente;

            //Não vira dia 

            if (!virarDia)
            {
                if (!Procedure("agendarServico", true, valores, ref dados))
                {
                    Desconectar();
                    return false;
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();

                return true; 
            }

            //Vira dia 
            else
            {
                if (!Procedure("agendarServicoVirarDia", true, valores, ref dados))
                {
                    Desconectar();
                    return false;
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();

                return true;
            }
            
        }
        #endregion

        #region Finalizar serviço agora
        public bool finalizarServicoAgora(string cdServico, string dataServico, string horaInicio, string horaFim, string CEP, string cidade, string bairro, string rua, string num, string UF, string comp, string emailCliente, string cdPaciente, string vlMaximo, bool virarDia)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[14, 2];
            valores[0, 0] = "vCodigo";
            valores[0, 1] = cdServico;
            valores[1, 0] = "vDataServico";
            valores[1, 1] = dataServico;
            valores[2, 0] = "vHoraInicioServico";
            valores[2, 1] = horaInicio;
            valores[3, 0] = "vHoraFimServico";
            valores[3, 1] = horaFim;
            valores[4, 0] = "vCEP";
            valores[4, 1] = CEP;
            valores[5, 0] = "vCidade";
            valores[5, 1] = cidade;
            valores[6, 0] = "vBairro";
            valores[6, 1] = bairro;
            valores[7, 0] = "vRua";
            valores[7, 1] = rua;
            valores[8, 0] = "vNum";
            valores[8, 1] = num;
            valores[9, 0] = "vUF";
            valores[9, 1] = UF;
            valores[10, 0] = "vComp";
            valores[10, 1] = comp;
            valores[11, 0] = "vEmailCliente";
            valores[11, 1] = emailCliente;
            valores[12, 0] = "vCodigoPaciente";
            valores[12, 1] = cdPaciente;
            valores[13, 0] = "vValorMaximo";
            valores[13, 1] = vlMaximo;

            //Não vira dia 

            if (!virarDia)
            {
                if (!Procedure("agendarServicoAgora", true, valores, ref dados))
                {
                    Desconectar();
                    return false;
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();


                return true;
            }

            //Vira dia 
            else
            {
                if (!Procedure("agendarServicoAgoraVirarDia", true, valores, ref dados))
                {
                    Desconectar();
                    return false;
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();

                return true;
            }

        }
        #endregion

        #region Buscar cuidador agora
        public bool buscarCuidadorAgora(string valorMaximo)
        {
            valorMaximo = valorMaximo.Replace(",", ".");
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vValorHora";
            valores[0, 1] = valorMaximo;

            if (!Procedure("buscarCuidadoresAgora", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    emailCuidadorAgora.Add(dados[0].ToString());
                }
                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
                return true;
            }
            return false;
        }
        #endregion

        #region Código do servico para agora
        public bool codigoServicoAgora()
        {
            MySqlDataReader dados = null;

            if (!Procedure("servicoParaAgora", false, null, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    codigoAgora.Add(dados[0].ToString());
                    vl_maximo.Add(dados[1].ToString());
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
            }

            return true;
        }
        #endregion

        #region Detalhes serviço
        public bool detalhesServicoHistoricoCuidador(string cdServico)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vCodigoServico";
            valores[0, 1] = cdServico;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            if (!Procedure("servicoSelecionado", true, valores, ref dados))
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
                    nm_necessidade = dados[2].ToString();
                    ds_paciente = dados[3].ToString();
                    cd_CEP_servico = dados[4].ToString();
                    nm_cidade_servico = dados[5].ToString();
                    nm_uf_servico = dados[6].ToString();
                    nm_bairro_servico = dados[7].ToString();
                    nm_rua_servico.Add(dados[8].ToString());
                    nm_num_servico = dados[9].ToString();
                    if (dados[10].ToString() != null)
                    {
                        nm_comp_servico = dados[10].ToString();
                    }
                    hr_inicio_servico.Add(dados[11].ToString());
                    hr_fim_servico.Add(dados[12].ToString());
                    dt_inicio_servico.Add(dados[13].ToString());
                    vl_cuidador.Add(dados[14].ToString());
                    duracaoServico.Add(dados[15].ToString());
                    situacaoServico.Add(dados[16].ToString());
                }
                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
                return true;
            }
            return false;
        }
        #endregion

        #region Detalhes serviço agora
        public bool detalhesServicoAgora(string cdServico)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vCodigoServico";
            valores[0, 1] = cdServico;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
            
            if (!Procedure("servicoSelecionadoAgora", true, valores, ref dados))
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
                    nm_necessidade = dados[2].ToString();
                    ds_paciente = dados[3].ToString();
                    cd_CEP_servico = dados[4].ToString();
                    nm_cidade_servico = dados[5].ToString();
                    nm_uf_servico = dados[6].ToString();
                    nm_bairro_servico = dados[7].ToString();
                    nm_rua_servico.Add(dados[8].ToString());
                    nm_num_servico = dados[9].ToString();
                    if (dados[10].ToString() != null)
                    {
                        nm_comp_servico = dados[10].ToString();
                    }
                    hr_inicio_servico.Add(dados[11].ToString());
                    hr_fim_servico.Add(dados[12].ToString());
                    dt_inicio_servico.Add(dados[13].ToString());
                    duracaoServico.Add(dados[14].ToString());
                }
                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
                return true;
            }
            return false;
        }
        #endregion

        #region Verificar se tem serviço
        public bool verificarDisponibilidade(string emailCuidador)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = emailCuidador;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            if (!Procedure("verificarDisponibilidade", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    cd_servico.Add(dados[0].ToString());
                    if (!Convert.IsDBNull(dados[1]))
                    {
                        byte[] imagem = (byte[])dados[1];

                        base64String.Add(Convert.ToBase64String(imagem, 0, imagem.Length));
                    }
                    else { base64String.Add(base64standard); }
                    nm_paciente.Add(dados[2].ToString());
                    nm_necessidade = dados[3].ToString();
                    nm_rua_servico.Add(dados[4].ToString());
                    nm_num_servico = dados[5].ToString();
                    if (dados[6].ToString() != null)
                    {
                        nm_comp_servico = dados[6].ToString();
                    }
                    dt_inicio_servico.Add(dados[7].ToString());
                    diaDaSemana = dados[8].ToString();
                    hr_inicio_servico.Add(dados[9].ToString());
                    hr_fim_servico.Add(dados[10].ToString());
                    cd_geolocalizao = dados[11].ToString();
                    vl_cuidador.Add(dados[12].ToString());
                    duracaoServico.Add(dados[13].ToString());
                    hr_checkin = dados[14].ToString();
                }
                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
                return true;
            }
            return false;
        }
        #endregion

        #region Info serviço agora dia da semana
        public bool infoServicoAtual(string cdServico)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vCodigoServico";
            valores[0, 1] = cdServico;
            //base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
            base64standard = "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";
            
            if (!Procedure("infoServicoAtualCuidador", true, valores, ref dados))
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
                    nm_necessidade = dados[2].ToString();
                    nm_rua_servico.Add(dados[3].ToString());
                    nm_num_servico = dados[4].ToString();
                    if (dados[5].ToString() != null)
                    {
                        nm_comp_servico = dados[5].ToString();
                    }
                    dt_inicio_servico.Add(dados[6].ToString());
                    diaDaSemana = dados[7].ToString();
                    hr_inicio_servico.Add(dados[8].ToString());
                    hr_fim_servico.Add(dados[9].ToString());
                    cd_geolocalizao = dados[10].ToString();
                    vl_cuidador.Add(dados[11].ToString());
                    duracaoServico.Add(dados[12].ToString());
                    nm_bairro_servico = dados[13].ToString();
                    nm_cidade_servico = dados[14].ToString();
                    nm_uf_servico = dados[15].ToString();
                    
                }
                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
                return true;
            }
            return false;
        }
        #endregion

        #region Aceitar servico agora
        public bool aceitarServico(string cdServico, string emailCuidador)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[2, 2];
            valores[0, 0] = "vCodigo";
            valores[0, 1] = cdServico;
            valores[1, 0] = "vEmailCuidador";
            valores[1, 1] = emailCuidador;

            if (!Procedure("aceitarServicoAgora", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true; 
        }
        #endregion

        #region Marcar check-in
        public bool checkin(string cdServico)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vServico";
            valores[0, 1] = cdServico;

            if (!Procedure("marcarCheckin", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true; 
        }
        #endregion

        #region Marcar checkout
        public bool checkout(string cdServico)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vServico";
            valores[0, 1] = cdServico;

            if (!Procedure("marcarCheckout", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true;
        }
        #endregion

        #region Agenda do cliente
        public bool listarAgendaCliente(string emailCliente, bool jaFoi)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailCliente";
            valores[0, 1] = emailCliente;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
            if (jaFoi)
            {
                if (!Procedure("listarAgendaClienteJaFoi", true, valores, ref dados))
                {
                    Desconectar();
                    return false;
                }

                if (dados.HasRows)
                {
                    while (dados.Read())
                    {
                        dt_inicio_servico.Add(dados[0].ToString());
                        hr_inicio_servico.Add(dados[1].ToString());
                        hr_fim_servico.Add(dados[2].ToString());
                        if (!Convert.IsDBNull(dados[3]))
                        {
                            byte[] imagem = (byte[])dados[3];

                            base64String.Add(Convert.ToBase64String(imagem, 0, imagem.Length));
                        }
                        else { base64String.Add(base64standard); }
                        nm_cuidador.Add(dados[4].ToString());
                        nm_especializacao.Add(dados[5].ToString());
                        duracaoServico.Add(dados[6].ToString());
                        nm_paciente.Add(dados[7].ToString());
                        situacaoServico.Add(dados[8].ToString());
                        vl_cuidador.Add(dados[9].ToString());
                        cd_servico.Add(dados[10].ToString());
                    }
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();

                return true;
            }
            else {
                if (!Procedure("listarAgendaClienteNaoFoi", true, valores, ref dados))
                {
                    Desconectar();
                    return false;
                }

                if (dados.HasRows)
                {
                    while (dados.Read())
                    {
                        diferencaData.Add(dados[0].ToString());
                        nm_cuidador.Add(dados[1].ToString());
                        nm_especializacao.Add(dados[2].ToString());
                        dt_inicio_servico.Add(dados[3].ToString());
                        hr_inicio_servico.Add(dados[4].ToString());
                        hr_fim_servico.Add(dados[5].ToString());
                        nm_paciente.Add(dados[6].ToString());
                        situacaoServico.Add(dados[7].ToString());
                        vl_cuidador.Add(dados[8].ToString());
                        duracaoServico.Add(dados[9].ToString());
                        if (!Convert.IsDBNull(dados[10]))
                        {
                            byte[] imagem = (byte[])dados[10];

                            base64String.Add(Convert.ToBase64String(imagem, 0, imagem.Length));
                        }
                        else { base64String.Add(base64standard); }
                        cd_servico.Add(dados[11].ToString());
                    }
                }

                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();

                return true;
            }

        }
        #endregion

        #region Detalhe Histórico da Agenda do Cliente 

        public bool mostrarDadosHistorico(string codigoServico)
        { 
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vCodigoServico";
            valores[0, 1] = codigoServico;
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            if (!Procedure("listarAgendaClienteJaFoiSelecionado", true, valores, ref dados))
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
                    nm_cuidador.Add(dados[1].ToString());
                    cd_avaliacao.Add(dados[2].ToString());
                    nm_especializacao.Add(dados[3].ToString());
                    nm_genero.Add(dados[4].ToString());
                    ds_cuidador.Add(dados[5].ToString());
                    nm_rua_servico.Add(dados[6].ToString());
                    nm_num_servico = dados[7].ToString();
                    cd_CEP_servico = dados[8].ToString();
                    nm_comp_servico = dados[9].ToString();
                    nm_cidade_servico = dados[10].ToString();
                    nm_uf_servico = dados[11].ToString();
                    hr_inicio_servico.Add(dados[12].ToString());
                    hr_fim_servico.Add(dados[13].ToString());
                    duracaoServico.Add(dados[14].ToString());
                    vl_cuidador.Add(dados[15].ToString());
                    emailCuidador.Add(dados[16].ToString());
                }
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true;
  

        }

        #endregion

        #region Denunciar Serviço

        public bool denunciarServico(string emailCliente, string txtDenuncia, string cdServico, string cdTipoDenuncia) 
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[5, 2];

            if (!Procedure("proxCodigoOcorrencia", false, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    string codigoOcorrencia = dados[0].ToString();
                    valores[0, 1] = codigoOcorrencia;
                }
            }

            valores[0, 0] = "vCodigo";
            valores[1, 0] = "vDsOcorrencia";
            valores[1, 1] = txtDenuncia;
            valores[2, 0] = "vEmailUsuario";
            valores[2, 1] = emailCliente;
            valores[3, 0] = "vCodigoServico";
            valores[3, 1] = cdServico;
            valores[4, 0] = "vCodigoTipoOcorrencia";
            valores[4, 1] = cdTipoDenuncia;

            if (!Procedure("gerarOcorrencia", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true;

        }

        #endregion

        #region Detalhe Serviço Agendado 
        public bool mostrarDadosAgendados(string codigoServico)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vCodigoServico";
            valores[0, 1] = codigoServico;
            //base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";
            base64standard = "PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJ1c2VyLW51cnNlIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtdXNlci1udXJzZSBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTMxOS40MSwzMjAsMjI0LDQxNS4zOSwxMjguNTksMzIwQzU3LjEsMzIzLjEsMCwzODEuNiwwLDQ1My43OUE1OC4yMSw1OC4yMSwwLDAsMCw1OC4yMSw1MTJIMzg5Ljc5QTU4LjIxLDU4LjIxLDAsMCwwLDQ0OCw0NTMuNzlDNDQ4LDM4MS42LDM5MC45LDMyMy4xLDMxOS40MSwzMjBaTTIyNCwzMDRBMTI4LDEyOCwwLDAsMCwzNTIsMTc2VjY1LjgyYTMyLDMyLDAsMCwwLTIwLjc2LTMwTDI0Ni40Nyw0LjA3YTY0LDY0LDAsMCwwLTQ0Ljk0LDBMMTE2Ljc2LDM1Ljg2QTMyLDMyLDAsMCwwLDk2LDY1LjgyVjE3NkExMjgsMTI4LDAsMCwwLDIyNCwzMDRaTTE4NCw3MS42N2E1LDUsMCwwLDEsNS01aDIxLjY3VjQ1YTUsNSwwLDAsMSw1LTVoMTYuNjZhNSw1LDAsMCwxLDUsNVY2Ni42N0gyNTlhNSw1LDAsMCwxLDUsNVY4OC4zM2E1LDUsMCwwLDEtNSw1SDIzNy4zM1YxMTVhNSw1LDAsMCwxLTUsNUgyMTUuNjdhNSw1LDAsMCwxLTUtNVY5My4zM0gxODlhNSw1LDAsMCwxLTUtNVpNMTQ0LDE2MEgzMDR2MTZhODAsODAsMCwwLDEtMTYwLDBaIj48L3BhdGg+PC9zdmc+";

            if (!Procedure("listarAgendaClienteNaoFoiSelecionado", true, valores, ref dados))
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
                    nm_cuidador.Add(dados[1].ToString());
                    cd_avaliacao.Add(dados[2].ToString());
                    nm_especializacao.Add(dados[3].ToString());
                    nm_genero.Add(dados[4].ToString());
                    ds_cuidador.Add(dados[5].ToString());
                    nm_rua_servico.Add(dados[6].ToString());
                    nm_num_servico = dados[7].ToString();
                    cd_CEP_servico = dados[8].ToString();
                    nm_comp_servico = dados[9].ToString();
                    nm_cidade_servico = dados[10].ToString();
                    nm_uf_servico = dados[11].ToString();
                    hr_inicio_servico.Add(dados[12].ToString());
                    hr_fim_servico.Add(dados[13].ToString());
                    duracaoServico.Add(dados[14].ToString());
                    vl_cuidador.Add(dados[15].ToString());
                    situacaoServico.Add(dados[16].ToString());
                    emailCuidador.Add(dados[17].ToString());
                }
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true;


        }
        #endregion

        #region Avaliar o Serviço

        public bool avaliarServico(string emailUsuario, string codigoAvaliacao)
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[2, 2];
            valores[0, 0] = "vEmailUsuario";
            valores[0, 1] = emailUsuario;
            valores[1, 0] = "vCdAvaliacao";
            valores[1, 1] = codigoAvaliacao;

            if (!Procedure("avaliarServico",true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true;

        }


        #endregion

        #region confirmarPagamento
        public bool confirmarPagamento (string cdPedido) {

            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vCdServico";
            valores[0, 1] =  cdPedido;
            if (!Procedure("confirmarPedido", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();

            return true;
        
        }

        #endregion 
        
<<<<<<< HEAD
        #region Buscar disponibilidade do serviço
=======
        #region buscarDisponibilidadesServico
>>>>>>> 0b33290000e9ad2f8abce5a984099e922f887d24
        public bool buscarDisponibilidadesServico(string usuarioLogado, string intMes) {
            MySqlDataReader dados = null;
            string[,] valores = new string[2, 2];
            valores[0, 0] = "vEmailCuidador";
            valores[0, 1] = usuarioLogado;
            valores[1, 0] = "vMes";
            valores[1, 1] = intMes;

            if (!Procedure("buscarServicoAgendadoCuidadorMes", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    dt_inicio_servico.Add(dados[0].ToString());
                    cd_servico.Add(dados[1].ToString());
                    hr_inicio_servico.Add(dados[2].ToString());
                }
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();
            return true;
<<<<<<< HEAD
=======

        }
        #endregion

        #region Listar avaliacao

        public bool listarAvaliacao(string emailUsuario) 
        {
            MySqlDataReader dados = null;
            string[,] valores = new string[1, 2];
            valores[0, 0] = "vEmailUsuario";
            valores[0, 1] = emailUsuario;

            if (!Procedure("listarAvaliacoes", true, valores, ref dados))
            {
                Desconectar();
                return false;
            }

            if (dados.HasRows)
            {
                while (dados.Read())
                {
                    if (dados[0].ToString() != "")
                    {
                        cd_avaliacaoNota.Add(dados[0].ToString());
                    }

                }
            }

            if (!dados.IsClosed) { dados.Close(); }
            Desconectar();
            return true;
        }

        #endregion
>>>>>>> 0b33290000e9ad2f8abce5a984099e922f887d24

        }
        #endregion
    }
}