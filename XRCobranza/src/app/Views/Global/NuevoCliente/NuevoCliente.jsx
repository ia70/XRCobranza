import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';
import Navbar from '../../../Components/Content/Navbar/Navbar.jsx';
import { Title } from '../../../Components/Content/Title/Title.jsx';
import TextBox from '../../../Components/Form/TextBox/TextBox.jsx';
import { TextPhoneNumber } from '../../../Components/Form/TextPhoneNumber/TextPhoneNumber.jsx';
import { TextTime } from '../../../Components/Form/TextTime/TextTime.jsx';
import TextSearchExt from '../../../Components/Form/TextSearchExt/TextSearchExt.jsx';
import { BtnSubmit } from '../../../Components/Form/BtnSubmit/BtnSubmit.jsx';
import ComboBox from '../../../Components/Form/ComboBox/ComboBox.jsx';
import { FileInput } from '../../../Components/Form/FileInput/FileInput.jsx';
import { getDateTime } from '../../../../lib/util';

import Logo from '../../../img/Logo.png';

// SECURITY  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
const keys = require('src/lib/guard/keys');
const cipher = require('src/lib/guard/cipher');
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

class NuevoCliente extends Component {

    constructor(props) {
        super(props);

        this._is_mounted = false;
        this._cargando = false;
        sessionStorage.setItem('route', 'nuevocliente');

        this.state = {
            _global: (sessionStorage.getItem('oVlrXrrt') != null ? JSON.parse(cipher.decode(keys.security.client_password, sessionStorage.getItem('oVlrXrrt'))) : []),
            filtro: [],
            cliente: []
        };

        this.enviar = this.enviar.bind(this);
        this.filtrar = this.filtrar.bind(this);
    }

