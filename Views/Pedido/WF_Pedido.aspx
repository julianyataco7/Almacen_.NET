<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WF_Pedido.aspx.cs" Inherits="Practicando_parcial.Views.Pedido.WF_Pedido" MasterPageFile="~/Site1.Master" %>

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
    
    
    <div id="container" class="container mt-5">
            <h2>Registro de Pedido</h2>

               <!-- Proveedor -->
             <div class="form-group  mb-4"" >
                <label for="TextBox2">Proveedor:</label>
                <asp:TextBox ID="TxtProveedor" runat="server" CssClass="form-control mb-2" Width="300"></asp:TextBox>
                <asp:Button ID="BtnProveedor" runat="server" Text="Buscar Proveedor" CssClass="btn btn-primary " Width="250" />
            </div>

            <!-- Estado de Proceso -->
            <div class="form-group mb-4">
                <label for="ddlEstadoProceso">Estado de Proceso:</label>
                <asp:DropDownList ID="ddlEstadoProceso" runat="server" CssClass="form-control" Width="300">
                    <asp:ListItem Text="En Proceso" Value="0" />
                    <asp:ListItem Text="Completado" Value="1" />
                </asp:DropDownList>
            </div>

            <!-- Estado de Pago -->
            <div class="form-group mb-4">
                <label for="ddlEstadoPago">Estado de Pago:</label>
                <asp:DropDownList ID="ddlEstadoPago" runat="server" CssClass="form-control" Width="300">
                    <asp:ListItem Text="Pendiente" Value="0" />
                    <asp:ListItem Text="Pagado" Value="1" />
                </asp:DropDownList>
            </div>

            <!-- Botón Registrar -->
            <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-success mb-4" Width="300" />

            <!-- Botones adicionales -->
            <div class="form-group mb-4">
                <div class="d-flex justify-content-between">
                    <asp:Button ID="BtnBuscarProducto" runat="server" Text="Buscar Producto" CssClass="btn btn-secondary" />
                    <asp:Button ID="BtnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-secondary" />
                    <asp:Button ID="BtnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-secondary" />
                </div>
            </div>
        </div>

     <%--       colocar la grilla--%>
        <div style="padding:40px">
            <table id="jqGrid"></table>
		 <div id="jqGridPager"></div>
		</div>

     <%--       model--%>
   <div id="BuscarModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"  >
	  <div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<h5 class="modal-title">Buscar Producto</h5>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			  <span aria-hidden="true">&times;</span>
			</button>
		  </div>

		  <div class="modal-body">
			<p>Modal body text goes here.</p>

<%--              categoria--%>
              <div class="form-group">
                     <label for="TextBox2">Categoría:</label>
                     <div class="input-group">
                        <asp:TextBox ID="TxtCategoria" runat="server" CssClass="form-control" Width="300"></asp:TextBox>
                        <div class="input-group-append">
                             <button id="BtnCategoria" class="btn btn-primary" style="margin-left: 10px;" >Buscar Categoría</button>
                         </div>
                    </div>
                </div>
 <%--             producto--%>
               <div class="form-group">
                     <label for="TextBox2">Producto:</label>
                     <div class="input-group">
                        <asp:TextBox ID="TxtProducto" runat="server" CssClass="form-control" Width="300"></asp:TextBox>
                        <div class="input-group-append">
                             <button id="BtnProducto" class="btn btn-primary" style="margin-left: 10px;">Buscar Producto</button>
                         </div>
                    </div>
                </div>
 <%--             cantidad--%>
 
             <div class="form-group">
                <label for="TextBox2">Cantidad:</label>
                <asp:TextBox ID="TxtCantidad" runat="server"  CssClass="form-control" Width="300"></asp:TextBox>
             </div>

              <%--       colocar la grilla--%>
            <div style="padding:40px">
		         <table id="jqGrid2"></table>
		         <div id="jqGridPager2"></div>
		    </div>


		  </div>
		  <div class="modal-footer">
			<button id="BtnCerraModal" type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			<button id="BtnGuardarCambios" type="button" class="btn btn-primary">Agregar</button>
		  </div>
		</div>
	  </div>
	</div>


     <%--       model 2--%>
   <div id="BuscarModal2" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"  >
	  <div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<h5 class="modal-title">Buscar Producto</h5>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			  <span aria-hidden="true">&times;</span>
			</button>
		  </div>

		  <div class="modal-body">
			<p>Modal body text goes here.</p>

