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

        public clsServico(): base() 
        {
            codigo = "";
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
            string[,] valores = new string[1, 2];
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

    }
}