<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WF_listarPedidos.aspx.cs" Inherits="Practicando_parcial.Views.Pedido.WF_listarPedidos"  MasterPageFile="~/Site1.Master"%>

<%------------header--%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

<%------------estilos--%>
   <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Establece el alto mínimo de la ventana para que el footer se mantenga en la parte inferior */
        }

        content {
            flex: 1; /* Permite que el contenido ocupe el espacio restante */
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


 <!-- Barra de navegación -->
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

<%------------body--%>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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

    </style>
<%------------style--%>
    <div id= "container" class="container mt-5">
        <h1>Monitoreo de Pedidos</h1>
     <%--       colocar la grilla--%>
            <div style="padding:40px">
		         <table id="jqGrid"></table>
		         <div id="jqGridPager"></div>
		    </div>

    </div>
   <%----------------------------------------------------%>

      <%--       model--%>
   <div id="DetalleModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"  >
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
			<button id="BtnCerraModal" type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			
		  </div>
		</div>
	  </div>
	</div>


     <%----------------------------------------------------%>

       <%----------------------------------------------------%>

      <%--       model--%>
   <div id="DetalleModal2" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"  >
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

              <%--              producto--%>
              <div class="form-group mb-4">
                <label for="ddl">Producto:</label>
              <select id="ddlProducto" class="form-control" style="width: 300px;"></select>
    
            </div>

 <%--             cantidad--%>
 
             <div class="form-group">
                <label for="TextBox2">Cantidad:</label>
                <asp:TextBox ID="TxtCantidad" runat="server"  CssClass="form-control" Width="300"></asp:TextBox>
             </div>


		  </div>
		  <div class="modal-footer">
			<button id="BtnCerraModal2" type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			<button id="BtnGuardarCambios2" type="button" class="btn btn-primary">Guardar cambios</button>
		  </div>
		</div>
	  </div>
	</div>


     <%----------------------------------------------------%>
           <%----------------------------------------------------%>

      <%--       model--%>
   <div id="PedidoModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"  >
	  <div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<h5 class="modal-title">Editar Pedido</h5>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			  <span aria-hidden="true">&times;</span>
			</button>
		  </div>

		  <div class="modal-body">
			<p>Modal body text goes here.</p>

              <%--              estado Proceso--%>
              <div class="form-group mb-4">
                   <label for="EstadoProceso">Estado de Proceso:</label>
                 <select id="ddlEstadoProceso" class="form-control" width="300">
                    <option value="0">Falta</option>
                    <option value="1">Completo</option>
               </select>
    
            </div>

              
              <%--              estado Pago--%>
              <div class="form-group mb-4">
                   <label for="EstadoPago">Estado de Pago:</label>
                 <select id="ddlEstadoPago"  class="form-control" width="300" >
                    <option value="0">Deuda</option>
                    <option value="1">Pagado</option>
               </select>
    
            </div>

 


		  </div>
		  <div class="modal-footer">
			<button id="BtnCerraModal3" type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			<button id="BtnGuardarCambios3" type="button" class="btn btn-primary">Guardar cambios</button>
		  </div>
		</div>
	  </div>
	</div>


     <%----------------------------------------------------%>

    <script type="text/javascript">

        $(document).ready(function () {

            var selectIdPedido;
            var selectIdPedidoDt;

            $("#jqGrid").jqGrid({
                datatype: "local",
                colModel: [
                    { label: "ID PEDIDO", name: "id_pedido", key: true, width: 75 },
                    { label: "FECHA", name: "fecha", width: 150 },
                    { label: "ID_PROVEEDOR", name: "id_proveedor", width: 150 },
                    { label: "ESTADO DE PROCESO", name: "estado_proceso", width: 150 },
                    { label: "ESTADO DE PAGO", name: "estado_pago", width: 150 },
                    { label: "ID USUARIO", name: "id_usuario", width: 150 },
                    { label: "ACTUALIZAR", name: "actualizar", width: 100, formatter: updateButtonFormater },
                    { label: "ELIMINAR", name: "eliminar", width: 100, formatter: deleteButtonFormater },
                    { label: "VER DETALLE", name: "ver detalle", width: 100, formatter: detalleButtonFormater }


                ],
                pager: "#jqGridPager",
                height: 600,
                width: 900,
                rowNum: 50,
                viewrecords: true,

            });


            function selectButtonFormater(cellValue, options, rowObject) {
                return "<button type='button' class='btn-select' data-id='" + rowObject.id_pedido + "'   > seleccionar </button>";
            }
            function deleteButtonFormater(cellValue, options, rowObject) {
                return "<button type='button' id='btnBorrar' class='btn-delete' data-id='" + rowObject.id_pedido + "'   > eliminar </button>";
            }
            function updateButtonFormater(cellValue, options, rowObject) {
                return "<button type='button' id='btnActualizar' class='btn-update' data-id='" + rowObject.id_pedido + "'   > editar </button>";
            }
           
            function detalleButtonFormater(cellValue, options, rowObject) {
                return "<button type='button'  id='btnDetalle' class='btn-select' data-id='" + rowObject.id_pedido + "'   > ver detalle </button>";
            }

            $.ajax({
                url: '/Pedido/ListarPedidos',
                type: 'GET',
                dataType: 'json',
                success: function (response) {
                    if (response.success) {

                        $("#jqGrid").jqGrid('clearGridData');
                        $("#jqGrid").jqGrid('setGridParam', { data: response.registro });
                        $("#jqGrid").trigger('reloadGrid', [{ current: true }]);
                        alert("Sí pasó");

                    }

                },
                error: function (error) {
                    // Manejar el error aquí
                    console.error('Error en la solicitud Ajax:', error);
                }
            });

            $("#jqGrid2").jqGrid({
                datatype: "local",
                colModel: [
                    { label: "ID DETALLEPEDIDO", name: "id_detalle", key: true, width: 75 },
                    { label: "ID PEDIDO", name: "id_pedido", width: 150 },
                    { label: "ID_PRODUCTO", name: "id_producto", width: 150 },
                    { label: "NOMBRE DEL PRODUCTO", name: "producto", width: 150 },
                    { label: "CANTIDAD", name: "cantidad", width: 150 },
                    { label: "ACTUALIZAR", name: "actualizar", width: 100, formatter: updateButtonFormater2 },
                    { label: "ELIMINAR", name: "eliminar", width: 100, formatter: deleteButtonFormater2 },

                ],
                pager: "#jqGridPager",
                height: 200,
                width: 720,
                rowNum: 20,
                viewrecords: true,

            });

            function updateButtonFormater2(cellValue, options, rowObject) {
                return "<button type='button' id='btnActualizar2' class='btn-update' data-id='" + rowObject.id_detalle + "'   > editar </button>";
            }

            function deleteButtonFormater2(cellValue, options, rowObject) {
                return "<button type='button' id='btnEliminar2' class='btn-delete' data-id='" + rowObject.id_detalle + "'   > eliminar </button>";
            }


            // abrir modal pedido editar
            $("#jqGrid").on('click', '#btnActualizar', function () {
                event.preventDefault();
                $("#PedidoModal").modal('show');

                selectIdPedido = $(this).data("id");
                aleert("el id seleccionado es " + selectIdPedido)


            })

            // Aplicar edidcion a pedido
            $("#BtnGuardarCambios3").on("click", function (event) {
                event.preventDefault();

                var selectPago = $("#ddlEstadoPago").val();
                var selectProceso = $("#ddlEstadoProceso").val();

                alert("estado pago = " + selectPago + " \n" + "estado proceso = " + selectProceso);
                var formData3 = new FormData();

                formData3.append("estado_pago", selectPago);
                formData3.append("estado_proceso", selectProceso);
                formData3.append("id_pedido", selectIdPedido);
                

                $.ajax({
                    type: "POST",
                    url: "/Pedido/Actualizar_Pedido",
                    data: formData3,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        alert("el pedido se actualizo correctamente");

                        $.ajax({
                            url: '/Pedido/ListarPedidos',
                            type: 'GET',
                            dataType: 'json',
                            success: function (response) {
                                if (response.success) {

                                    $("#jqGrid").jqGrid('clearGridData');
                                    $("#jqGrid").jqGrid('setGridParam', { data: response.registro });
                                    $("#jqGrid").trigger('reloadGrid', [{ current: true }]);
                                    alert("Sí pasó");

                                }

                            },
                            error: function (error) {
                                // Manejar el error aquí
                                console.error('Error en la solicitud Ajax:', error);
                            }
                        });
                       

                    },
                    error: function (error) {
                        alert("Error en registro: " + error.responseText);
                    }

                });
            })


            //Boton cerrar modal edit pedido
            $("#BtnCerraModal3").on("click", function () {
                event.preventDefault(); // Evitar el comportamiento predeterminado del botón

                console.log("Función llamada");
                $("#PedidoModal").modal('hide');
            });

            // boton abrir modal detalle
            $("#jqGrid").on('click', '#btnDetalle', function () {
                $("#DetalleModal").modal('show');

                 selectIdPedido = $(this).data("id");
                alert("el id seleccionado es" + selectIdPedido);

              


                //// Traer el detalle al jqgrid
                $.ajax({
                    url: '/Pedido/Buscar_detalle',
                    type: 'GET',
                    data: { id_pedido: selectIdPedido },
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

            //Boton cerrar modal principal
            $("#BtnCerraModal").on("click", function () {
                event.preventDefault(); // Evitar el comportamiento predeterminado del botón

                console.log("Función llamada");
                $("#DetalleModal").modal('hide');
            });

            //Boton para borrar pedido
            $("#jqGrid").on('click', '#btnBorrar', function () {
                selectIdPedido = $(this).data("id");

                $.ajax({
                    url: '/Pedido/Eliminar_pedido',
                    type: 'POST',
                    data: { id_pedido: selectIdPedido },
                    dataType: 'Json',
                    success: function (response) {
                        alert("se elimino exitosamente");
                        $.ajax({
                            url: '/Pedido/ListarPedidos',
                            type: 'GET',
                            dataType: 'json',
                            success: function (response) {
                                if (response.success) {

                                    $("#jqGrid").jqGrid('clearGridData');
                                    $("#jqGrid").jqGrid('setGridParam', { data: response.registro });
                                    $("#jqGrid").trigger('reloadGrid', [{ current: true }]);
                                    alert("Sí pasó");

                                }

                            },
                            error: function (error) {
                                // Manejar el error aquí
                                console.error('Error en la solicitud Ajax:', error);
                            }
                        });

                    },
                    error: function (error) {
                        // Manejar el error aquí
                        console.error('Error en la solicitud Ajax:', error);
                    }
                });


            })

            // boton actualizar el detalle y abre el modal  secundario (detalle del pedido)
            $("#jqGrid2").on('click', '#btnActualizar2', function () {

                $("#DetalleModal2").modal('show');
                selectIdPedidoDt = $(this).data("id");
                alert("el id del detalle es: " + selectIdPedidoDt)
                // ajax para traer los productos al combo

                $.ajax({
                    type: "GET",
                    url: "/Pedido/ListarProductoCbo",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#ddlProducto").empty();
                        // Manejar la respuesta y llenar el DropDownList
                        for (var i = 0; i < response.registro.length; i++) {
                            var lista = response.registro[i];

                            // Agregar una opción al DropDownList
                            $("#ddlProducto").append($("<option></option>")
                                .attr("value", lista.id_producto)
                                .text(lista.producto));
                        }

                    },
                    error: function (error) {
                        console.log(error);
                    }
                });

               

                $("#BtnGuardarCambios2").on("click", function (event) {
                    event.preventDefault();
                   

                    var formData = new FormData();

                    var selectedValue = $("#ddlProducto").val();

                    formData.append("id_producto", selectedValue);
                    formData.append("cantidad", $("#<%= TxtCantidad.ClientID %>").val());
                    formData.append("id_pedido", selectIdPedido);
                    formData.append("id_detalle", selectIdPedidoDt);


                    $.ajax({
                        type: "POST",
                        url: "/Pedido/Actualizar_detalleP",
                        data: formData,
                        contentType: false,
                        processData: false,
                        success: function (response) {
                            alert("el usuario se actualizo correctamente");

                            $.ajax({
                                url: '/Pedido/Buscar_detalle',
                                type: 'GET',
                                data: { id_pedido: selectIdPedido },
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

                        },
                        error: function (error) {
                            alert("Error en registro: " + error.responseText);
                        }

                    });

                })
                    


                
               


            })

            //Boton Eliminar detalle Pedido

            $("#jqGrid2").on('click', '#btnEliminar2', function () {

                selectIdPedidoDt = $(this).data("id");

                var formData2 = new FormData();

                formData2.append("id_pedido", selectIdPedido);
                formData2.append("id_detalle", selectIdPedidoDt);


                $.ajax({
                    type: "POST",
                    url: "/Pedido/Eliminar_detalleP",
                    data: formData2,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        alert("el usuario se elimino correctamente");

                        $.ajax({
                            url: '/Pedido/Buscar_detalle',
                            type: 'GET',
                            data: { id_pedido: selectIdPedido },
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

                    },
                    error: function (error) {
                        alert("Error en registro: " + error.responseText);
                    }

                });
            })


            //Boton cerrar modal secundario
            $("#BtnCerraModal2").on("click", function () {
                event.preventDefault(); // Evitar el comportamiento predeterminado del botón

                console.log("Función llamada");
                $("#DetalleModal2").modal('hide');
            });


            



           
        });




    </script>





</asp:Content>



<%------------footer--%>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterContent" runat="server">
    
    
</asp:Content>

