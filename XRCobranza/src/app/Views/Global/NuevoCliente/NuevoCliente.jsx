import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';
import Navbar from '../../../Components/Content/Navbar/Navbar.jsx';
import { Title } from '../../../Components/Content/Title/Title.jsx';
import TextBox from '../../../Components/Form/TextBox/TextBox.jsx';
import { TextPhoneNumber } from '../../../Components/Form/TextPhoneNumber/TextPhoneNumber.jsx';
import { TextEmail } from '../../../Components/Form/TextEmail/TextEmail.jsx';
import { BtnSubmit } from '../../../Components/Form/BtnSubmit/BtnSubmit.jsx';
import ComboBox from '../../../Components/Form/ComboBox/ComboBox.jsx';
import { FileInput } from '../../../Components/Form/FileInput/FileInput.jsx';
import keys from '../../../../keys';
import { getDateTime } from '../../../../lib/util';

import Logo from '../../../img/Logo.png';

class NuevoCliente extends Component {

    constructor(props) {
        super(props);

        sessionStorage.setItem('route', 'nuevocliente');

        this.state = {
            login: sessionStorage.getItem('login'),
            user: sessionStorage.getItem('user'),
            sucursal: sessionStorage.getItem('sucursal'),
            hash: sessionStorage.getItem('hash'),
            rol: sessionStorage.getItem('rol')
        };

        this.enviar = this.enviar.bind(this);
    }

    enviar() {
        let ruta = "";
        let _ine="";
        let _long_ine = 0;
        try {
            ruta = document.getElementById('c_ruta').value;
            _ine = document.getElementById('p_ine').value;
            _long_ine = _ine.length;
            console.log(_long_ine);

            if (_long_ine != 13 && _long_ine != 10) {
                alert("¡Clave INE erronea!");
            } else
                if (ruta != null) {
                    if (ruta != "0") {
                        var url = "http://" + keys.database.host + keys.api.url + 'nuevo_cliente';

                        var data_text = {
                            persona: {
                                ine: document.getElementById('p_ine').value,
                                ine_ref: null,
                                alias: document.getElementById('p_alias').value,
                                nombre: document.getElementById('p_nombre').value,
                                apellido_paterno: document.getElementById('p_apaterno').value,
                                apellido_materno: document.getElementById('p_amaterno').value,
                                id_calle: 1,
                                direccion: document.getElementById('p_direccion').value,
                                no_casa: document.getElementById('p_no_casa').value,
                                referencias: document.getElementById('p_referencia').value,
                                foto_casa: null,
                                telefono: document.getElementById('p_telefono').value,
                                correo: document.getElementById('p_email').value,
                                foto: null,
                                ine_img: null,
                                id_tipo_inmueble: document.getElementById('p_tipo_inmueble').value,
                                id_estado: 5,
                                fecha_reg: getDateTime()
                            },
                            establecimiento: {
                                ine: document.getElementById('p_ine').value,
                                nombre: document.getElementById('n_nombre').value,
                                id_calle: null,
                                numero_ext: null,
                                referencias: document.getElementById('n_referencia').value,
                                id_actividad_economica: null,
                                id_tipo_inmueble: document.getElementById('n_tipo_inmueble').value,
                                id_tipo_local: document.getElementById('n_tipo_local').value,
                                documento_adicional: null,
                                disponibilidad_hr_inicio: document.getElementById('n_hora_inicio').value,
                                disponibilidad_hr_fin: document.getElementById('n_hora_fin').value,
                                coordenadas: document.getElementById('n_coordenadas').value,
                                foto: null,
                                id_ruta: document.getElementById('c_ruta').value,
                                id_estado: 5
                            },
                            aval: {
                                ine: document.getElementById('p_ine').value,
                                nombre: document.getElementById('a_nombre').value,
                                apellido_paterno: document.getElementById('a_apaterno').value,
                                apellido_materno: document.getElementById('a_amaterno').value,
                                direccion: null,
                                telefono: document.getElementById('a_telefono').value,
                                parentesco: document.getElementById('a_parentesco').value
                            },
                            user: {
                                user: this.state.user,
                                sucursal: this.state.sucursal,
                                hash: this.state.hash,
                                rol: this.state.rol
                            }
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
        } catch (error) {
            console.log(error);
        }
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
                        <TextTime id="n_disp_hr_ini" label="Inicio de disponibilidad" holder="Inicio de disponibilidad" help="" required={false} />
                        <TextTime id="n_disp_hr_fin" label="Fin disponibilidad" holder="Fin disponibilidad" help="" required={false} />
                        <TextBox id="p_coordenadas" label="Coordenadas" holder="Coordenadas" help="" required={true} maxlength={60} />

                        <FileInput id="p_foto_ine" label="Foto INE" holder="Foto INE"  ></FileInput>
                        <FileInput id="p_foto_personal" label="Foto Personal" holder="Foto Personal"  ></FileInput>
                        <FileInput id="p_foto_domicilio" label="Foto Domicilio" holder="Foto Domicilio"  ></FileInput>



                        <Title title="DATOS DEL AVAL" />

                        <TextBox id="a_nombre" label="Nombre" holder="Nombre del cliente" help="" required={true} maxlength={50} />
                        <TextBox id="a_apaterno" label="A. Paterno" holder="Apellido paterno" help="" required={true} maxlength={20} />
                        <TextBox id="a_amaterno" label="A. Materno" holder="Apellido materno" help="" required={true} maxlength={20} />
                        <TextPhoneNumber id="a_telefono" label="Telefono" holder="Telefono" help="" required={false} />
                        <TextBox id="a_parentesco" label="Parentesco" holder="Parentesco" help="" required={true} maxlength={50} />

                        <Title title="COBRANZA" />
                        <ComboBox id="c_ruta" label="Asignar a ruta" tabla='ruta' value={"id_ruta"} description={"descripcion"} ></ComboBox>

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