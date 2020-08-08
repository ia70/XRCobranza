import React, { Component } from 'react';

//COMPONENTES
import BtnRounded from '../../../Components/Content/BtnRounded/BtnRounded.jsx';
import Navbar from '../../../Components/Content/Navbar/Navbar.jsx';
import { Title } from '../../../Components/Content/Title/Title.jsx';

// IMAGENES
import imgCarteraClientes from '../../../img/CarteraClientes.png';
import imgCobrar from '../../../img/Cobrar.png';
import imgNuevoCredito from '../../../img/NuevoCredito.png';
import imgSinPagoHoy from '../../../img/SinPagoHoy.png';
import imgClientesMorosos from '../../../img/ClientesMorosos.png';
import imgSesiones from '../../../img/Sesiones.png';
import imgRecuperacion from '../../../img/Recuperacion.png';
import imgCorteDia from '../../../img/CorteDia.png';
import imgFinanzas from '../../../img/Finanzas.png';
import imgRutas from '../../../img/Rutas.png';
import imgReportes from '../../../img/Reportes.png';
import imgUsuarios from '../../../img/Usuarios.png';
import imgClientes from '../../../img/Clientes.png';
import imgSolicitudes from '../../../img/Solicitudes.png';
import imgResumen from '../../../img/Resumen.png';
import imgCreditos from '../../../img/Creditos.png';
import imgEstadoSolicitud from '../../../img/EstadoSolicitud.png';
import imgNuevoCliente from '../../../img/NuevoUsuario.png';
import imgSolicitarDinero from '../../../img/SolicitarDinero.png';
import Logo from '../../../img/Logo.png';

// CSS
import './Dashboard.css';

class Dashboard extends Component {
    constructor(props) {
        super(props);

        this._menu = "";
        sessionStorage.setItem('route', 'dashboard');

        this.state = {
            login: sessionStorage.getItem('login'),
            user: sessionStorage.getItem('user'),
            sucursal: sessionStorage.getItem('sucursal'),
            hash: sessionStorage.getItem('hash'),
            rol: sessionStorage.getItem('rol')
        };

        this.handleEvento = this.handleEvento.bind(this);
    }

    handleEvento() {
        var opcion = confirm("¿Desea cerrar sesión?");
        if (opcion == true) {
            sessionStorage.clear();
            this.setState({ login: false });
        }

    }

