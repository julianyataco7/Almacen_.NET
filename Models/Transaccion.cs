using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Practicando_parcial.Models
{
    public class Transaccion
    {
        public int id_transaccion { get; set; }
        public int id_tipo_transaccion { get; set; }
        public string transaccion { get; set; }
        public int id_almacen { get; set; }
        public string almacen { get; set; }
        public int id_pedido { get; set; }
        public DateTime fecha { get; set; }
        public int id_usuario { get; set; }
        public string usuario { get; set; }
        public string estado { get; set; }
    }
}