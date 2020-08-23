import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';

//CONMPONENTS --------------------------------------------------
import Navbar from '../../../Components/Content/Navbar/Navbar.jsx';
import { ItemList } from '../../../Components/Custom/ItemList/ItemList.jsx';
import TextSearch from '../../../Components/Form/TextSearch/TextSearch.jsx';
import ComboBox from '../../../Components/Form/ComboBox/ComboBox.jsx';
import keys from '../../../../keys';
import Logo from '../../../img/Logo.png';
import './CarteraClientes.css';

const max = 178542, min = 413;
class CarteraClientes extends Component {
    constructor(props) {
        super(props);

        sessionStorage.setItem('route', 'carteraclientes');

        this._isMounted = false;
        this._isUpdate = false;

        this.state = {
            login: sessionStorage.getItem('login'),
            user: sessionStorage.getItem('user'),
            sucursal: sessionStorage.getItem('sucursal'),
            hash: sessionStorage.getItem('hash'),
            rol: sessionStorage.getItem('rol'),
            opcion: 0,
            cartera: [],
            filtro: []
        };
        this.filtrar = this.filtrar.bind(this);
    }

    filtrar(cadena) {
        if (this._isMounted) {
            cadena = cadena.toLowerCase();
            let Combo = "";
            let seleccionar = false;
            let datos = [];
            if (this.state.rol == 1 || this.state.rol == 4) {
                Combo = document.getElementById("filtroCartera").value;
                if(Combo == 0){
                    seleccionar = true;
                }
                if (cadena == Combo) {
                    cadena = "";
                }
            }

            if (cadena == "" || cadena == null) {
                if (this.state.rol == 1 || this.state.rol == 4) {
                    datos = this.state.cartera.filter((item) => (item.id_ruta == Combo || seleccionar));
                    this.setState({ opcion: Combo, filtro: datos });
                } else if (this.state.rol == 2) {
                    this.setState({ filtro: this.state.cartera });
                }
            } else {
                if (cadena.length > 0) {
                    if (this.state.rol == 1 || this.state.rol == 4) {
                        datos = this.state.cartera.filter((item) => (item.alias + " " + item.nombre + " " + item.apellido_paterno + " " + item.apellido_materno).toLowerCase().indexOf(cadena) >= 0 && (item.id_ruta == Combo || seleccionar));
                        this.setState({ opcion: Combo, filtro: datos });
                    } else if (this.state.rol == 2) {
                        datos = this.state.cartera.filter((item) => (item.alias + " " + item.nombre + " " + item.apellido_paterno + " " + item.apellido_materno).toLowerCase().indexOf(cadena) >= 0);
                        this.setState({ filtro: datos });
                    }
                }
            }
        }
    }

    componentDidMount() {
        if ((this.state.rol == 1 || this.state.rol == 4) && this._isMounted == false) {
            document.getElementById("filtroCartera").value = this.state.opcion;
        }
        this._isMounted = true;
    }

    componentWillUnmount() {
        this._isMounted = false;
    }

    componentDidUpdate() {
        this._isUpdate = true;
        if (this.state.rol == 1 || this.state.rol == 4) {
            document.getElementById("filtroCartera").value = this.state.opcion;
        }
    }

    componentWillMount() {
        if (!sessionStorage.getItem('login') == 'true') {
            sessionStorage.clear();
            alert('¡Sesion bloqueada!');
            this.setState({ login: false });
        } else {
            if (this._isMounted == false && this._isUpdate == false) {
                var url ="http://" + keys.database.host + keys.api.url + 'cartera_clientes';

                var data_text = {
                    user: this.state.user,
                    sucursal: this.state.sucursal,
                    hash: this.state.hash,
                    rol: this.state.rol
                };

                fetch(url, {
                    method: 'POST',
                    body: JSON.stringify(data_text),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(res => res.json())
                    .catch(error => {
                        console.error('Error:', error)
                    })
                    .then(response => {
                        if (response.session) {
                            if (response.response) {
                                if (this._isMounted == true && this._isUpdate == false) {
                                    this.setState({
                                        cartera: response.cartera,
                                        filtro: response.cartera
                                    });
                                }
                            }
                        } else {
                            sessionStorage.clear();
                            alert('¡Sesion bloqueada!');
                            this.setState({ login: false });
                        }
                    });
            }
        }
    }

    render() {
        let Combo = [];
        if (this.state.login == false) {
            var ruta = "/";
            return (
                <Redirect
                    from="/"
                    to={ruta} />
            );
        }

        if (this.state.rol == 1 || this.state.rol == 4) {
            Combo = <ComboBox id="filtroCartera" label="Ruta" tabla='ruta' value={"id_ruta"} description={"descripcion"} evento={this.filtrar} ></ComboBox>;
        }

        var indice = 0;
        let listItems = this.state.filtro.map((i) =>
            <ItemList key={i.nombre + Math.random() * (max - min) + min} number={indice + 1} info={this.state.filtro[indice++]} amount={i.restante} amountDescription="Restante:" />
        );

        return (
            <div>
                <Navbar title="Cartera de clientes" setLogo={Logo} setButton={true} />
                <div className="container-fluid">
                    <div className="row mb-3 pt-3 Cobrar">
                        {Combo}
                        <TextSearch label="Buscar" id="search_cartera" evento={this.filtrar} />
                    </div>
                    <div className="row" >
                        {listItems}
                    </div>
                </div>
            </div>
        );
    }
}

export default CarteraClientes;