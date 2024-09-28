using DocumentFormat.OpenXml.Office.Word;
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
using System.Web.Security;
using System.Web.UI.WebControls;

namespace Practicando_parcial.Controllers
{
    public class PedidoController : Controller
    {
        // GET: Pedido
        public ActionResult Index()
        {
            string rutaVirtual = "~/Views/Pedido/WF_Pedido.aspx";

            StringWriter str = new StringWriter();

            Server.Execute(rutaVirtual, str, true);

            string contenido = str.ToString();


            return Content(contenido, "text/html");
        }


        [HttpGet]
        public JsonResult Buscar_categoria(SeleccionProducto sp)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<SeleccionProducto> listaP = new List<SeleccionProducto>();
            string Procedimiento = "ProductoXCategoria";

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(Procedimiento, con);
                
                 cmd.CommandType = CommandType.StoredProcedure;

                   
                  cmd.Parameters.AddWithValue("@categoria", sp.categoria);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        listaP.Add(new SeleccionProducto
                        {
                           id_producto = dt.GetInt32(0),
                           categoria = dt.GetString(1),
                           producto = dt.GetString(2),
                           color = dt.GetString(3),
                           unidad_medida = dt.GetString(4),
                        });
                    }
                }



            }

            return Json(new { success = true, registro = listaP }, JsonRequestBehavior.AllowGet);



        }

        [HttpGet]
        public JsonResult Buscar_proveedor(Proveedor pr)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<Proveedor> listaP = new List<Proveedor>();

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                string query = "select id_proveedor,nomb_proveedor,galeria,stand from proveedor where nomb_proveedor=@nombre";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.Add("@nombre",pr.nombre);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        listaP.Add(new Proveedor
                        {
                            id_proveedor = dt.GetInt32(0),
                            nombre = dt.GetString(1),
                            galeria = dt.GetString(2),
                            stand = dt.GetString(3),
                        });
                    }
                }
            }


            return Json(new { success = true, registro = listaP }, JsonRequestBehavior.AllowGet);



        }

        [HttpGet]
        public JsonResult Buscar_producto(SeleccionProducto sp)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<SeleccionProducto> listaP = new List<SeleccionProducto>();
            string Procedimiento = "BuscarXProducto";

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(Procedimiento, con);

                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@producto", sp.producto);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        listaP.Add(new SeleccionProducto
                        {
                            id_producto = dt.GetInt32(0),
                            categoria = dt.GetString(1),
                            producto = dt.GetString(2),
                            color = dt.GetString(3),
                            unidad_medida = dt.GetString(4),
                        });
                    }
                }



            }

            return Json(new { success = true, registro = listaP }, JsonRequestBehavior.AllowGet);



        }

        [HttpPost]
        public JsonResult Registrar_pedido(Pedido pd)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


            int id_usuario = (int)Session["id_usuario"];

            List<Pedido> lista = new List<Pedido>();


            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();
                string query = "insert into pedido (fecha,id_proveedor,estado_proceso,estado_pago,id_usuario,estado) values (@fecha,@id_proveedor,@estado_proceso,@estado_pago,@id_usuario,@estado);";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@fecha", pd.fecha);
                    cmd.Parameters.AddWithValue("@id_proveedor",pd.id_proveedor );
                    cmd.Parameters.AddWithValue("@estado_proceso", pd.estado_proceso);
                    cmd.Parameters.AddWithValue("@estado_pago", pd.estado_pago);
                    cmd.Parameters.AddWithValue("@id_usuario", id_usuario);
                    cmd.Parameters.AddWithValue("@estado", "1");

                    cmd.ExecuteNonQuery();

                }

            }

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                string query = "select top(1) id_pedido from pedido order by id_pedido desc";

                SqlCommand cmd = new SqlCommand(query, con);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        lista.Add(new Pedido
                        {
                            id_pedido = dt.GetInt32(0),
                        });
                    }
                }
            }


            return Json(new { success = true, registro = lista[0] });
        }

        [HttpPost]
        public ActionResult Registrar_pedidoDetalle(List<SeleccionProducto> DatosGrilla, int UltimoPedido)
        {

            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();



                for (int i = 0; i < DatosGrilla.Count; i++)
                {


                    string consulta = "insert into detalle_pedido (id_pedido,id_producto,cantidad,estado) values (@id_pedido,@id_producto,@cantidad,@estado)";

                    using (SqlCommand comando = new SqlCommand(consulta, con))
                    {
                        comando.Parameters.AddWithValue("@id_pedido", UltimoPedido);
                        comando.Parameters.AddWithValue("@id_producto", DatosGrilla[i].id_producto);
                        comando.Parameters.AddWithValue("@cantidad", DatosGrilla[i].cantidad);
                        comando.Parameters.AddWithValue("@estado", "1");

                        comando.ExecuteNonQuery();
                    }
                }
            }

            return Json(new { success = true });

        }

        public ActionResult MostarPedidos()
        {

            string rutaVirtual = "~/Views/Pedido/WF_listarPedidos.aspx";

            StringWriter str = new StringWriter();

            Server.Execute(rutaVirtual, str, true);

            string contenido = str.ToString();


            return Content(contenido, "text/html");

        }

        [HttpGet]
        public JsonResult ListarPedidos()
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<Pedido> pedido = new List<Pedido>();

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                string query = "SELECT id_pedido,fecha,id_proveedor,id_usuario, IIF(estado_proceso=0,'falta','completo') as estado_proceso, IIF(estado_pago=0,'deuda','pagado') as estado_pago FROM [Control_Pedidos5].[dbo].[pedido] where estado='1'";

                SqlCommand cmd = new SqlCommand(query, con);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        pedido.Add(new Pedido
                        {
                            id_pedido = dt.GetInt32(0),
                            fecha = dt.GetDateTime(1),
                            id_proveedor = dt.GetInt32(2),
                            id_usuario = dt.GetInt32(3),
                            estado_proceso = dt.GetString(4),
                           estado_pago = dt.GetString(5),
                           
                        });
                    }
                }
            }

            List<object> pedidoFormateado = new List<object>();

            for (int i = 0; i < pedido.Count; i++)
            {


                var objetoFormateado = new
                {
                    id_pedido = pedido[i].id_pedido,
                    fecha = pedido[i].fecha.ToString("yyyy-MM-ddTHH:mm:ss"),
                    id_proveedor = pedido[i].id_proveedor,
                    estado_proceso = pedido[i].estado_proceso,
                    estado_pago = pedido[i].estado_pago,
                    id_usuario = pedido[i].id_usuario
                };

                pedidoFormateado.Add(objetoFormateado);
            }

            return Json(new { success = true, registro = pedidoFormateado }, JsonRequestBehavior.AllowGet);



        }

        [HttpGet]
        public JsonResult ListarProductoCbo()
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<SeleccionProducto> producto = new List<SeleccionProducto>();

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                string query = "select id_producto,nombre_producto from producto";

                SqlCommand cmd = new SqlCommand(query, con);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        producto.Add(new SeleccionProducto
                        {
                            id_producto = dt.GetInt32(0),
                            producto = dt.GetString(1),

                        });
                    }
                }
            }

            return Json(new { success = true, registro = producto }, JsonRequestBehavior.AllowGet);



        }

        [HttpGet]
        public JsonResult Buscar_detalle(DetallePedido sp)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<DetallePedido> listaP = new List<DetallePedido>();
            string Procedimiento = "BuscarDetallePedido";

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(Procedimiento, con);

                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@id_pedido", sp.id_pedido);

                using (SqlDataReader dt = cmd.ExecuteReader())
                {
                    while (dt.Read())
                    {
                        listaP.Add(new DetallePedido
                        {
                            id_detalle = dt.GetInt32(0),
                            id_pedido = dt.GetInt32(1),
                            id_producto = dt.GetInt32(2),
                            producto = dt.GetString(3),
                            cantidad = dt.GetInt32(4),
                        });
                    }
                }



            }

            return Json(new { success = true, registro = listaP }, JsonRequestBehavior.AllowGet);



        }


        [HttpPost]
        public JsonResult Actualizar_detalleP(DetallePedido detalle)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();
                string query = "  update detalle_pedido set id_producto=@id_producto,cantidad=@cantidad  where id_detalle_pedido=@id_detalle_pedido";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@id_producto", detalle.id_producto);
                    cmd.Parameters.AddWithValue("@cantidad", detalle.cantidad);
                    cmd.Parameters.AddWithValue("@id_detalle_pedido", detalle.id_detalle);

                    cmd.ExecuteNonQuery();

                }

            }

           
            return Json(new { success = true }); // objeto anonimo
        }

        [HttpPost]
        public JsonResult Eliminar_detalleP(DetallePedido detalle)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

           

            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();
                string query = "  update detalle_pedido set estado='0'  where id_detalle_pedido=@id_detalle_pedido";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@id_detalle_pedido", detalle.id_detalle);

                    cmd.ExecuteNonQuery();

                }

            }


            return Json(new { success = true }); // objeto anonimo
        }

        [HttpPost]
        public JsonResult Actualizar_Pedido(Pedido pd)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();
                string query = "   update pedido set estado_proceso=@estado_proceso, estado_pago=@estado_pago where  id_pedido=@id_pedido";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@estado_proceso", pd.estado_proceso);
                    cmd.Parameters.AddWithValue("@estado_pago", pd.estado_pago);
                    cmd.Parameters.AddWithValue("@id_pedido", pd.id_pedido);

                    cmd.ExecuteNonQuery();

                }

            }


            return Json(new { success = true }); // objeto anonimo
        }

        [HttpPost]
        public JsonResult Eliminar_pedido(DetallePedido detalle)
        {
            string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


            using (SqlConnection cn = new SqlConnection(cadena))
            {
                cn.Open();
                string query = " update pedido set estado='0' where id_pedido=@id_pedido;";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@id_pedido", detalle.id_pedido);

                    cmd.ExecuteNonQuery();

                }

            }

            using (SqlConnection con = new SqlConnection(cadena))
            {
                con.Open();
                string query = " update detalle_pedido set estado='0' where id_pedido=@id_pedido";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id_pedido", detalle.id_pedido);

                    cmd.ExecuteNonQuery();

                }

            }


            return Json(new { success = true }); // objeto anonimo
        }
    }
}