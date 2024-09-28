using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Practicando_parcial.Models
{
    public class DetallePedido
    {
        public int id_detalle { get; set; }
        public int id_pedido { get; set; }
        public int id_producto { get; set; }   
        public int cantidad { get; set; }
        public string estado { get; set; }
        public string producto { get; set; }

    }
}