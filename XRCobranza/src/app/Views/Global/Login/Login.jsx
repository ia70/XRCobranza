// DEPENDENCIES ----------------------------------------------------------------------
import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';

//COMPONENTS -------------------------------------------------------------------------
import TextBox from '../../../Components/Form/TextBox/TextBox.jsx';
import { TextPassword } from '../../../Components/Form/TextPassword/TextPassword.jsx';
import { BtnSubmit } from '../../../Components/Form/BtnSubmit/BtnSubmit.jsx';
import './Login.css';

// SECURITY  --------------------------------
const keys = require('../../../../keys');
const cipher = require('../../../../cipher');


//PROPIEDADES ------------------------------
//setLogo | setTitle | setDate

class Login extends Component {

    constructor(props) {
        super(props);

        this._isMounted = false;

        this.state = {
            _global: []
        };

        this.enviar = this.enviar.bind(this);
    }

    enviar() {
        if (this._isMounted) {
            var usuario = document.getElementById('txtusuario').value;
            var password = document.getElementById('txtpassword').value;

            if (usuario.length > 0 && password.length > 0) {

                var url = "http://" + keys.database.host + ":" + keys.server.port + keys.api.url + 'login';
                let data_text = {
                    usr: cipher.encode(keys.security.client_password, usuario),
                    pwd: cipher.encode(keys.security.client_password, password)
                };

                fetch(url, {
                    method: 'POST',
                    body: JSON.stringify(data_text),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(res => res.json())
                    .catch(error => {
                        console.error('Error:', error);
                    })
                    .then(response => {
                        let respuesta = response.oVlrXrrt;
                        let desEncriptado = cipher.decode(keys.security.client_password, respuesta);
                        let res_obj = JSON.parse(desEncriptado);

                        if (res_obj.hash != null) {
                            sessionStorage.setItem('oVlrXrrt', respuesta);
                            if(res_obj.dias_restantes > 0 && res_obj.dias_restantes <=5){
                                alert("La licencia caduca en " + res_obj.dias_restantes + " dias!");
                            }
                            this.setState({ _global: res_obj });
                        } else {
                            if(res_obj.dias_restantes == 0 && res_obj.id_usuario != null){
                                alert("Licencia caducada!");
                            }else {
                                alert("Datos incorrectos!");
                            }
                        }

                    });
            } else {
                alert("Es necesario llenar los campos!");
            }
        }
    }

    componentWillMount() {
        try {
            if (sessionStorage.getItem('oVlrXrrt') != null) {
                this.setState({ _global: JSON.parse(cipher.decode(keys.security.client_password, sessionStorage.getItem('oVlrXrrt'))) });
            }
        } catch (error) {
           console.error('Error:', error);
        }

    }

    componentDidMount() {
        this._isMounted = true;
    }

    render() {
        if (this.state._global.hash != null) {
            let _ruta =  sessionStorage.getItem('route');
            let ruta = "";
            if(_ruta != null){
                ruta = _ruta;
            }else{
                ruta = "dashboard"
            }
            return (
                <Redirect
                    from="/"
                    to={ruta} />
            );
        } else if (this._isMounted && this.state._global.id_usuario == null) {
            //alert("Datos incorrectos!");
        }

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