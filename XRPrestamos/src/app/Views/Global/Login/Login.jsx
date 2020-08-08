// DEPENDENCIES ----------------------------------------------------------------------
import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';

//COMPONENTS -------------------------------------------------------------------------
import TextBox from '../../../Components/Form/TextBox/TextBox.jsx';
import { TextPassword } from '../../../Components/Form/TextPassword/TextPassword.jsx';
import { BtnSubmit } from '../../../Components/Form/BtnSubmit/BtnSubmit.jsx';
import './Login.css';

const keys = require('../../../../keys');
const enc = require('../../../../cipher');


//PROPIEDADES ------------------------------
//setLogo | setTitle | setDate

class Login extends Component {

    constructor(props) {
        super(props);

        this._isMounted = false;

        this.state = {
            login: null,
            user: null,
            hash: null
        };

        this.enviar = this.enviar.bind(this);
    }

    enviar() {
        if (this._isMounted) {
            var usuario = document.getElementById('txtusuario').value;
            var password = document.getElementById('txtpassword').value;

            if (usuario.length > 0 && password.length > 0) {

                var e_user = encodeURIComponent(enc.encode(keys.security.client_password, usuario));
                var e_pass = encodeURIComponent(enc.encode(keys.security.client_password, password));

                var url = "http://"+ keys.database.host + keys.api.url + 'login?usr=' + e_user + '&pwd=' + e_pass;
                fetch(url, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(res => res.json())
                    .catch(error => console.error(error))
                    .then(response => {
                        if (response.hash != null) {
                            sessionStorage.setItem('login', response.login);
                            sessionStorage.setItem('user', response.user);
                            sessionStorage.setItem('rol', response.rol);
                            sessionStorage.setItem('sucursal', response.sucursal);
                            sessionStorage.setItem('hash', response.hash);
                        }else{
                            alert("Datos incorrectos!");
                        }
                        this.setState(response);
                    });
            } else {
                alert("Es necesario llenar los campos!");
            }
        }
    }

    componentWillMount() {
        if (sessionStorage.getItem('login') == 'null' || sessionStorage.getItem('login') == null) {
            sessionStorage.setItem('login', "");
            sessionStorage.setItem('user', "");
            sessionStorage.setItem('rol', "");
            sessionStorage.setItem('sucursal', "");
            sessionStorage.setItem('hash', "");
            sessionStorage.setItem('route', "dashboard");
        }
    }

    componentDidMount() {
        this._isMounted = true;
    }

    render() {
        if (this.state.login == true || this.state.login == 'true' || sessionStorage.getItem('login') == 'true') {
            var ruta = "/" + sessionStorage.getItem('route');
            return (
                <Redirect
                    from="/"
                    to={ruta} />
            );
        } else if (this.login == false || this.login == 'false')
            alert("Datos incorrectos!");
        return (
            <div className="contenedor" >
                <div className="column p-0 justify-content-center login login_body">
                    <div className="row justify-content-center m-0 login_title">
                        <h3>Login</h3>
                    </div>
                    <div className="row justify-content-center m-0 my-3 login_body">
                        <TextBox id="txtusuario" label="Usuario" holder="Nombre del usuario" required={true} size={"col-12"} />
                        <TextPassword id="txtpassword" label="Contraseña" holder="Contraseña" required={true} col={12} />

                        <BtnSubmit id="btnenviar" url="#" label="Entrar" evento={this.enviar} />
                    </div>
                </div>
            </div>
        );
    }
}

export default Login;