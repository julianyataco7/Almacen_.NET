<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WF_IngresoAlmacen.aspx.cs" Inherits="Practicando_parcial.Views.Almacen.WF_IngresoAlmacen" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
        <%------------estilos--%>
   <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh; 
        }

        content {
            flex: 1; 
        }

        footer {
            background-color: #3396FF;
            color: #FFFFFF;
            padding: 10px 0;
            text-align: center;
        }
    </style> 


     <!-- Existing Bootstrap and jQuery references -->
	 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

	 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


	 <!-- jqGrid CSS and JS references -->
	 <link href="http://trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" rel="stylesheet" />
	 <link href="http://trirand.com/blog/jqgrid/themes/ui.jqgrid.css" rel="stylesheet" />
	 <link href="http://trirand.com/blog/jqgrid/themes/ui.multiselect.css" rel="stylesheet" />
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>

	 <!-- Additional existing references -->
	 <link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js">
	 <link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js">
    
   
<%--    -----barra superior--%>
         <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
       
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item ">
                    <a class="nav-link" href="/Pedido/Index">Registrar Pedido</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/Pedido/MostarPedidos">Monitorear Pedido</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/Almacen/Index2">Monitorear Almacén</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/Almacen/Index">Registrar Ingreso Almacén</a>
                </li>
            </ul>
        </div>
    </nav>
</asp:Content>

<asp:Content ID ="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <%------------style--%>
     <style>
        html, body {
            height: 100%;
            margin: 0;
        }

        #container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .modal-lg {
            max-width: 80%; /* Ajusta este valor según tus necesidades */
        }

    </style>
<%------------style--%>

