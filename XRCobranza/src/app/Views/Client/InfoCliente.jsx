import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';

//CONMPONENTS --------------------------------------------------
import Navbar from '../../../Components/Content/Navbar/Navbar.jsx';
import { ItemList } from '../../../Components/Custom/ItemList/ItemList.jsx';
import { Title } from '../../../Components/Content/Title/Title.jsx';
import TextSearch from '../../../Components/Form/TextSearch/TextSearch.jsx';
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
            cartera: [],
            filtro: []
        };
        this.filtrar = this.filtrar.bind(this);
    }

    filtrar(cadena) {
        cadena = cadena.toLowerCase();
        let datos = [];
        if (cadena == "" || cadena == null) {
            this.setState({ filtro: this.state.cartera });
        } else {
            if (cadena.length > 0) {
                datos = this.state.cartera.filter((item) => (item.alias + " " + item.nombre + " " + item.apellido_paterno + " " + item.apellido_materno).toLowerCase().indexOf(cadena) >= 0);
                this.setState({ filtro: datos });
            }
        }
    }

    componentDidMount() {
        this._isMounted = true;
        if (this._isMounted == true && this._isUpdate == false) {
            var url = keys.api.url + 'cartera_clientes';

            var data_text = {
                user: this.state.user,
                sucursal: this.state.sucursal,
                hash: this.state.hash
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
                                this._isUpdate = true;
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

    componentWillUnmount() {
        this._isMounted = false;
    }

    componentWillMount() {
        if (!sessionStorage.getItem('login') == 'true') {
            sessionStorage.clear();
            alert('¡Sesion bloqueada!');
            this.setState({ login: false });
        }
    }

    render() {

        if (this.state.login == false) {
            var ruta = "/";
            return (
                <Redirect
                    from="/"
                    to={ruta} />
            );
        }

        var indice = 0;
        const listItems = this.state.filtro.map((i) =>
            <ItemList key={i.nombre + Math.random() * (max - min) + min} alias={i.alias} number={++indice} nombre={i.nombre + " " + i.apellido_paterno + " " + i.apellido_materno} amount={i.restante} amountDescription="Restante:" />
        );

        return (
            <div>
                <Navbar setTitle="Cartera de clientes" setLogo={Logo} setButton={true} />
                <div className="container-fluid">
                    <div className="row Cobrar">
                        <Title />
                        <TextSearch label="Buscar" id="search_cartera" evento={this.filtrar} />
                    </div>
                    <div className="row">
                        <Title />
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