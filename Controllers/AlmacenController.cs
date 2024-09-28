using DocumentFormat.OpenXml.Office2010.ExcelAc;
using Practicando_parcial.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Practicando_parcial.Controllers
{
    public class AlmacenController : Controller
    {
        // GET: Almacen
        public ActionResult Index()
        {
            string rutaVirtual = "~/Views/Almacen/WF_IngresoAlmacen.aspx";

            StringWriter str = new StringWriter();

            Server.Execute(rutaVirtual, str, true);

            string contenido = str.ToString();


            return Content(contenido, "text/html");
        }

        public ActionResult Index2()
        {
            string rutaVirtual = "~/Views/Almacen/WF_ListarIngresoAlmacen.aspx";

            StringWriter str = new StringWriter();

            Server.Execute(rutaVirtual, str, true);

            string contenido = str.ToString();


            return Content(contenido, "text/html");
        }

        [HttpGet]
        public JsonResult ListarTransaccionoCbo()
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<TipoTransaccion> transaccion = new List<TipoTransaccion>();

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                string query = "select id_tipo_transaccion,tipo from tipo_transaccion";

                SqlCommand cmd = new SqlCommand(query, con);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        transaccion.Add(new TipoTransaccion
                        {
                            id_tipo_transaccion = dt.GetInt32(0),
                            tipo = dt.GetString(1),

                        });
                    }
                }
            }

            return Json(new { success = true, registro =transaccion }, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public JsonResult ListarAlmacenCbo()
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<Almacen>  alm = new List<Almacen>();

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                string query = "select id_almacen,stand from almacen";

                SqlCommand cmd = new SqlCommand(query, con);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        alm.Add(new Almacen
                        {
                            id_almacen = dt.GetInt32(0),
                            stand = dt.GetString(1),

                        });
                    }
                }
            }

            return Json(new { success = true, registro = alm }, JsonRequestBehavior.AllowGet);

        }


        [HttpPost]
        public JsonResult RegitrarTransaccion(Transaccion tr)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


            int id_usuario = (int)Session["id_usuario"];

            List<Transaccion> lista = new List<Transaccion>();


            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();
                string query = "insert into transaccion (id_tipo_transaccion,id_almacen,id_pedido,fecha,id_usuario,estado) values (@id_tipo_transaccion,@id_almacen,@id_pedido,@fecha,@id_usuario,@estado)";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@id_tipo_transaccion", tr.id_tipo_transaccion);
                    cmd.Parameters.AddWithValue("@id_almacen", tr.id_almacen);
                    cmd.Parameters.AddWithValue("@id_pedido", tr.id_pedido);
                    cmd.Parameters.AddWithValue("@fecha", tr.fecha);
                    cmd.Parameters.AddWithValue("@id_usuario", id_usuario);
                    cmd.Parameters.AddWithValue("@estado", "1");

                    cmd.ExecuteNonQuery();

                }

            }

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                string query = "select top(1) id_transaccion from transaccion order by id_transaccion desc";

                SqlCommand cmd = new SqlCommand(query, con);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        lista.Add(new Transaccion
                        {
                            id_transaccion = dt.GetInt32(0),
                        });
                    }
                }
            }


            return Json(new { success = true, registro = lista[0] });
        }

        [HttpPost]
        public ActionResult RegistrarDetalleTransaccion(List<DetalleTransaccion> DatosGrilla, int UltimaTransaccion)
        {

            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                List<int> lista_id_transaccion = new List<int>();

                for (int i = 0; i < DatosGrilla.Count; i++)
                {
                    string query = "select id_producto from producto where nombre_producto=@nombre";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.Add("@nombre", DatosGrilla[i].producto);

                    using (SqlDataReader dt = cmd.ExecuteReader())
                    {
                        while (dt.Read())
                        {
                            lista_id_transaccion.Add( dt.GetInt32(0));
                        }
                    }


                }

                for (int i = 0; i < DatosGrilla.Count; i++)
                {


                    string consulta = "insert into detalle_transaccion (id_transaccion,id_producto,cantidad,estado) values (@id_transaccion,@id_producto,@cantidad,@estado) ";

                    using (SqlCommand comando = new SqlCommand(consulta, con))
                    {
                        comando.Parameters.AddWithValue("@id_transaccion", UltimaTransaccion);
                        comando.Parameters.AddWithValue("@id_producto", lista_id_transaccion[i]);
                        comando.Parameters.AddWithValue("@cantidad", DatosGrilla[i].cantidad);
                        comando.Parameters.AddWithValue("@estado", "1");

                        comando.ExecuteNonQuery();
                    }
                }


            }

            return Json(new { success = true });

        }


        [HttpGet]
        public JsonResult ListarTransaccion()
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<Transaccion> lista_tr = new List<Transaccion>();

            string Procedimiento = "ListarTransaccciones ";

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(Procedimiento, con);

                cmd.CommandType = CommandType.StoredProcedure;


                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        lista_tr.Add(new Transaccion
                        {
                            id_transaccion = dt.GetInt32(0),
                            transaccion = dt.GetString(1),
                            almacen = dt.GetString(2),
                            usuario = dt.GetString(3),
                            fecha = dt.GetDateTime(4)

                        });
                    }
                }



            }

            List<object> pedidoFormateado = new List<object>();

            for (int i = 0; i < lista_tr.Count; i++)
            {


                var objetoFormateado = new
                {
                    id_transaccion = lista_tr[i].id_transaccion,
                    transaccion = lista_tr[i].transaccion,
                    almacen = lista_tr[i].almacen,
                    usuario = lista_tr[i].usuario,
                    fecha = lista_tr[i].fecha.ToString("yyyy-MM-ddTHH:mm:ss"),

                };

                pedidoFormateado.Add(objetoFormateado);
            }

            return Json(new { success = true, registro = pedidoFormateado }, JsonRequestBehavior.AllowGet);



        }

        [HttpPost]
        public JsonResult ActualizarTransaccion(Transaccion tr)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();
                string query = "update transaccion set id_tipo_transaccion=@id_tipo_transaccion, id_almacen=@id_almacen where id_transaccion=@id_transaccion";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@id_tipo_transaccion", tr.id_tipo_transaccion);
                    cmd.Parameters.AddWithValue("@id_almacen", tr.id_almacen);
                    cmd.Parameters.AddWithValue("@id_transaccion", tr.id_transaccion);

                    cmd.ExecuteNonQuery();

                }

            }


            return Json(new { success = true }); // objeto anonimo
        }

        [HttpPost]
        public JsonResult EliminarTransaccion(Transaccion tr)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();
                string query = " update transaccion set estado='0' where id_transaccion=@id_transaccion;";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@id_transaccion", tr.id_transaccion);

                    cmd.ExecuteNonQuery();

                }

            }

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();
                string query = " update detalle_transaccion set estado='0' where id_transaccion=@id_transaccion";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id_transaccion", tr.id_transaccion);

                    cmd.ExecuteNonQuery();

                }

            }


            return Json(new { success = true }); // objeto anonimo
        }

        [HttpGet]
        public JsonResult BuscarDetalleTransaccion(DetalleTransaccion dtr)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<DetalleTransaccion> listaP = new List<DetalleTransaccion>();
            string Procedimiento = "ListarDetalleTransaccion";

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(Procedimiento, con);

                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@id_transaccion", dtr.id_transaccion);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        listaP.Add(new DetalleTransaccion
                        {
                            id_detalle_transaccion = dt.GetInt32(0),
                            id_producto = dt.GetInt32(1),
                            producto = dt.GetString(2),
                            cantidad = dt.GetInt32(3),
                        });
                    }
                }



            }

            return Json(new { success = true, registro = listaP }, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public JsonResult ActualizarDetalleTransaccion( DetalleTransaccion dtr)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();
                string query = "update detalle_transaccion set id_producto=@id_producto, cantidad=@cantidad where id_detalle_transaccion=@id_detalle_transaccion";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@id_producto", dtr.id_producto);
                    cmd.Parameters.AddWithValue("@cantidad", dtr.cantidad);
                    cmd.Parameters.AddWithValue("@id_detalle_transaccion", dtr.id_detalle_transaccion);

                    cmd.ExecuteNonQuery();

                }

            }


            return Json(new { success = true }); // objeto anonimo
        }

        [HttpPost]
        public JsonResult EliminarDetalleTransaccion(DetalleTransaccion dtr)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();
                string query = "update detalle_transaccion set estado='0' where id_detalle_transaccion=@id_detalle_transaccion";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@id_detalle_transaccion", dtr.id_detalle_transaccion);

                    cmd.ExecuteNonQuery();

                }

            }


            return Json(new { success = true }); // objeto anonimo
        }

    }
}