<%------------formulario--%>

     <div id="container" class="container mt-5">
            <h2>Registro de transaccion almacén</h2>

               <!-- tipo transaccion -->
             <div class="form-group mb-4">
                <label for="ddl">Tipo transaccion:</label>
              <select id="ddlTipoTransaccion" class="form-control" style="width: 300px;"></select>
    
            </div>

         <!-- codigo almacen -->
             <div class="form-group mb-4">
                <label for="ddl">Codigo Almacén:</label>
              <select id="ddlCodAlmacen" class="form-control" style="width: 300px;"></select>
    
            </div>

          <!--  pedido -->
        
          <div class="form-group  mb-4"" >
                <label for="TextBox2">Pedido:</label>
                <asp:TextBox ID="TxtPedido" runat="server" CssClass="form-control mb-2" Width="300"></asp:TextBox>
                <asp:Button ID="BtnPedido" runat="server" Text="Buscar Pedido" CssClass="btn btn-primary " Width="250" />
            </div>
         <!-- Producto  -->
        
          <div class="form-group  mb-4"" >
                <label for="TextBox2">Producto:</label>
                <asp:TextBox ID="TxtProducto" runat="server" CssClass="form-control mb-2" Width="300"></asp:TextBox>
               <asp:Button ID="BtnProducto" runat="server" Text="Buscar Pedido" CssClass="btn btn-primary " Width="250" />
            </div>
          <!-- Cantidad  -->
        
          <div class="form-group  mb-4"" >
                <label for="TextBox2">Cantidad:</label>
                <asp:TextBox ID="TxtCantidad" runat="server" CssClass="form-control mb-2" Width="300"></asp:TextBox>
            </div>
 
            <!-- Botón Registrar -->
            <asp:Button ID="BtnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-success mb-4" Width="300" />

            <!-- Botones adicionales -->
            <div class="form-group mb-4">
                <div class="d-flex justify-content-between">
                    <asp:Button ID="BtnAgregar" runat="server" Text="Agregar" CssClass="btn btn-secondary" />

                </div>
            </div>
        </div>

     <%--       colocar la grilla--%>
            <div style="padding:40px">
		         <table id="jqGrid"></table>
		         <div id="jqGridPager"></div>
		    </div>


           <%--       model Pedido--%>
   <div id="BuscarPedido" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"  >
	  <div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<h5 class="modal-title">Detalle de Pedido</h5>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			  <span aria-hidden="true">&times;</span>
			</button>
		  </div>

		  <div class="modal-body">
			<p>Modal body text goes here.</p>



              <%--       colocar la grilla--%>
            <div style="padding:40px">
		         <table id="jqGrid2"></table>
		         <div id="jqGridPager2"></div>
		    </div>


		  </div>
		  <div class="modal-footer">
			<button id="BtnCerraModal1" type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			<button id="BtnGuardarCambios1" type="button" class="btn btn-primary">Guardar cambios</button>
		  </div>
		</div>
	  </div>
	</div>

           <%--       model producto--%>
   <div id="BuscarProducto" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"  >
	  <div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<h5 class="modal-title">Detalle de Pedido</h5>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			  <span aria-hidden="true">&times;</span>
			</button>
		  </div>

		  <div class="modal-body">
			<p>Modal body text goes here.</p>



              <%--       colocar la grilla--%>
            <div style="padding:40px">
		         <table id="jqGrid3"></table>
		         <div id="jqGridPager3"></div>
		    </div>


		  </div>
		  <div class="modal-footer">
			<button id="BtnCerraModal2" type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			<button id="BtnGuardarCambios2" type="button" class="btn btn-primary">Guardar cambios</button>
		  </div>
		</div>
	  </div>
	</div>


   <script type="text/javascript">

       $(document).ready(function () {

           var id_pedido;
           var producto;

           //grid pedido principal 1
           $("#jqGrid").jqGrid({
               datatype: "local",

               colModel: [
                   { label: "PRODUCTO", name: "producto", key: true, width: 150 },
                   { label: "CANTIDAD", name: "cantidad", width: 150, editable: false },
                   { label: "ELIMINAR", name: "eliminar", width: 100, formatter: deleteButtonFormater }


               ],
               pager: "#jqGridPager",
               height: 200,
               width: 1000,
               rowNum: 20,
               viewrecords: true

           });

           $("#jqGrid2").jqGrid({
               datatype: "local",
               colModel: [
                   { label: "ID PEDIDO", name: "id_pedido", key: true, width: 75 },
                   { label: "FECHA", name: "fecha", width: 150 },
                   { label: "ID_PROVEEDOR", name: "id_proveedor", width: 150 },
                   { label: "ESTADO DE PROCESO", name: "estado_proceso", width: 150 },
                   { label: "ESTADO DE PAGO", name: "estado_pago", width: 150 },
                   { label: "ID USUARIO", name: "id_usuario", width: 150 },
                   { label: "Select", name: "Select", width: 100, formatter: selectButtonFormater },


               ],
               pager: "#jqGridPager2",
               height: 300,
               width: 900,
               rowNum: 50,
               viewrecords: true,

           });

           $("#jqGrid3").jqGrid({
               datatype: "local",
               colModel: [
                   { label: "ID DETALLEPEDIDO", name: "id_detalle",  width: 75 },
                   { label: "ID PEDIDO", name: "id_pedido", width: 150 },
                   { label: "ID_PRODUCTO", name: "id_producto", width: 150 },
                   { label: "NOMBRE DEL PRODUCTO", name: "producto", key: true, width: 150 },
                   { label: "CANTIDAD", name: "cantidad", width: 150 },
                   { label: "Select", name: "Select", width: 100, formatter: selectButtonFormater3 },


               ],
               pager: "#jqGridPager3",
               height: 200,
               width: 720,
               rowNum: 20,
               viewrecords: true,

           });

           function selectButtonFormater(cellValue, options, rowObject) {
               return "<button type='button'  id='btnSelect' class='btn-delete' data-id='" + rowObject.producto + "'   > Seleccionar </button>";
           }
           function selectButtonFormater3(cellValue, options, rowObject) {
               return "<button type='button'  id='btnSelect3' class='btn-delete' data-id='" + rowObject.producto + "'   > Seleccionar </button>";
           }
           function deleteButtonFormater(cellValue, options, rowObject) {
               return "<button type='button'  id='btnDelete' class='btn-delete' data-id='" + rowObject.id_pedido + "'   > Eliminar </button>";
           }
           function updateButtonFormater(cellValue, options, rowObject) {
               return "<button type='button'  id='btnUpdate' class='btn-delete' data-id='" + rowObject.id_pedido + "'   > Eliminar </button>";
           }

           // evento para eliminar una fila del jqgrid principal
           $("#jqGrid").on('click', '#btnDelete', function () {
               var rowId = $(this).closest('tr').attr('id');
               $("#jqGrid").jqGrid('delRowData', rowId);
           });

           // llenar modal de pedidos
           $.ajax({
               url: '/Pedido/ListarPedidos',
               type: 'GET',
               dataType: 'json',
               success: function (response) {
                   if (response.success) {

                       $("#jqGrid2").jqGrid('clearGridData');
                       $("#jqGrid2").jqGrid('setGridParam', { data: response.registro });
                       $("#jqGrid2").trigger('reloadGrid', [{ current: true }]);
                       

                   }

               },
               error: function (error) {
                   // Manejar el error aquí
                   console.error('Error en la solicitud Ajax:', error);
               }
           });

           // Agregar el id pedido al label
           $("#jqGrid2").on('click', '#btnSelect', function () {
               id_pedido = $(this).closest('tr').attr('id');
               document.getElementById('<%= TxtPedido.ClientID %>').value = id_pedido;
           });
           


           // ajax llena combo transaccion
           $.ajax({
               type: "GET",
               url: "/Almacen/ListarTransaccionoCbo",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (response) {
                   $("#ddlTipoTransaccion").empty();
                   // Manejar la respuesta y llenar el DropDownList
                   for (var i = 0; i < response.registro.length; i++) {
                       var lista = response.registro[i];

                       // Agregar una opción al DropDownList
                       $("#ddlTipoTransaccion").append($("<option></option>")
                           .attr("value", lista.id_tipo_transaccion)
                           .text(lista.tipo));
                   }

               },
               error: function (error) {
                   console.log(error);
               }
           });


           // ajax llenar almacen cbo

           $.ajax({
               type: "GET",
               url: "/Almacen/ListarAlmacenCbo",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (response) {
                   $("#ddlCodAlmacen").empty();
                   // Manejar la respuesta y llenar el DropDownList
                   for (var i = 0; i < response.registro.length; i++) {
                       var lista = response.registro[i];

                       // Agregar una opción al DropDownList
                       $("#ddlCodAlmacen").append($("<option></option>")
                           .attr("value", lista.id_almacen)
                           .text(lista.stand));
                   }

               },
               error: function (error) {
                   console.log(error);
               }
           });

           // abrir modal pedido
           $("#<%= BtnPedido.ClientID %>").click(function (event) {
               event.preventDefault(); // Evitar el comportamiento predeterminado del botón

               console.log("Función llamada");
               $("#BuscarPedido").modal('show');


           });

           //cerrar modal pedido
           $("#BtnCerraModal1").on("click", function () {
               event.preventDefault(); // Evitar el comportamiento predeterminado del botón

               $("#BuscarPedido").modal('hide');
           });

           // abrir modal producto
           $("#<%= BtnProducto.ClientID %>").click(function (event) {
               event.preventDefault(); // Evitar el comportamiento predeterminado del botón
               
               $("#BuscarProducto").modal('show');

               alert(id_pedido)

               //// llenar grid de productos segun el id de pedido
               $.ajax({
                   url: '/Pedido/Buscar_detalle',
                   type: 'GET',
                   data: { id_pedido: id_pedido },
                   dataType: 'Json',
                   success: function (response) {
                       if (response.success) {



                           $("#jqGrid3").jqGrid('clearGridData');
                           $("#jqGrid3").jqGrid('setGridParam', { data: response.registro });
                           $("#jqGrid3").trigger('reloadGrid', [{ current: true }]);
                           alert("Sí pasó");




                       }

                   },
                   error: function (error) {
                       // Manejar el error aquí
                       console.error('Error en la solicitud Ajax:', error);
                   }
               });



           });

           // Agregar el producto al label
           $("#jqGrid3").on('click', '#btnSelect3', function () {
               var producto = $(this).closest('tr').attr('id');
               document.getElementById('<%= TxtProducto.ClientID %>').value = producto;
           });

           //cerrar modal producto
           $("#BtnCerraModal2").on("click", function () {
               event.preventDefault(); // Evitar el comportamiento predeterminado del botón

               $("#BuscarProducto").modal('hide');
           });

           // boton agregar la transaccion a la grilla principal
           $("#<%= BtnAgregar.ClientID %>").click(function (event) {
               event.preventDefault(); // Evitar el comportamiento predeterminado del botón

               

               var fila_transaccion = {
                   
                   producto: $("#<%= TxtProducto.ClientID %>").val(),
                   cantidad: $("#<%= TxtCantidad.ClientID %>").val(),
                   

               }

               $("#jqGrid").jqGrid('addRowData', 1, fila_transaccion);
               $("#jqGrid").trigger("reloadGrid");

           });

           $("#<%= BtnRegistrar.ClientID %>").click(function (event) {
               event.preventDefault(); 
               alert($("#ddlCodAlmacen").val());

               var tipo_tr = $("#ddlTipoTransaccion").val();
               var alm = $("#ddlCodAlmacen").val();
               var pdi = $("#<%= TxtPedido.ClientID %>").val();
               var fechaHora = new Date().toISOString(); 

               var formData = new FormData();

               formData.append("id_tipo_transaccion", tipo_tr);
               formData.append("id_almacen", alm);
               formData.append("id_pedido", pdi);
               formData.append("fecha", fechaHora);

               $.ajax({
                   url: '/Almacen/RegitrarTransaccion',
                   type: 'POST',
                   data: formData,
                   contentType: false,
                   processData: false,
                   success: function (response) {
                       alert("se inserto transaccion");
                       if (response.success) {
                           ///// REgistrar el detalle del pedido
                           ultimo_idTransaccion = response.registro.id_transaccion;
                           
                           alert(ultimo_idTransaccion);

                           var ProductosSeleccionados = $("#jqGrid").jqGrid('getGridParam', 'data');
                           var datosAEnviar = {
                               DatosGrilla: ProductosSeleccionados,
                               UltimaTransaccion: ultimo_idTransaccion,

                           };


                           $.ajax({
                               url: '/Almacen/RegistrarDetalleTransaccion',
                               type: 'POST',
                               contentType: 'application/json',
                               data: JSON.stringify(datosAEnviar),
                               success: function (response) {
                                   alert("se inserto detalle_t");

                               },
                               error: function (error) {
                                   // Manejar el error aquí
                                   console.error('Error en la solicitud Ajax:', error);
                               }
                           });
                       }


                   },
                   error: function (error) {
                       // Manejar el error aquí
                       console.error('Error en la solicitud Ajax:', error);
                   }
               });


           })


       })
   </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterContent" runat="server">
    
    
</asp:Content>