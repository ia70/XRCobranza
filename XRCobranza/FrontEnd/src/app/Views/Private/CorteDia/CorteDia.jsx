import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';

//CONMPONENTS --------------------------------------------------
import Navbar from '../../../Components/Content/Navbar/Navbar.jsx';

import Logo from '../../../img/Logo.png';
import { ItemPago } from '../../../Components/Custom/ItemPago/ItemPago.jsx';

// SECURITY  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
const keys = require('src/lib/guard/keys');
const cipher = require('src/lib/guard/cipher');
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

const max = 178542, min = 413;
class CorteDia extends Component {
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
            total: 0,
            pagado: 0,
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
                var url = "http://" + keys.database.host + keys.api.url + 'cobro_dia_corte';

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

                                    var total_ = 0;
                                    var pagado_ = 0;

                                    response.solicitud.forEach(i => {
                                        total_ += i.total_deberia_recolectar_dia;
                                        pagado_ += i.total_recolectado_sin_extras;
                                    });
                                    this.setState({
                                        rutas: response.solicitud,
                                        total: total_,
                                        pagado: pagado_
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
                <Navbar title="Corte del dia" setLogo={Logo} setButton={true} meta={Math.round(100 / this.state.total * this.state.pagado || 0)} label1="Meta" label2={this.state.total} regresar="1"/>
                <div className="container-fluid">
                    <div className="row pt-3" >
                        {listItems}
                    </div>
                </div>
            </div>
        );
    }
}

export default CorteDia;