    componentWillMount() {
        if (!sessionStorage.getItem('login') == true) {
            sessionStorage.clear();
            alert('¡Sesion bloqueada!');
            this.setState({ login: false });
        } else {
            if (this.state.rol == 1) {
                this._menu = <div className="row">
                    <Title title="ACCIONES RAPIDAS" />
                    <BtnRounded id='10' src={imgResumen} url="/carteraclientes" label="Resumen" />
                    <BtnRounded id='11' src={imgCobrar} url="/cobrar" label="Cobrar" />
                    <BtnRounded id='12' src={imgNuevoCredito} url="/nuevocredito" label="Nuevo credito" />
                    <BtnRounded id='13' src={imgNuevoCliente} url="/nuevocliente" label="Nuevo cliente" />
                    <BtnRounded id='14' src={imgCarteraClientes} url="/carteraclientes" label="Cartera de clientes" />
                    <BtnRounded id='15' src={imgCorteDia} url="/cortedia" label="Corte del dia" />

                    <Title title="SEGUIMIENTO" />
                    <BtnRounded id='20' src={imgSolicitudes} url="/nuevocliente" label="Solicitudes" />
                    <BtnRounded id='21' src={imgSinPagoHoy} url="/sinpagohoy" label="Adeudos" />
                    <BtnRounded id='22' src={imgClientesMorosos} url="/nuevocliente" label="Clientes Morosos" />
                    {//<BtnRounded id='23' src={imgRecuperacion} url="/nuevocliente" label="Recuperación" />
                    }

                    <Title title="AVANZADO" />
                    {//<BtnRounded id='30' src={imgSesiones} url="/nuevocliente" label="Adm. Sesiones" />
                    }
                    <BtnRounded id='31' src={imgCreditos} url="/carteraclientes" label="Creditos" />
                    <BtnRounded id='32' src={imgUsuarios} url="/carteraclientes" label="Usuarios" />
                    {//<BtnRounded id='33' src={imgClientes} url="/carteraclientes" label="Clientes" />
                    }
                    <BtnRounded id='34' src={imgRutas} url="/carteraclientes" label="Rutas" />
                    {//<BtnRounded id='35' src={imgFinanzas} url="/carteraclientes" label="Finanzas" />
                    }
                    {//<BtnRounded id='36' src={imgReportes} url="/carteraclientes" label="Reportes" />
                    }

                </div>
            } else if (this.state.rol == 4) {
                this._menu = <div className="row">
                    <Title title="ACCIONES RAPIDAS" />
                    <BtnRounded id='10' src={imgResumen} url="/carteraclientes" label="Resumen" />
                    <BtnRounded id='11' src={imgCobrar} url="/cobrar" label="Cobrar" />
                    <BtnRounded id='12' src={imgNuevoCredito} url="/nuevocliente" label="Nuevo credito" />
                    <BtnRounded id='13' src={imgNuevoCliente} url="/nuevocliente" label="Nuevo cliente" />
                    <BtnRounded id='14' src={imgCarteraClientes} url="/carteraclientes" label="Cartera de clientes" />
                    <BtnRounded id='15' src={imgCorteDia} url="/nuevocliente" label="Corte del dia" />

                    <Title title="SEGUIMIENTO" />
                    <BtnRounded id='20' src={imgSolicitudes} url="/nuevocliente" label="Solicitudes" />
                    <BtnRounded id='21' src={imgSinPagoHoy} url="/nuevocliente" label="Sin pago hoy" />
                    <BtnRounded id='22' src={imgClientesMorosos} url="/nuevocliente" label="Clientes Morosos" />
                    <BtnRounded id='23' src={imgRecuperacion} url="/nuevocliente" label="Recuperación" />

                    <Title title="AVANZADO" />
                    <BtnRounded id='30' src={imgSesiones} url="/nuevocliente" label="Adm. Sesiones" />
                    <BtnRounded id='31' src={imgCreditos} url="/carteraclientes" label="Creditos" />
                    <BtnRounded id='32' src={imgUsuarios} url="/carteraclientes" label="Usuarios" />
                    <BtnRounded id='33' src={imgClientes} url="/carteraclientes" label="Clientes" />
                    <BtnRounded id='34' src={imgRutas} url="/carteraclientes" label="Rutas" />
                    <BtnRounded id='35' src={imgFinanzas} url="/carteraclientes" label="Finanzas" />
                    <BtnRounded id='36' src={imgReportes} url="/carteraclientes" label="Reportes" />
                    <BtnRounded id='37' src={imgCarteraClientes} url="/carteraclientes" label="Configuración" />

                </div>
            } else if (this.state.rol == 2) {
                this._menu = <div className="row">
                    <BtnRounded id='1' src={imgCarteraClientes} url="/carteraclientes" label="Cartera de clientes" />
                    <BtnRounded id='2' src={imgCobrar} url="/cobrar" label="Cobrar" />
                    <BtnRounded id='3' src={imgSolicitarDinero} url="/solicitardinero" label="Solicitar dinero" />
                    <BtnRounded id='4' src={imgEstadoSolicitud} url="/estadosolicitud" label="Estado de solicitudes" />
                    <BtnRounded id='5' src={imgNuevoCliente} url="/nuevocliente" label="Nuevo cliente" />
                </div>
            } else {
                this._menu = <div className="row">
                    <BtnRounded id='3' src={imgSolicitarDinero} url="/solicitardinero" label="Solicitar dinero" />
                    <BtnRounded id='4' src={imgEstadoSolicitud} url="/estadosolicitud" label="Estado de solicitudes" />
                </div>
            }
        }
    }

    render() {
        //sessionStorage.
        return (
            <div>
                <Navbar setLogo={Logo} title={this.state.user} setDate={true} setButton={true} url={"/login"} fecha="1" evento={this.handleEvento} />

                <div className="container-fluid">
                    {this._menu}
                </div>
            </div>
        );
    }
}

export default Dashboard;