using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Practicando_parcial.Models
{
    public class Pedido
    {
        public int id_pedido { get; set; }
        public DateTime fecha { get; set; }
        public int id_proveedor { get; set; }
        public string estado_proceso { get; set; }
        public string estado_pago { get; set; }
        public int id_usuario { get; set; }
        public string estado { get; set; }

    }
}