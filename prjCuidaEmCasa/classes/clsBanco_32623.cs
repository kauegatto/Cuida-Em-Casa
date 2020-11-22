using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MySql.Data.MySqlClient;
using System.Data;

namespace prjCuidaEmCasa.classes
{
    public class clsBanco_32623
    {
        public string msg { get; set; }

        MySqlConnection conexao = null;

        public bool Conectar()
        {
            string linhaConexao = clsConexao.getConexao();
            conexao = new MySqlConnection(linhaConexao);

            try
            {
                conexao.Open();
            }
            catch 
            {
                return false;
            }

            return true;
        }

        public void Desconectar()
        {
            if (conexao.State == ConnectionState.Open)
            {
                conexao.Close();
            }
        }

        public bool Select(string comando, ref MySqlDataReader dados)
        {
            if (Conectar())
            {
                try
                {
                    MySqlCommand cSQL = new MySqlCommand(comando, conexao);
                    dados = cSQL.ExecuteReader();
                }
                catch (Exception erro)
                {
                    msg = erro.Message;
                    return false;
                }
            }
            else
            {
                return false;
            }

            return true;
        }

        public bool Inserir(string comando)
        {
            if (Conectar())
            {
                try
                {
                    MySqlCommand cSQL = new MySqlCommand(comando, conexao);
                    cSQL.ExecuteNonQuery();
                }
                catch (Exception erro)
                {
                    msg = erro.Message;
                    return false;
                }
            }
            else
            {
                return false;
            }

            return true;
        }

        public bool Update(string comando)
        {
            if (Conectar())
            {
                try
                {
                    MySqlCommand cSQL = new MySqlCommand(comando, conexao);
                    cSQL.ExecuteNonQuery();
                }
                catch (Exception erro)
                {
                    msg = erro.Message;
                    return false;
                }
            }
            else 
            {
                return false;
            }

            return true;
        }

        public bool Delete(string comando)
        {
            if (Conectar())
            {
                try
                {
                    MySqlCommand cSQL = new MySqlCommand(comando, conexao);
                    cSQL.ExecuteNonQuery();
                }
                catch (Exception erro)
                {
                    msg = erro.Message;
                    return false;
                }
            }
            else
            {
                return false;
            }

            return true;
        }

        public bool Procedure(string StoreProcedure, bool temParametros, string[,] parametros, ref MySqlDataReader dados)
        {
            if (Conectar())
            {
                try
                {
                    MySqlCommand cSQL = new MySqlCommand(StoreProcedure, conexao);
                    cSQL.CommandType = CommandType.StoredProcedure;

                    if (temParametros)
                    {
                        cSQL.Parameters.Clear();
                        if (parametros.Length != 0)
                        {
                            for (int i = 0; i < parametros.GetLength(0); i++)
                            {
                                cSQL.Parameters.AddWithValue(parametros[i, 0], parametros[i, 1]);
                            }
                        }
                        else
                        {
                            return false;
                        }
                    }

                    dados = cSQL.ExecuteReader();
                }
                catch (Exception erro)
                {
                    msg = erro.Message;
                    return false;
                }
            }
            else
            {
                return false;
            }

            return true;
        }

        public bool ProcedureIMG(string StoreProcedure, bool temParametros, string[,] parametros, byte[] imgBinario,ref MySqlDataReader dados)
        {
            if (Conectar())
            {
                try
                {
                    MySqlCommand cSQL = new MySqlCommand(StoreProcedure, conexao);
                    cSQL.CommandType = CommandType.StoredProcedure;

                    if (temParametros)
                    {
                        cSQL.Parameters.Clear();
                        if (parametros.Length != 0)
                        {
                            for (int i = 0; i < parametros.GetLength(0); i++)
                            {
                                cSQL.Parameters.AddWithValue(parametros[i, 0], parametros[i, 1]);
                            }

                            MySqlParameter parametroImagem = new MySqlParameter("vImgUsuario", MySqlDbType.Binary);
                            parametroImagem.Value = imgBinario;
                            cSQL.Parameters.Add(parametroImagem);

                        }
                        else
                        {
                            return false;
                        }
                    }

                    dados = cSQL.ExecuteReader();
                }
                catch (Exception erro)
                {
                    msg = erro.Message;
                    return false;
                }
            }
            else
            {
                return false;
            }

            return true;
        }
    }
}
