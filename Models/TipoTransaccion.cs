using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Practicando_parcial.Models
{
    public class TipoTransaccion
    {
        public int id_tipo_transaccion { get; set; }
        public string tipo { get; set; }

        public string etado { get; set; }
    }
}