<%--              proveedor--%>
              <div class="form-group">
                     <label for="TextBox2">Proveedor:</label>
                     <div class="input-group">
                        <asp:TextBox ID="TxtProveedor2" runat="server" CssClass="form-control" Width="300"></asp:TextBox>
                        <div class="input-group-append">
                             <button id="BtnProveedor2" class="btn btn-primary" style="margin-left: 10px;" >Buscar Proveedor</button>
                         </div>
                    </div>
                </div>
 

              <%--       colocar la grilla--%>
            <div style="padding:40px">
		         <table id="jqGrid3"></table>
		         <div id="jqGridPager3"></div>
		    </div>


		  </div>
		  <div class="modal-footer">
			<button id="BtnCerraModal2" type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			<button id="BtnGuardarCambios2" type="button" class="btn btn-primary">Agregar</button>
		  </div>
		</div>
	  </div>
	</div>


     <script type="text/javascript">

         console.log("Script cargado");
         $(document).ready(function () {

             // variables a utilizar en el script
             var filasSeleccionadas = [];
             var filasSeleccionadas2 = [];
             var obtenerIdProveedor;

             /////////////////////

             ////// MODAL BUSCAR PRODUCTO

             // boton buscar producto
            
                 $("#<%= BtnBuscarProducto.ClientID %>").click(function (event) {
                      event.preventDefault(); // Evitar el comportamiento predeterminado del botón

                     console.log("Función llamada");
                     $("#BuscarModal").modal('show');
                  });
             
             
             //Boton cerrar modal
             $("#BtnCerraModal").on("click", function () {
                 event.preventDefault(); // Evitar el comportamiento predeterminado del botón

                 console.log("Función llamada");
                 $("#BuscarModal").modal('hide');
             });

             /// mostrar Grilla en el modal producto

             $("#jqGrid2").jqGrid({
                 datatype: "local",
                 colModel: [
                     { label: "ID_PRODUCTO", name: "id_producto", key: true, width: 75 },
                     { label: "CATEGORIA", name: "categoria", width: 150 },
                     { label: "PRODUCTO", name: "producto", width: 150 },
                     { label: "COLOR", name: "color", width: 150 },
                     { label: "UNIDAD DE MEDIDA", name: "unidad_medida", width: 150 },

                     {
                         label: "CANTIDAD",
                         name: "cantidad",
                         width: 100,

                         formatter: selectcantidad
                     },
                     { label: "Select", name: "Select", width: 100, formatter: selectButtonFormater }

                 ],
                 pager: "#jqGridPager",
                 height: 200,
                 width: 900,
                 rowNum: 20,
                 viewrecords: true,
                 multiselect: true,
                 editurl: 'clientArray',

             });

             function selectButtonFormater(cellValue, options, rowObject) {
                 return "<button type='button' class='btn-select' data-id='" + rowObject.id_producto + "'   > Seleccionar </button>";
             }

             function selectcantidad(cellvalue, options, rowObject) {
                 return '<input data-id="' + rowObject.id_producto + '" type="text" value="' + "0" + '" class="edit-textbox form-control" />';
             }




             // Boton buscar por categoria
             $("#BtnCategoria").on("click", function () {
                 event.preventDefault(); 
                 alert("si funciona");

 
                 $.ajax({
                     url: '/Pedido/Buscar_Categoria',
                     type: 'GET',
                     data: { categoria: $("#<%= TxtCategoria.ClientID %>").val() },
                     dataType: 'Json',
                     success: function (response) {
                         if (response.success) {

                             $("#jqGrid2").jqGrid('clearGridData');
                             $("#jqGrid2").jqGrid('setGridParam', { data: response.registro });
                             $("#jqGrid2").trigger('reloadGrid', [{ current: true }]);
                             alert("Sí pasó");

                            

                            
                         }

                     },
                     error: function (error) {
                         // Manejar el error aquí
                         console.error('Error en la solicitud Ajax:', error);
                     }
                 });
             });

          // Boton buscar por producto
             $("#BtnProducto").on("click", function () {
                 event.preventDefault();
                 alert("si funciona");

                 $("#jqGrid2").jqGrid({
                     datatype: "local",
                     colModel: [
                         { label: "ID_PRODUCTO", name: "id_producto", key: true, width: 75 },
                         { label: "CATEGORIA", name: "categoria", width: 150 },
                         { label: "PRODUCTO", name: "producto", width: 150 },
                         { label: "COLOR", name: "color", width: 150 },
                         { label: "UNIDAD DE MEDIDA", name: "unidad_medida", width: 150 },
                         { label: "COLOR", name: "color", width: 150 },
                         { label: "COLOR", name: "color", width: 150 },
                         {
                             label: "CANTIDAD",
                             name: "cantidad",
                             width: 100,

                             formatter: selectcantidad
                         },
                         { label: "Select", name: "Select", width: 100, formatter: selectButtonFormater },

                     ],
                     pager: "#jqGridPager",
                     height: 200,
                     width: 900,
                     rowNum: 20,
                     viewrecords: true

                 });

                 function selectButtonFormater(cellValue, options, rowObject) {
                     return "<button type='button' class='btn-select' data-id='" + rowObject.id_producto + "'   > Seleccionar </button>";
                 }

                 function selectcantidad(cellvalue, options, rowObject) {
                     return '<input data-id="' + rowObject.id_producto + '" type="text" value="' + "0" + '" class="edit-textbox form-control" />';
                 }


                 $.ajax({
                     url: '/Pedido/Buscar_producto',
                     type: 'GET',
                     data: { producto: $("#<%= TxtProducto.ClientID %>").val() },
                     dataType: 'Json',
                     success: function (response) {
                         if (response.success) {
                           

                             $("#jqGrid2").jqGrid('clearGridData');
                             $("#jqGrid2").jqGrid('setGridParam', { data: response.registro });
                             $("#jqGrid2").trigger('reloadGrid', [{ current: true }]);
                             alert("Sí pasó");

                         }

                     },
                     error: function (error) {
                         // Manejar el error aquí
                         console.error('Error en la solicitud Ajax:', error);
                     }
                 });
             });

                //Grilla principal de pedido
             $("#jqGrid").jqGrid({
                 datatype: "local",
                
                 colModel: [
                     { label: "ID_PRODUCTO", name: "id_producto", key: true, width: 75 },
                     { label: "CATEGORIA", name: "categoria", width: 150 },
                     { label: "PRODUCTO", name: "producto", width: 150 },
                     { label: "COLOR", name: "color", width: 150 },
                     { label: "UNIDAD DE MEDIDA", name: "unidad_medida", width: 150 },
                     { label: "COLOR", name: "color", width: 150 },
                     { label: "CANTIDAD", name: "cantidad", width: 150, editable: false },
                     { label: "ELIMINAR", name: "eliminar", width: 100, formatter: deleteButtonFormater}


                 ],
                 pager: "#jqGridPager",
                 height: 200,
                 width: 1000,
                 rowNum: 20,
                 viewrecords: true

             });

             // evento para eliminar una fila del jqgrid principal
             $("#jqGrid").on('click', '#btnDelete', function () {
                 var rowId = $(this).closest('tr').attr('id');
                 $("#jqGrid").jqGrid('delRowData', rowId);
             });

             function deleteButtonFormater(cellValue, options, rowObject) {
                 return "<button type='button'  id='btnDelete' class='btn-delete' data-id='" + rowObject.id_producto + "'   > Eliminar </button>";
             }

             // Agregar a la grilla principal 
             $("#BtnGuardarCambios").on("click", function (event) {
                 event.preventDefault();
                 var datosFilasSeleccionadas = [];

                 var filasSeleccionadas = $("#jqGrid2").jqGrid('getGridParam', 'selarrrow');

                 for (var i = 0; i < filasSeleccionadas.length; i++) {
                     var id = filasSeleccionadas[i];
                     var rowData = $("#jqGrid2").jqGrid('getRowData', id);
                    // rowData.cantidad = $("#jqGrid2 input.edit-textbox").val();
                     rowData.cantidad = $("#jqGrid2 #" + id + " input.edit-textbox").val();
                     alert("el id seleccionado es" + id);
                     datosFilasSeleccionadas.push(rowData);
                 }

                 for (var j = 0; j < datosFilasSeleccionadas.length; j++) {
                     $("#jqGrid").jqGrid('addRowData', j + 1, datosFilasSeleccionadas[j]);
                 }



                 alert("IDs de filas seleccionadas: " + filasSeleccionadas.join(", "));


             });

                       ////// MODAL BUSCAR PROVEEDOR

             //Boton abrir modal proveedor
             $("#<%= BtnProveedor.ClientID %>").click(function (event) {
                 event.preventDefault(); // Evitar el comportamiento predeterminado del botón

                 console.log("Función llamada");
                 $("#BuscarModal2").modal('show');
             });

             //Boton cerrar modal proveedor
             $("#BtnCerraModal2").on("click", function () {
                 event.preventDefault(); // Evitar el comportamiento predeterminado del botón

                 console.log("Función llamada");
                 $("#BuscarModal2").modal('hide');
             });
             // Grilla modal proveedor

             $("#jqGrid3").jqGrid({
                 datatype: "local",
                 colModel: [
                     { label: "ID_PROVEEDOR", name: "id_proveedor", key: true, width: 75 },
                     { label: "NOMBRE", name: "nombre", width: 150 },
                     { label: "GALERIA", name: "galeria", width: 150 },
                     { label: "STAND", name: "stand", width: 150 },

                     { label: "Select", name: "Select", width: 100, formatter: selectButtonFormater }

                 ],
                 pager: "#jqGridPager",
                 height: 200,
                 width: 900,
                 rowNum: 20,
                 viewrecords: true,
                 multiselect: true,
                 editurl: 'clientArray',

             });

             function selectButtonFormater(cellValue, options, rowObject) {
                 return "<button type='button' class='btn-select' data-id='" + rowObject.id_proveedor + "'   > Seleccionar </button>";
             }

             /// Traer los datos de proveedor de la BBDD
             $("#BtnProveedor2").on("click", function () {
                 event.preventDefault();

                 $.ajax({
                     url: '/Pedido/Buscar_proveedor',
                     type: 'GET',
                     data: { nombre: $("#<%= TxtProveedor2.ClientID %>").val() },
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

             })

             $("#BtnGuardarCambios2").on("click", function (event) {
                 event.preventDefault();

                 var filasSeleccionadas2 = $("#jqGrid3").jqGrid('getGridParam', 'selarrrow');



                 for (var i = 0; i < filasSeleccionadas2.length; i++) {
                     var obtenerProveedor = $("#jqGrid3").jqGrid('getCell', filasSeleccionadas2[i], 'nombre');
                     obtenerIdProveedor = $("#jqGrid3").jqGrid('getCell', filasSeleccionadas2[i], 'id_proveedor');
                     document.getElementById('<%= TxtProveedor.ClientID %>').value = obtenerProveedor;

                     alert(obtenerIdProveedor);
                 }


             })

             $("#<%= btnRegistrar.ClientID %>").click(function (event) {
                 event.preventDefault();

                 var fechaHora = new Date().toISOString(); // devuelve en formato YYYY-MM-DDTHH:mm:ss.sssZ
                 var ultimo_idPedido;

                 var ddlPr = document.getElementById('<%= ddlEstadoProceso.ClientID %>');
                 var valorSeleccionado = ddlPr.options[ddlPr.selectedIndex].value;
                 var estado_proceso = valorSeleccionado

                 var ddlPg = document.getElementById('<%= ddlEstadoPago.ClientID %>');
                 var valorSeleccionado2 = ddlPg.options[ddlPg.selectedIndex].value;
                 var estado_pago = valorSeleccionado2;

                 var formData = new FormData();

                 formData.append("fecha", fechaHora);
                 formData.append("id_proveedor", obtenerIdProveedor);
                 formData.append("estado_proceso", estado_proceso);
                 formData.append("estado_pago", estado_pago);


                 $.ajax({
                     url: '/Pedido/Registrar_pedido',
                     type: 'POST',
                     data: formData,
                     contentType: false,
                     processData: false,
                      success: function (response) {
                          if (response.success) {
                              ///// REgistrar el detalle del pedido
                              ultimo_idPedido = response.registro.id_pedido;
                              alert("se inserto detalle_p");
                              alert(ultimo_idPedido);

                              var ProductosSeleccionados = $("#jqGrid").jqGrid('getGridParam', 'data');
                              var datosAEnviar = {
                                  DatosGrilla: ProductosSeleccionados,
                                  UltimoPedido: ultimo_idPedido,

                              };


                              $.ajax({
                                  url: '/Pedido/Registrar_pedidoDetalle',
                                  type: 'POST',
                                  contentType: 'application/json',
                                  data: JSON.stringify(datosAEnviar),
                                  success: function (response) {
                                      alert("se inserto detalle_p");

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



            

         });


 
        



      
     </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterContent" runat="server">

</asp:Content>
