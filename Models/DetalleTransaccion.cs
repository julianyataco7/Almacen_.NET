using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Practicando_parcial.Models
{
    public class DetalleTransaccion
    {
        public int id_detalle_transaccion { get; set; }
        public int id_transaccion { get; set; }
        public int id_producto { get; set; }
        public string producto { get; set; }
        public int cantidad { get; set; }

    }
}