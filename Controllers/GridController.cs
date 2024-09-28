using ClosedXML.Excel;
using Practicando_parcial.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Hosting;
using System.Web.Mvc;


namespace Practicando_parcial.Controllers
{
    public class GridController : Controller
    {
        // GET: Grid
        public ActionResult Index()
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            List<Usuario> lista = new List<Usuario>();

            using (SqlConnection con = new SqlConnection(cadena)) 
            {
                con.Open();

                string query = "SELECT TOP (1000) [id_usuario],[nombre] ,[email] FROM [Control_Pedidos5].[dbo].[usuario]";

                SqlCommand comando = new SqlCommand(query,con);

                using (SqlDataReader rd = comando.ExecuteReader()) 
                {
                    while (rd.Read()) {
                        lista.Add(new Usuario
                        {
                            id_usuario = rd.GetInt32(0),
                            usuario = rd.GetString(1),
                            email = rd.GetString(2)
                        });
                    }
                
                }

            }

            Session["usuarios"] = lista;
            HttpContext.Items["usuarios"] = lista;

            #region mostrar grid          
            string RutaVirtual = "~/Views/Grid/WF_Grid.aspx";

            StringWriter str = new StringWriter();

            Server.Execute(RutaVirtual, str, true);

            string contenido = str.ToString();

            return Content(contenido, "text/html");
            #endregion
        }



        public ActionResult ExportarAExcel()
        {
            DataTable datatable = new DataTable("Usuarios");
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cnx))
            {

                string queryString = "SELECT TOP (1000) [id_usuario],[nombre],[contrasena],[email],[estado] FROM [Control_Pedidos5].[dbo].[usuario]";
                using (SqlCommand cmd = new SqlCommand(queryString, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(datatable);
                }

            }

            using (var workBook = new XLWorkbook())
            {
                var workSheet = workBook.Worksheets.Add(datatable);
                string folderPath = HostingEnvironment.MapPath("~/ExportedFiles/");
                string fileName = $"Usuarios_{DateTime.Now:yyyyMMddHHmmss}.xlsx";
                string fullPath = Path.Combine(folderPath, fileName);

                //Asegurarnos que el directorio exista
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                workBook.SaveAs(fullPath);

                // devulva , conel nombre... para descargarlo
                return Json(new { fileName = fileName }, JsonRequestBehavior.AllowGet);

            }

        }

        public ActionResult DescargarExcel(string archivo)
        {
            string folderPath = HostingEnvironment.MapPath("~/ExportedFiles/");
            string fullPath = Path.Combine(folderPath, archivo);


            if (System.IO.File.Exists(fullPath))
            {
                byte[] fileBytes = System.IO.File.ReadAllBytes(fullPath);
                return File(fileBytes, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", archivo);

            }

            return new HttpStatusCodeResult(HttpStatusCode.NotFound, "El archivo no fue encontrado");

        }

        [HttpPost]
        public JsonResult Redirect_login() {

            return Json(new { success = true, redirectUrl = Url.Action("Mostrar_login", "Cuentas") });

        }


    }
}