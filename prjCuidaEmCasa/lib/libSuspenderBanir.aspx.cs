using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjCuidaEmCasa.classes;

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

            clsAdministrador adm = new clsAdministrador();

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