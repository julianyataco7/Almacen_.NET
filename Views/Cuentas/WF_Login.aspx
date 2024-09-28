<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WF_Login.aspx.cs" Inherits="Practicando_parcial.Views.Cuentas.WF_Login" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
     
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
       <script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>

    <style>

        footer {
            background-color: #3396FF;
            color: #FFFFFF;
            padding: 10px 0;
            text-align: center;
        }
    </style>

    <nav class="navbar navbar-expand-lgnavbar-light bg-primary">
        <a class="navbar-brand" href="#">
            <img src="IMG/pedidos.jpg" alt="Logo" height="40" width="50" class="d-inline-block align-top">
           
        </a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nav>
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
        
       <h1 class="text-center">Bienvenido a Monitoreosac</h1>

       
            <div class="form-group">
                <label for="TextBox1">Usuario:</label>
                <asp:TextBox ID="TxtUsuario" runat="server" CssClass="form-control" Width="300"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="TextBox2">Contraseña:</label>
                <asp:TextBox ID="TxtContraseña" runat="server" TextMode="Password" CssClass="form-control" Width="300"></asp:TextBox>
            </div>

            <div class="form-group >
                <div class="d-flex justify-content-between">
                    <asp:Button ID="BtnIngresar" runat="server" Text="Ingresar" CssClass="btn btn-primary" style="margin-top: 8px;" />
                    <asp:Button ID="BtnCrearUsuario" runat="server" Text="Crear Usuario" CssClass="btn btn-secondary" style="margin-top: 8px;"/>
                </div>
            </div>

          <div></div>
               
       

     <script type="text/javascript">
        $(document).ready(function () {

 

            $("#<%= BtnIngresar.ClientID %>").click(function (e) {
                e.preventDefault();
                var formData = new FormData();
                formData.append("usuario", $("#<%= TxtUsuario.ClientID %>").val());
               formData.append("contraseña", $("#<%= TxtContraseña.ClientID %>").val());
               $.ajax({
                   type: "POST",
                   url: "/Cuentas/Autenticar2",
                   data: formData,
                   contentType: false,
                   processData: false,

                   success: function (response) {
                       if (response.success) {
                           if (response.registro == 1) {

                               $.ajax({
                                   type: "POST",
                                   url: "/Cuentas/Redirect_Home",

                                   success: function (response) {
                                       if (response.success) {
                                           window.location.href = response.redirectUrl;
                                       } else {

                                           alert('Error al ingresar. Verifica tus credenciales.');
                                       }
                                   },
                                   error: function (error) {
                                       alert("Error en la solicitud: " + error.responseText);
                                   }
                               });




                           }

                           else {
                               alert("Usuario y contraseña invalida");
                           }


                       } else {
                           
                           alert('Error al ingresar. Verifica tus credenciales.');
                       }
                   },
                   error: function (error) {
                       alert("Error en la solicitud: " + error.responseText);
                   }
               });
            });


            $("#<%= BtnCrearUsuario.ClientID %>").click(function (e) {
                e.preventDefault();


                          $.ajax({
                              type: "POST",
                              url: "/Cuentas/Redirect_register",
                             
                              success: function (response) {
                                  if (response.success) {
                                      window.location.href = response.redirectUrl;
                                  } else {

                                      alert('Error al ingresar. Verifica tus credenciales.');
                                  }
                              },
                              error: function (error) {
                                  alert("Error en la solicitud: " + error.responseText);
                              }
                          });
            });



        });
     </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterContent" runat="server">

</asp:Content>
