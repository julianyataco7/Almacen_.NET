using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Practicando_parcial.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Mostrar_Home()
        {
            string rutaVirtual = "~/Views/Home/WF_Home.aspx";

            StringWriter str = new StringWriter();

            Server.Execute(rutaVirtual, str, true);

            string contenido = str.ToString();

            
            return Content(contenido,"text/html");
        }
    }
}