    filtrar(cadena) {
        if (this._isMounted) {
            cadena = cadena.toLowerCase();
            if (cadena == "" || cadena == null) {
                this.setState({ filtro: [] });
            } else {
                if (this._isMounted == true) {
                    var url = "http://" + keys.database.host + ":" + keys.server.port + keys.api.url + 'persona/filtrar_clientes';

                    var data_text = {
                        _global: this.state._global,
                        filtro: cadena
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
                            if (response.persona.length == 0) {
                                this.setState({
                                    filtro: response.persona,
                                    cliente: {
                                        ine: "",
                                        nombre: "",
                                        telefono: "",
                                        no_creditos: "",
                                        calificacion: ""
                                    }
                                });
                            } else
                                this.setState({
                                    filtro: response.persona,
                                    cliente: response.persona[0]
                                });
                        });
                }
            }
        }
    }

    enviar() {
        let ruta = "";
        let _ine = "";
        let _long_ine = 0;
        try {
            if (this._cargando != true) {
                this._cargando = true;
                ruta = document.getElementById('p_id_ruta').value;
                _ine = document.getElementById('p_ine').value;
                _long_ine = _ine.length;
                console.log(_long_ine);

                if (_long_ine != 13 && _long_ine != 10) {
                    alert("¡Clave INE erronea!");
                } else
                    if (ruta != null) {
                        if (ruta != "0") {
                            var url = "http://" + keys.database.host + keys.api.url + 'nuevo_cliente';
                            var data_text = [];
                            try {
                                data_text = {
                                    persona: {
                                        ine: (document.getElementById('p_ine').value != null ? document.getElementById('p_ine').value : null),
                                        alias: (document.getElementById('p_alias').value != null ? document.getElementById('p_alias').value : null),
                                        nombre: (document.getElementById('p_nombre').value != null ? document.getElementById('p_nombre').value : null),
                                        apellido_paterno: (document.getElementById('p_apellido_paterno').value != null ? document.getElementById('p_apellido_paterno').value : null),
                                        apellido_materno: (document.getElementById('p_apellido_materno').value != null ? document.getElementById('p_apellido_materno').value : null),
                                        direccion: (document.getElementById('p_direccion').value != null ? document.getElementById('p_direccion').value : null),
                                        no_casa: (document.getElementById('p_no_casa').value != null ? document.getElementById('p_no_casa').value : null),
                                        referencias: (document.getElementById('p_referencias').value != null ? document.getElementById('p_referencias').value : null),
                                        telefono: (document.getElementById('p_telefono').value != null ? document.getElementById('p_telefono').value : null),
                                        id_tipo_inmueble: (document.getElementById('p_id_tipo_inmueble').value != null ? document.getElementById('p_id_tipo_inmueble').value : null),
                                        disp_hr_ini: (document.getElementById('p_disp_hr_ini').value != null ? document.getElementById('p_disp_hr_ini').value : null),
                                        disp_hr_fin: (document.getElementById('p_disp_hr_fin').value != null ? document.getElementById('p_disp_hr_fin').value : null),
                                        coordenadas: (document.getElementById('p_coordenadas').value != null ? document.getElementById('p_coordenadas').value : null),
                                        clave_media: null,
                                        id_estado: 1,
                                        fecha_reg: getDateTime()
                                    },
                                    aval: {
                                        ine: (document.getElementById('p_ine').value != null ? document.getElementById('p_ine').value : null),
                                        nombre: (document.getElementById('a_nombre').value != null ? document.getElementById('a_nombre').value : null),
                                        apellido_paterno: (document.getElementById('a_apellido_paterno').value != null ? document.getElementById('a_apellido_paterno').value : null),
                                        apellido_materno: (document.getElementById('a_apellido_materno').value != null ? document.getElementById('a_apellido_materno').value : null),
                                        direccion: (document.getElementById('a_direccion').value != null ? document.getElementById('a_direccion').value : null),
                                        telefono: (document.getElementById('a_telefono').value != null ? document.getElementById('a_telefono').value : null),
                                        id_tipo_parentesco: (document.getElementById('a_id_tipo_parentesco').value != null ? document.getElementById('a_id_tipo_parentesco').value : null),
                                        id_persona: null,
                                        fecha_reg: getDateTime()
                                    },
                                    usuario: {
                                        usuario: (document.getElementById('p_ine').value != null ? document.getElementById('p_ine').value : null),
                                        password: "12345",
                                        id_persona: null,
                                        usuario_padre: this.state._global.id_usuario,
                                        id_rol: 3,
                                        id_ruta: (document.getElementById('p_id_ruta').value != null ? document.getElementById('p_id_ruta').value : null),
                                        id_empresa: this.state._global.id_empresa,
                                        id_sucursal: this.state._global.id_sucursal,
                                        id_estado: 1,
                                        fecha_reg: getDateTime()
                                    },
                                    _global: {
                                        data: (sessionStorage.getItem('oVlrXrrt') != null ? sessionStorage.getItem('oVlrXrrt') : [])
                                    }
                                };
                            } catch (error) {
                                data_text = [];
                                console.log(error);
                            }

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
                                            alert('¡Registro guardado!');
                                        } else
                                            alert('¡Error al insertar!');
                                    } else {
                                        sessionStorage.clear();
                                        alert('¡Sesion bloqueada!');
                                        this.setState({ login: false });
                                    }
                                });
                        } else {
                            alert("¡Seleccione la ruta!");
                        }
                    }
                this._cargando = false;
            }
        } catch (error) {
            this._cargando = false;
            console.log(error);
        }
    }

    componentWillMount() {
        if (this.state._global.hash == null) {
            sessionStorage.clear();
            alert('¡Sesion bloqueada!');
        }
    }

    componentDidMount() {
        this._is_mounted = true;
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

        return (
            <div>
                <Navbar setLogo={Logo} title="Nuevo Cliente" setButton={true} />
                <div className="container-fluid">
                    <div className="row" >

                        <Title title="DATOS PERSONALES" />

                        <TextBox id="p_ine" label="INE" holder="Clave de Credencial" help="" required={true} maxlength={20} />
                        <TextBox id="p_alias" label="Alias" holder="Alias Cliente" help="" required={true} maxlength={60} />
                        <TextBox id="p_nombre" label="Nombre" holder="Nombre del cliente" help="" required={true} maxlength={50} />
                        <TextBox id="p_apellido_paterno" label="A. Paterno" holder="Apellido paterno" help="" required={true} maxlength={20} />
                        <TextBox id="p_apellido_materno" label="A. Materno" holder="Apellido materno" help="" required={true} maxlength={20} />
                        <TextBox id="p_direccion" label="Dirección" holder="Dirección" help="" required={true} maxlength={250} />
                        <TextBox id="p_no_casa" label="Número exterior" holder="Número exterior" help="" required={true} maxlength={10} />
                        <TextBox id="p_referencias" label="Referencia" holder="Referencia" help="" required={true} maxlength={250} />
                        <TextPhoneNumber id="p_telefono" label="Telefono" holder="Telefono" help="" required={false} />
                        <ComboBox id="p_id_tipo_inmueble" label="Tipo Inmueble" tabla='tipo_inmueble' value={"id_tipo_inmueble"} description={"descripcion"} ></ComboBox>
                        <TextTime id="p_disp_hr_ini" label="Inicio de disponibilidad" holder="Inicio de disponibilidad" help="" required={false} />
                        <TextTime id="p_disp_hr_fin" label="Fin disponibilidad" holder="Fin disponibilidad" help="" required={false} />
                        <TextBox id="p_coordenadas" label="Coordenadas" holder="Coordenadas" help="" required={true} maxlength={60} />

                        <FileInput id="p_foto_ine" label="Foto INE" holder="Foto INE"  ></FileInput>
                        <FileInput id="p_foto_personal" label="Foto Personal" holder="Foto Personal"  ></FileInput>
                        <FileInput id="p_foto_domicilio" label="Foto Domicilio" holder="Foto Domicilio"  ></FileInput>



                        <Title title="DATOS DEL AVAL" />

                        <TextSearchExt id="a_search" label="Buscar" evento={this.filtrar} />
                        <ComboBox id="a_listaclientes" label="Cliente" items={this.state.filtro} value={"ine"} description={"nombre"} evento={this.leer} />

                        <TextBox id="a_ine" label="INE" holder="INE" help="" required={true} maxlength={20} />
                        <TextBox id="a_nombre" label="Nombre" holder="Nombre del cliente" help="" required={true} maxlength={50} />
                        <TextBox id="a_apellido_paterno" label="A. Paterno" holder="Apellido paterno" help="" required={true} maxlength={20} />
                        <TextBox id="a_apellido_materno" label="A. Materno" holder="Apellido materno" help="" required={true} maxlength={20} />
                        <TextBox id="a_direccion" label="Dirección" holder="Dirección" help="" required={true} maxlength={250} />
                        <TextPhoneNumber id="a_telefono" label="Telefono" holder="Telefono" help="" required={false} />

                        <ComboBox id="a_id_tipo_parentesco" label="Parentesco" tabla='tipo_parentesco' value={"id_tipo_parentesco"} description={"descripcion"} ></ComboBox>


                        <Title title="COBRANZA" />
                        <ComboBox id="p_id_ruta" label="Asignar a ruta" tabla='ruta' value={"id_ruta"} description={"descripcion"} ></ComboBox>

                    </div>
                    <div className="row">
                        <div className="btn-group form-group col-12">
                            <BtnSubmit id="btnenviar" url="#" label="Guardar" evento={this.enviar} />
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}

export default NuevoCliente;