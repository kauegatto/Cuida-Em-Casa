using System;
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
        /**/
        public List<string> nm_cuidador { get; set; }
        public List<string> vl_cuidador { get; set; }
        public List<string> base64String { get; set; }
        public string base64standard { get; set; }
        public List<string> nm_especializacao { get; set; }
        public List<string> situacaoServico { get; set; }
        public List<string> diferencaData { get; set; }
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
            nm_necessidade = "";
            ds_paciente = "";
            cd_CEP_servico = "";
            nm_cidade_servico = "";
            nm_uf_servico = "";
            nm_bairro_servico = "";
            nm_num_servico = "";
            nm_comp_servico = "";

           /* */
            base64String = new List<string>();
            base64standard = "";
            vl_cuidador = new List<string>();
            nm_cuidador = new List<string>();
            nm_especializacao = new List<string>();
            situacaoServico = new List<string>();
            diferencaData = new List<string>();
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
                }
                if (!dados.IsClosed) { dados.Close(); }
                Desconectar();
                return true;
            }
            return false;
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

    }
}