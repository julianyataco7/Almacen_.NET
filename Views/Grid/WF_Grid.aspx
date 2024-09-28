<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WF_Grid.aspx.cs" Inherits="Practicando_parcial.Views.Grid.WF_Grid" MasterPageFile="~/Site1.Master" %>

<%-------header--%>
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


     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>

     <!-- jqGrid CSS and JS references -->
	 <link href="http://trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" rel="stylesheet" />
	 <link href="http://trirand.com/blog/jqgrid/themes/ui.jqgrid.css" rel="stylesheet" />
	 <link href="http://trirand.com/blog/jqgrid/themes/ui.multiselect.css" rel="stylesheet" />
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
    
   
<%--    -----barra superior--%>
    <nav class="navbar navbar-expand-lgnavbar-light bg-primary">
        <a class="navbar-brand" href="#">
           
        </a>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nav>
</asp:Content>

<%-------body--%>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        
       <h1 class="text-center">Registro de Usuario</h1>

       
            <div class="form-group">
                <label for="TextBox1">Usuario:</label>
                <asp:TextBox ID="TxtUsuario" runat="server" CssClass="form-control" Width="300"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="TextBox2">Contraseña:</label>
                <asp:TextBox ID="TxtContraseña" runat="server" TextMode="Password" CssClass="form-control" Width="300"></asp:TextBox>
            </div>

             <div class="form-group">
                <label for="TextBox2">Confimar Contraseña:</label>
                <asp:TextBox ID="TxtConfirmacionContraseña" runat="server" TextMode="Password" CssClass="form-control" Width="300"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="TextBox1">Correo Electrónico:</label>
                <asp:TextBox ID="TxtEmail" runat="server" CssClass="form-control" Width="300"></asp:TextBox>

            </div>

             <div class="form-group form-check">
                        <asp:CheckBox ID="CbCondiciones"  runat="server" CssClass="form-check-input"/>
                        <label class="form-check-label" for="CheckBoxTerminos" >Usted acepta los terminos y condiciones</label>
                    </div>

           
                <div class="d-flex justify-content-between">
                    <asp:Button ID="BtnRegistrar" runat="server" Text="Crear Usuario" CssClass="btn btn-primary"  style="margin-top: 8px;"/>
                    <button id="BtnRedirect" class="btn btn-primary mb-3" >Ir a home</button>
                    <asp:Button ID="BtnSeguridad" runat="server" Text="Crear Usuario Seguridad" CssClass="btn btn-primary"  style="margin-top: 8px;"/>
                </div>
         
 
            

    </div>

    <asp:HiddenField ID="HiddenField1" runat="server" />

    <%--       colocar la grilla--%>
        <div style="padding:40px">
         <button id="BtnExportar" class="btn btn-primary mb-3" >Exportar a Excel</button>
		 <table id="jqGrid"></table>
		 <div id="jqGridPager"></div>
		</div>


     <script type="text/javascript">


         console.log("fuutt");

         $(document).ready(function () {

            



             $("#<%= BtnRegistrar.ClientID %>").click(function (e) {

                 e.preventDefault();


                 var formData = new FormData();

                 formData.append("usuario", $("#<%= TxtUsuario.ClientID %>").val());
                    formData.append("contraseña", $("#<%= TxtContraseña.ClientID %>").val());
                    formData.append("email", $("#<%= TxtEmail.ClientID %>").val());



                $.ajax({
                    type: "POST",
                    url: "/Cuentas/AgregarUsuario",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        alert("el usuario se creo correctamente");
                       

                    },
                    error: function (error) {
                        alert("Error en registro: " + error.responseText);
                    }

                });


            });

             var dataObjeto = $("#<%= HiddenField1.ClientID %>").val();
             var usuariosData = JSON.parse(dataObjeto);

             $("#jqGrid").jqGrid({
                 datatype: "local",
                 data: usuariosData,
                 colModel: [
                     { label: "ID_USUARIO", name: "id_usuario", key: true, width: 75 },
                     { label: "USUARIO", name: "usuario", width: 150 },
                     { label: "Correo Electrónico", name: "email", width: 150 },
                     { label: "Select", name: "Select", width: 100, formatter: selectButtonFormater },
                     { label: "Edit", name: "edit", width: 70, formatter: editButtonFormater },
                     { label: "Delete", name: "delete", width: 70, formatter: deleteButtonFormater }



                 ],
                 pager: "#jqGridPager",
                 height: 200,
                 width: 900,
                 rowNum: 20,
                 viewrecords: true
             });

             function selectButtonFormater(cellValue, options, rowObject) {
                 return "<button type='button' class='btn-select' data-id='" + rowObject.id_usuario + "'   > Seleccionar </button>";
             }

             function editButtonFormater(cellValue, options, rowObject) {
                 return "<button type='button' class='btn-edit' data-id='" + rowObject.id_usuario + "'   > Editar </button>";
             }

             function deleteButtonFormater(cellValue, options, rowObject) {
                 return "<button type='button' class='btn-delete' data-id='" + rowObject.id_usuario + "'   > Eliminar </button>";
             }

             $("#BtnExportar").click(function () {
                 $.ajax({
                     url: '/Grid/ExportarAExcel',
                     type: 'GET',
                     success: function (response) {
                         window.location = '/Grid/DescargarExcel?archivo=' + response.fileName;
                     },
                     error: function () {
                         alert("Error al exportar a excel");
                     }
                 });
             });

             $("#BtnRedirect").click(function () {
                 $.ajax({
                     url: '/Grid/Redirect_login',
                     type: 'POST',
                     success: function (response) {
                         window.location.href = response.redirectUrl;
                     },
                     error: function () {
                         alert("Error al exportar a excel");
                     }
                 });
             });


         });


     </script>
    <div></div>
     <div></div>
</asp:Content>

<%-------footer--%>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterContent" runat="server">

</asp:Content>