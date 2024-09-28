<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WF_ListarIngresoAlmacen.aspx.cs" Inherits="Practicando_parcial.Views.Almacen.WF_ListarIngresoAlmacen" MasterPageFile="~/Site1.Master" %>

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
   <div id="EditarTransaccion" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"  >
	  <div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<h5 class="modal-title">Detalle de Transaccion</h5>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			  <span aria-hidden="true">&times;</span>
			</button>
		  </div>

		  <div class="modal-body">
			<p>Modal body text goes here.</p>

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



             


		  </div>
		  <div class="modal-footer">
			<button id="BtnCerraModal" type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			<button id="BtnGuardarCambios" type="button" class="btn btn-primary">Guardar cambios</button>
		  </div>
		</div>
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
		         <table id="jqGrid3"></table>
		         <div id="jqGridPager3"></div>
		    </div>


		  </div>
		  <div class="modal-footer">
			<button id="BtnCerraModal3" type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			
		  </div>
		</div>
	  </div>
	</div>


     <%----------------------------------------------------%>

     <%--       model--%>
   <div id="EditarDetalleTransaccion" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"  >
	  <div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<h5 class="modal-title">Detalle de Pedido</h5>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			  <span aria-hidden="true">&times;</span>
			</button>
		  </div>

		  <div class="modal-body">
			<p>Editar Detalle transaccion.</p>

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
			<button id="BtnCerraModal4" type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			<button id="BtnGuardarCambios4" type="button" class="btn btn-primary">Guardar cambios</button>
		  </div>
		</div>
	  </div>
	</div>


     <%----------------------------------------------------%>

    <script type="text/javascript">

        $(document).ready(function () {

            var id_transaccion;
            var id_detalle_transaccion;

            $("#jqGrid").jqGrid({
                datatype: "local",
                colModel: [
                    { label: "ID TRANSACCION", name: "id_transaccion", key: true, width: 75 },
                    { label: "TIPO TRANSACCION", name: "transaccion", width: 150 },
                    { label: "ALMACEN", name: "almacen", width: 150 },
                    { label: "USUARIO", name: "usuario", width: 150 },
                    { label: "FECHA", name: "fecha", width: 150 },
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

            $("#jqGrid3").jqGrid({
                datatype: "local",
                colModel: [
                    { label: "ID DETALLE TRANSACCION", name: "id_detalle_transaccion", key: true, width: 75 },
                    { label: "ID PRODUCTO", name: "id_producto",  width: 75 },
                    { label: "PRODUCTO", name: "producto", width: 150 },
                    { label: "CANTIDAD", name: "cantidad", width: 150 },
                    { label: "ACTUALIZAR", name: "actualizar", width: 100, formatter: updateButtonFormater3 },
                    { label: "ELIMINAR", name: "eliminar", width: 100, formatter: deleteButtonFormater3 },


                ],
                pager: "#jqGridPager3",
                height: 400,
                width: 650,
                rowNum: 50,
                viewrecords: true,

            });

            // funciones para el jqgrid 1
            function selectButtonFormater(cellValue, options, rowObject) {
                return "<button type='button' class='btn-select' data-id='" + rowObject.id_transaccion + "'   > seleccionar </button>";
            }
            function deleteButtonFormater(cellValue, options, rowObject) {
                return "<button type='button' id='btnBorrar' class='btn-delete' data-id='" + rowObject.id_transaccion + "'   > eliminar </button>";
            }
            function updateButtonFormater(cellValue, options, rowObject) {
                return "<button type='button' id='btnActualizar' class='btn-update' data-id='" + rowObject.id_transaccion + "'   > editar </button>";
            }

            function detalleButtonFormater(cellValue, options, rowObject) {
                return "<button type='button'  id='btnDetalle' class='btn-select' data-id='" + rowObject.id_transaccion + "'   > ver detalle </button>";
            }

            // funcionees para jqgrid3
            function updateButtonFormater3(cellValue, options, rowObject) {
                return "<button type='button' id='btnActualizar3' class='btn-update' data-id='" + rowObject.id_detalle_transaccion + "'   > editar </button>";
            }

            function deleteButtonFormater3(cellValue, options, rowObject) {
                return "<button type='button'  id='btnBorrar3' class='btn-select' data-id='" + rowObject.id_detalle_transaccion + "'   > eliminar </button>";
            }



            $.ajax({
                url: '/Almacen/ListarTransaccion',
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

            // boton abrir modal edit
            $("#jqGrid").on('click', '#btnActualizar', function () {
                $("#EditarTransaccion").modal('show');
                id_transaccion = $(this).closest('tr').attr('id');
                alert(id_transaccion);


            })

            //Boton cerrar modal edit pedido
            $("#BtnCerraModal").on("click", function () {
                event.preventDefault(); // Evitar el comportamiento predeterminado del botón

                console.log("Función llamada");
                $("#EditarTransaccion").modal('hide');
            });

            // boton para hacer el update a la transaccion
            $("#BtnGuardarCambios").on("click", function (event) {
                event.preventDefault();

                var formData3 = new FormData();

                formData3.append("id_transaccion", id_transaccion);
                formData3.append("id_almacen", $("#ddlCodAlmacen").val());
                formData3.append("id_tipo_transaccion", $("#ddlTipoTransaccion").val());


                $.ajax({
                    type: "POST",
                    url: "/Almacen/ActualizarTransaccion",
                    data: formData3,
                    contentType: false,
                    processData: false,
                    success: function (response) {

                        alert("el pedido se actualizo correctamente");

                        $.ajax({
                            url: '/Almacen/ListarTransaccion',
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

            // boton para eliminar una transaccion
            $("#jqGrid").on('click', '#btnBorrar', function () {
                id_transaccion = $(this).data("id");

                $.ajax({
                    url: '/Almacen/EliminarTransaccion',
                    type: 'POST',
                    data: { id_transaccion: id_transaccion },
                    dataType: 'Json',
                    success: function (response) {
                        alert("se elimino exitosamente");
                        $.ajax({
                            url: '/Almacen/ListarTransaccion',
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

            });

            // boton abrir modal detalle
            $("#jqGrid").on('click', '#btnDetalle', function () {
                $("#DetalleModal").modal('show');
                id_transaccion = $(this).closest('tr').attr('id');
                alert(id_transaccion);

                //// Traer el detalle al jqgrid
                $.ajax({
                    url: '/Almacen/BuscarDetalleTransaccion',
                    type: 'GET',
                    data: { id_transaccion: id_transaccion },
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

            //Boton cerrar modal detalle
            $("#BtnCerraModal3").on("click", function () {
                event.preventDefault(); // Evitar el comportamiento predeterminado del botón

                console.log("Función llamada");
                $("#DetalleModal").modal('hide');
            });

            // boton abrir modal editar detalle transaccion
            $("#jqGrid3").on('click', '#btnActualizar3', function () {
                $("#EditarDetalleTransaccion").modal('show');
                id_detalle_transaccion = $(this).closest('tr').attr('id');
                alert(id_transaccion);


            })

            //Boton cerrar modal editar detalle transaccion
            $("#BtnCerraModal4").on("click", function () {
                event.preventDefault(); // Evitar el comportamiento predeterminado del botón

                console.log("Función llamada");
                $("#EditarDetalleTransaccion").modal('hide');
            });

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


            // Actualizar Detalle transaccion
            $("#BtnGuardarCambios4").on("click", function (event) {

                event.preventDefault();

                var formData = new FormData();

                var selectedValue = $("#ddlProducto").val();

                formData.append("id_detalle_transaccion", id_detalle_transaccion);
                formData.append("id_producto", selectedValue);
                formData.append("cantidad", $("#<%= TxtCantidad.ClientID %>").val());

                $.ajax({
                    type: "POST",
                    url: "/Almacen/ActualizarDetalleTransaccion",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        alert("el usuario se actualizo correctamente");

                        $.ajax({
                            url: '/Almacen/BuscarDetalleTransaccion',
                            type: 'GET',
                            data: { id_transaccion: id_transaccion },
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
                       

                    },
                    error: function (error) {
                        alert("Error en registro: " + error.responseText);
                    }

                });


            })

            // boton  borrar detalle transaccion
            $("#jqGrid3").on('click', '#btnBorrar3', function () {

                id_detalle_transaccion = $(this).closest('tr').attr('id');

                var formData2 = new FormData();

                formData2.append("id_detalle_transaccion", id_detalle_transaccion);

                $.ajax({
                    type: "POST",
                    url: "/Almacen/EliminarDetalleTransaccion",
                    data: formData2,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        alert("el detalle transaccion se elimino correctamente");

                        $.ajax({
                            url: '/Almacen/BuscarDetalleTransaccion',
                            type: 'GET',
                            data: { id_transaccion: id_transaccion },
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


                    },
                    error: function (error) {
                        alert("Error en registro: " + error.responseText);
                    }

                });


            })

        })
    </script>
</asp:Content>