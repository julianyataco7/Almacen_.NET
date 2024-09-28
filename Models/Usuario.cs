using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Practicando_parcial.Models
{
    public class Usuario
    {
        public int id_usuario { get; set; }
        public string usuario { get; set; }
        public string contraseña { get; set; }
        public string email { get; set; }
    }
}