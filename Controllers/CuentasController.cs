using ClosedXML.Excel;
using Practicando_parcial.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Hosting;
using System.Web.Mvc;
using System.Web.Security;

namespace Practicando_parcial.Controllers
{
    public class CuentasController : Controller
    {

        // variables a usar
         
        // GET: Cuentas
        public ActionResult Mostrar_register()
        {
            string RutaVirtual = "~/Views/Cuentas/WF_CrearUsu.aspx";

            StringWriter str = new StringWriter();

            Server.Execute(RutaVirtual,str,true);

            string contenido = str.ToString();

            return Content(contenido,"text/html");
        }

        public ActionResult Mostrar_login()
        {
            string RutaVirtual = "~/Views/Cuentas/WF_Login.aspx";

            StringWriter str = new StringWriter();

            Server.Execute(RutaVirtual, str, true);

            string contenido = str.ToString();

            return Content(contenido, "text/html");
        }

        [HttpPost]
        public JsonResult AgregarUsuario(Usuario User) 
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            List<Usuario> lista = new List<Usuario>();

            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();
                string query = "Insert Into usuario (nombre,contrasena,email) values (@nombre,@contrasena,@email)";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@nombre", User.usuario);
                    cmd.Parameters.AddWithValue("@contrasena", User.contraseña);
                    cmd.Parameters.AddWithValue("@email", User.email);

                    cmd.ExecuteNonQuery();

                }

               

            }


            MembershipCreateStatus createStatus;

            MembershipUser newUser = Membership.CreateUser(
              User.usuario,
              User.contraseña,
              User.email,
              null,
              null,
              true,
              out createStatus
            );

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                string query = "select top(1) * from usuario order by id_usuario desc";

                SqlCommand cmd = new SqlCommand(query, con);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        lista.Add(new Usuario
                        {
                            id_usuario = dt.GetInt32(0),
                            usuario = dt.GetString(1),
                            contraseña = dt.GetString(2),
                            email = dt.GetString(3),
                        });
                    }
                }
            }

            return Json(new { success = true , registroNew = lista}); // objeto anonimo
        }

        [HttpGet]
        public JsonResult Listar_Usu() {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<Usuario> usuario = new List<Usuario>();

            using (SqlConnection con = new SqlConnection(cadena)) {
                con.Open();

                string query = "SELECT TOP (1000) [id_usuario],[nombre] ,[contrasena],[email] FROM [Control_Pedidos5].[dbo].[usuario]";

                SqlCommand cmd = new SqlCommand(query,con);

                using (SqlDataReader dt = cmd.ExecuteReader()) {
                    while (dt.Read()) {
                        usuario.Add(new Usuario
                        {
                            id_usuario = dt.GetInt32(0),
                            usuario = dt.GetString(1),
                            contraseña = dt.GetString(2),
                            email = dt.GetString(3),
                        });
                    }
                }
            }

            return Json(new { success = true, registro = usuario }, JsonRequestBehavior.AllowGet);



        }

        public JsonResult RecargarPage()
        {
            return Json(new { success = true, redirectUrl = Url.Action("Mostrar_register", "Cuentas") });

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
        public JsonResult Autenticar2(Usuario User)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


            int id_usuario = 0;
            int confirmacion = 0;


            using (SqlConnection conexion = new SqlConnection(cadena))
            {
                conexion.Open();

                string query = "SELECT id_usuario FROM usuario WHERE nombre = @nombre AND contrasena = @contrasena ";
                SqlCommand comando = new SqlCommand(query, conexion);
                comando.Parameters.AddWithValue("@nombre", User.usuario);
                comando.Parameters.AddWithValue("@contrasena", User.contraseña);



                using (SqlDataReader leer = comando.ExecuteReader())
                {
                    while (leer.Read())
                    {
                        id_usuario = leer.GetInt32(0);
                        
                    }
                }

               

            }

            bool authencated = Membership.ValidateUser(User.usuario, User.contraseña);
            if (authencated)
            {

                confirmacion = 1;
                Debug.WriteLine($"Valor de id_usuario: {id_usuario}");
                Session.Add("id_usuario", id_usuario);

            }

            else
            {
                confirmacion = 0;
            }

          

            return Json(new { success = true, registro=confirmacion });

        }

        [HttpPost]
        public JsonResult Redirect_register()
        {
            return Json(new { success = true, redirectUrl = Url.Action("Mostrar_register", "Cuentas") });
        }
        [HttpPost]
        public JsonResult Redirect_login()
        {

            return Json(new { success = true, redirectUrl = Url.Action("Mostrar_login", "Cuentas") });

        }
        [HttpPost]
        public JsonResult Redirect_Home()
        {

            return Json(new { success = true, redirectUrl = Url.Action("Mostrar_Home", "Home") });

        }
    }
}