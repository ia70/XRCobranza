import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';

//CONMPONENTS --------------------------------------------------
import Navbar from '../../../Components/Content/Navbar/Navbar.jsx';
import { ItemList } from '../../../Components/Custom/ItemList/ItemList.jsx';
import { Title } from '../../../Components/Content/Title/Title.jsx';
import keys from '../../../../keys';

import './EstadoSolicitud.css';
import Logo from '../../../img/Logo.png';

const max = 178542, min = 413;
class EstadoSolicitud extends Component {
    constructor(props) {
        super(props);

        sessionStorage.setItem('route', 'estadosolicitud');

        this._isMounted = false;
        this._isUpdate = false;

        this.state = {
            login: sessionStorage.getItem('login'),
            user: sessionStorage.getItem('user'),
            sucursal: sessionStorage.getItem('sucursal'),
            hash: sessionStorage.getItem('hash'),
            rol: sessionStorage.getItem('rol'),
            solicitud: []
        };
    }

    componentDidMount() {

    }

    
    componentWillUnmount() {
        this._isMounted = false;
    }

    componentWillMount() {
        if (!sessionStorage.getItem('login') == 'true') {
            sessionStorage.clear();
            alert('¡Sesion bloqueada!');
            this.setState({ login: false });
        }else{
            this._isMounted = true;
            if (this._isMounted == true && this._isUpdate == false) {
                var url ="http://" + keys.database.host + keys.api.url + 'estado_solicitud';
    
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
                                        solicitud: response.solicitud
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

        if (this.state.login == false) {
            var ruta = "/";
            return (
                <Redirect
                    from="/"
                    to={ruta} />
            );
        }

        var indice = 0;
        const listItems = this.state.solicitud.map((i) =>
            <ItemList key={i.ine + Math.random() * (max - min) + min} stateItem={i.id_estado_solicitud} number={indice + 1} info={this.state.solicitud[indice++]} amount={i.monto} amountDescription="Monto solicitado:" close={true} />
        );

        return (
            <div>
                <Navbar setLogo={Logo} setTitle="Estado de solicitudes" setButton={true}/>
                <div className="container-fluid">
                    <div className="row">

                        <Title />
                        {listItems}

                    </div>
                </div>
            </div>
        );
    }
}

export default EstadoSolicitud;