using Practicando_parcial.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Practicando_parcial.Views.Grid
{
    public partial class WF_Grid : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {

                var usuario = HttpContext.Current.Items["usuarios"] as List<Usuario>;

                if (usuario != null) {

                    var serializer = new JavaScriptSerializer();
                    HiddenField1.Value = serializer.Serialize(usuario);


                }
            }
        }
    }
}