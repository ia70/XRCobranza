// DEPENDENCIES -------------------------------------------------------
import React from "react";
import {
    BrowserRouter as Router,
    Switch,
    Route,
    Link
} from "react-router-dom";

// COMPONENTS ---------------------------------------------------------
import Dashboard from './Views/Global/Dashboard/Dashboard.jsx';
import CarteraClientes from './Views/Global/CarteraClientes/CarteraClientes.jsx';
import Cobrar from './Views/Global/Cobrar/Cobrar.jsx';
import EstadoSolicitud from './Views/Jobs/EstadoSolicitud/EstadoSolicitud.jsx';
import SolicitarDinero from './Views/Jobs/SolicitarDinero/SolicitarDinero.jsx';
import NuevoCliente from './Views/Global/NuevoCliente/NuevoCliente.jsx';
import NuevoCredito from './Views/Private/NuevoCredito/NuevoCredito.jsx';
import Login from './Views/Global/Login/Login.jsx';
import CorteDia from './Views/Private/CorteDia/CorteDia.jsx';
import SinPagoHoy from './Views/Private/SinPago/SinPagoHoy.jsx';


export default function App() {
    return (
        <Router>
                <Switch>
                    <Route path="/carteraclientes" component={CarteraClientes} />
                    <Route path="/cobrar" component={Cobrar} />
                    <Route path="/estadosolicitud" component={EstadoSolicitud} />
                    <Route path="/solicitardinero" component={SolicitarDinero} />
                    <Route path="/nuevocliente" component={NuevoCliente} />
                    <Route path="/dashboard" component={Dashboard} />
                    <Route path="/nuevocredito" component={NuevoCredito} />
                    <Route path="/cortedia" component={CorteDia} />
                    <Route path="/sinpagohoy" component={SinPagoHoy} />
                    <Route path="/" component={Login} />
                </Switch>
        </Router>
    );
}