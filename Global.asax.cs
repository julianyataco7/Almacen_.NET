using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace Practicando_parcial
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            ViewEngines.Engines.Clear();

            RegistarRuta(RouteTable.Routes);
        }

        public static void RegistarRuta(RouteCollection ruta) {

            ruta.MapRoute(

                name: "default",
                url: "{controller}/{action}/{id}",
                defaults: new
                {
                    Controller = "Cuentas",
                    Action = "Mostrar_login",
                    id = UrlParameter.Optional,

                }
                );

                
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

       protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}