<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WF_Home.aspx.cs" Inherits="Practicando_parcial.Views.Home.WF_Home" MasterPageFile="~/Site1.Master" %>

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
       
 
<%----Boostrarp--%>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    

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
    
<div id="container" class="container mt-5 mb-4">
    <div class="jumbotron">
        <h1 class="display-4">¡Bienvenido a Monitoreo.Sac!</h1>
        <p class="lead">Explora nuestras funciones y descubre lo que tenemos para tu negocio.</p>
        <hr class="my-4">
        <p>Una empresa hecha para tus necesidades de monitoreo ¡Esperamos que disfrutes las funcionalidades!</p>
    </div>
</div>

   
</asp:Content>



<%------------footer--%>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterContent" runat="server">
    
    
</asp:Content>
