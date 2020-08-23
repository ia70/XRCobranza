import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';

//CONMPONENTS --------------------------------------------------
import Navbar from '../../../Components/Content/Navbar/Navbar.jsx';
import { ItemRuta } from '../../../Components/Custom/ItemRuta/ItemRuta.jsx';
import { Title } from '../../../Components/Content/Title/Title.jsx';


import TextSearch from '../../../Components/Form/TextSearch/TextSearch.jsx';
import ComboBox from '../../../Components/Form/ComboBox/ComboBox.jsx';
import keys from '../../../../keys';

import Logo from '../../../img/Logo.png';
import { ItemPago } from '../../../Components/Custom/ItemPago/ItemPago.jsx';


const max = 178542, min = 413;
class SinPagoHoy extends Component {
    constructor(props) {
        super(props);

        sessionStorage.setItem('route', 'cortedia');

        this._isMounted = false;
        this._isUpdate = false;

        this.state = {
            login: sessionStorage.getItem('login'),
            user: sessionStorage.getItem('user'),
            sucursal: sessionStorage.getItem('sucursal'),
            hash: sessionStorage.getItem('hash'),
            rol: sessionStorage.getItem('rol'),
            opcion: 0,
            rutas: []
        };
    }



    componentDidMount() {
        this._isMounted = true;
    }

    componentWillUnmount() {
        this._isMounted = false;
    }

    componentDidUpdate() {
    }

    componentWillMount() {
        if (!sessionStorage.getItem('login') == 'true') {
            sessionStorage.clear();
            alert('¡Sesion bloqueada!');
            this.setState({ login: false });
        } else {
            if (this._isMounted == false && this._isUpdate == false) {
                var url = keys.api.url + 'cobro_dia_corte';

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
                                        rutas: response.solicitud
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



        var indice = 0;
        let listItems = this.state.rutas.map((i) =>
            <ItemPago key={i.id_ruta + Math.random() * (max - min) + min} number={indice + 1} info={this.state.rutas[indice++]} modal={true} />
        );

        return (
            <div>
                <Navbar setTitle="Clientes sin pago el dia de hoy" setLogo={Logo} setButton={true} />
                <div className="container-fluid">
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

export default SinPagoHoy;