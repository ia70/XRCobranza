import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';
import ComboBox from '../../../Components/Form/ComboBox/ComboBox.jsx';

//CONMPONENTS --------------------------------------------------
import Navbar from '../../../Components/Content/Navbar/Navbar.jsx';
import TextSearchExt from '../../../Components/Form/TextSearchExt/TextSearchExt.jsx';
import { Table } from '../../../Components/Content/Table/Table.jsx';
import { Title } from '../../../Components/Content/Title/Title.jsx';
import { TextMoney } from '../../../Components/Form/TextMoney/TextMoney.jsx';
import { TextNumber } from '../../../Components/Form/TextNumber/TextNumber.jsx';
import { DateTimePicker } from '../../../Components/Form/DateTimePicker/DateTimePicker.jsx';
import { BtnSubmit } from '../../../Components/Form/BtnSubmit/BtnSubmit.jsx';
import TextBox from '../../../Components/Form/TextBox/TextBox.jsx';
import keys from '../../../../keys';
import { getDateTime } from '../../../../lib/util';

//import './SolicitarDinero.css';
import Logo from '../../../img/Logo.png';

class SolicitarDinero extends Component {
    constructor(props) {
        super(props);

        sessionStorage.setItem('route', 'nuevocredito');

        this._isMounted = false;
        this._isUpdate = false;
        this._id_tipo_credito = 1;
        this._telefono = "";
        this._recargar = false;

        this.state = {
            login: sessionStorage.getItem('login'),
            user: sessionStorage.getItem('user'),
            sucursal: sessionStorage.getItem('sucursal'),
            hash: sessionStorage.getItem('hash'),
            rol: sessionStorage.getItem('rol'),
            cliente: {
                ine: "",
                nombre: "",
                telefono: "",
                no_creditos: "",
                calificacion: ""
            },
            pagos: [],
            tipo_cobro: [],
            filtro: []
        };

        this.filtrar = this.filtrar.bind(this);
        this.leer = this.leer.bind(this);
        this.enviar = this.enviar.bind(this);
        this.agregarPago = this.agregarPago.bind(this);
        this.elimianrPago = this.eliminarPago.bind(this);
        this.event_no_pagos = this.event_no_pagos.bind(this);
        this.event_monto_pago = this.event_monto_pago.bind(this);
        this.event_monto_total = this.event_monto_total.bind(this);
        this.event_monto_credito = this.event_monto_credito.bind(this);
        this.tipo_credito = this.tipo_credito.bind(this);
    }

    event_monto_credito(cadena) {
        if (this._isMounted) {
            let total_pagos = document.getElementById("cre_pagos_total").value;
            let pago = 0;
            let monto_total = 0;

            if (total_pagos == "") {
                total_pagos = 24;
            }

            monto_total = cadena * 1.2;
            pago = monto_total / total_pagos;

            document.getElementById("cre_pagos_total").value = total_pagos;
            document.getElementById("cre_monto_pago").value = pago;
            document.getElementById("cre_monto_total").value = monto_total;
        }
    }

    event_monto_total(cadena) {
        if (this._isMounted) {
            let total_pagos = document.getElementById("cre_pagos_total").value;
            let pago = 0;
            pago = cadena / total_pagos;
            document.getElementById("cre_monto_pago").value = pago;
        }
    }

    event_monto_pago(cadena) {
        if (this._isMounted) {
            let total_pagos = document.getElementById("cre_pagos_total").value;
            let total = 0;
            total = total_pagos * cadena;
            document.getElementById("cre_monto_total").value = total;
        }
    }
    //   GUARDAR CREDITO EN LAS DIFERENTES TABLAS ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    event_no_pagos(cadena) {
        if (this._isMounted) {
            let monto_total = document.getElementById("cre_monto_total").value;
            let pago = 0;
            pago = monto_total / cadena;
            document.getElementById("cre_monto_pago").value = pago;
        }
    }

    agregarPago() {
        if (this._isMounted) {
            let _monto = 0;
            let _fecha = "";

            try {
                _monto = document.getElementById("cre_monto_abono").value;
                _fecha = document.getElementById("cre_fecha_pago").value;
            } catch (e) {
                console.log(e);
            }

            if (_monto == "") {
                _monto = 0;
            }

            if (_fecha != "") {
                let data = this.state.pagos;
                let _indice = data.length;

                console.log("MONTO: " + _monto);
                console.log("FECHA: " + _fecha);
                console.log("INDICE: " + _indice);

                data[_indice] = { indice: _indice, monto: _monto, fecha_abono: _fecha };

                try {
                    document.getElementById("cre_monto_abono").value = "";
                    document.getElementById("cre_fecha_pago").value = "";
                } catch (e) {
                    console.log(e);
                }

                this.setState({ pagos: data });
            } else {
                alert("¡Especifique una fecha!");
            }


        }
    }

    eliminarPago(elemento) {
        let indice = 0;
        console.log("ENTRO: " + elemento);
        if (this._isMounted) {
            let eliminar = confirm("¿Deseas eliminar el pago No. " + (elemento + 1) + " ?");
            if (eliminar) {
                let data = this.state.pagos;
                console.log("ELEMENTO: " + elemento);
                data.splice(elemento, 1);
                console.log(data);

                for (indice = 0; indice < data.length; indice++) {
                    data[indice].indice = indice;
                }

                this.setState({ pagos: data });

            }
        }
    }

    leer() {
        if (this._isMounted) {
            try {
                let valor1 = document.getElementById('inf_listaclientes').value;
                let indice = this.state.filtro.findIndex((item) => item.ine == valor1);
                let dato = this.state.filtro[indice];
                this.setState({ cliente: dato });
            } catch (e) {
                console.log(e);
            }
        }
    }

    tipo_credito() {
        if (this._isMounted) {
            this._id_tipo_credito = document.getElementById("cre_id_tipo_credito").value;
        }
    }

    filtrar(cadena) {
        if (this._isMounted) {
            cadena = cadena.toLowerCase();
            if (cadena == "" || cadena == null) {
                this.setState({ filtro: [] });
            } else {
                if (this._isMounted == true) {
                    var url ="http://" + keys.database.host +":"+ keys.server.port + keys.api.url + 'persona/filtrar_clientes';

                    var data_text = {
                        user: this.state.user,
                        sucursal: this.state.sucursal,
                        hash: this.state.hash,
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

    componentDidMount() {
        this._isMounted = true;
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

    componentDidUpdate() {
        //this.leer();
        if (this._isMounted) {
            let valor = document.getElementById("inf_ine").value;
            let indice = 0;
            if (valor != "") {
                indice = this.state.filtro.findIndex((item) => item.ine == valor);
                if (indice >= 0) {
                    document.getElementById("inf_listaclientes").value = document.getElementById("inf_ine").value;


                }
            }
            if (this._telefono != "") {
                document.getElementById("inf_telefono").value = this._telefono;
            } else {
                document.getElementById("inf_telefono").value = this.state.cliente.telefono;
            }
            document.getElementById("inf_ine").value = this.state.cliente.ine;
            document.getElementById("inf_nombre").value = this.state.cliente.nombre;

            document.getElementById("inf_no_creditos").value = this.state.cliente.no_creditos;
            document.getElementById("inf_calificacion").value = this.state.cliente.calificacion;
            document.getElementById("cre_id_tipo_credito").value = this._id_tipo_credito;
            this._telefono = "";
        }
    }

    enviar() {
        if (this._isMounted) {
            this._telefono = document.getElementById("inf_telefono").value;
            var url ="http://" + keys.database.host + keys.api.url + 'nuevo_credito';
            console.log(this.state.pagos);
            var data_text = {
                credito: {
                    folio_credito: document.getElementById("cre_folio_credito").value,
                    descripcion: "",
                    id_usuario: this.state.user,
                    id_usuario_establecimiento: this.state.cliente.id_usuario_establecimiento,
                    id_periodo: 0,
                    id_tipo_cobro: document.getElementById("cre_id_tipo_cobro").value,
                    monto_credito: document.getElementById("cre_monto_credito").value,
                    monto_pago: document.getElementById("cre_monto_pago").value,
                    monto_total: document.getElementById("cre_monto_total").value,
                    fecha_entrega: document.getElementById("cre_fecha_entrega").value,
                    fecha_inicio_cobro: document.getElementById("cre_fecha_inicio_cobro").value,
                    fecha_siguiente_pago: document.getElementById("cre_fecha_inicio_cobro").value,
                    pagos_total: document.getElementById("cre_pagos_total").value,
                    id_estado_credito: 1,
                    id_estado: 1,
                    id_tipo_credito: document.getElementById("cre_id_tipo_credito").value,
                    fecha_reg: getDateTime()
                },
                abonos: this.state.pagos,
                persona: {
                    ine: this.state.cliente.ine,
                    telefono: (this.state.cliente.telefono != document.getElementById("inf_telefono").value ? document.getElementById("inf_telefono").value : "")
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
                            this._recargar = true;
                            alert('¡Registro guardado!');
                        } else
                            alert('¡Error al guardar!');
                    } else {
                        sessionStorage.clear();
                        alert('¡Sesion bloqueada!');
                        this.setState({ login: false });
                    }
                });
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
        }else if(this._recargar){
            var ruta = "nuevocredito";
            return (
                <Redirect
                    from="/"
                    to={ruta} />
            );
        }

        let calificacion = 0;
        if (this._isMounted)
            calificacion = this.state.cliente.calificacion;

        let colorCalificacion = "";

        if (this.state.filtro.length == 0) {
            colorCalificacion = " bg-white text-dark ";
        } else if (calificacion == 0 && this.state.cliente.no_creditos == 0) {
            colorCalificacion = " bg-info text-white ";
        } else if (calificacion < 68) {
            colorCalificacion = " bg-danger text-white ";
        } else if (calificacion < 78) {
            colorCalificacion = " bg-warning text-dark ";
        } else if (calificacion <= 80) {
            colorCalificacion = " bg-success text-white ";
        } else {
            colorCalificacion = " bg-primary text-white ";
        }

        return (
            <React.Fragment>
                <Navbar setLogo={Logo} title="Nuevo credito" setButton={true} />
                <div className="container-fluid">
                    <div className="row m-0" >

                        <Title title="Información del cliente" />

                        <TextSearchExt id="inf_search" label="Buscar" evento={this.filtrar} />
                        <ComboBox id="inf_listaclientes" label="Cliente" items={this.state.filtro} value={"ine"} description={"nombre"} evento={this.leer} />
                        <TextBox id="inf_ine" label="INE" holder="Clave de Credencial" readonly={true} value={this.state.cliente.ine} />
                        <TextBox id="inf_nombre" label="Alias / Nombre" size="col-xs-12 col-sm-8 col-lg-6" holder="Alias / Nombre" readonly={true} />
                        <TextBox id="inf_telefono" label="Telefono" holder="Telefono" />
                        <TextBox id="inf_no_creditos" label="No. creditos" class={colorCalificacion} holder="Número de creditos" readonly={true} />
                        <TextBox id="inf_calificacion" class={colorCalificacion} label="Score" readonly={true} holder="Score" />


                        <Title title="Información del credito" />

                        <TextBox id="cre_folio_credito" label="Folio del credito" holder="Folio del credito" />
                        <TextMoney id="cre_monto_credito" label="Monto del credito" holder="Monto del credito" help="" evento={this.event_monto_credito} required={true} />
                        <ComboBox id="cre_id_tipo_cobro" label="Periodo de cobro" tabla='tipo_cobro' value={"id_tipo_cobro"} description={"descripcion"} />

                        <TextNumber id="cre_pagos_total" label="Número de pagos" holder="Número de pagos" help="" required={true} evento={this.event_no_pagos} />
                        <TextMoney id="cre_monto_pago" label="Monto de pago" holder="Monto de pago" help="" evento={this.event_monto_pago} required={true} />
                        <TextMoney id="cre_monto_total" label="Total a pagar" holder="Total a pagar" help="" evento={this.event_monto_total} required={true} />
                        <DateTimePicker id="cre_fecha_entrega" label="Fecha de entrega" holder="Fecha de entrega" help="" required={true} />
                        <DateTimePicker id="cre_fecha_inicio_cobro" label="Fecha del primer cobro" holder="Fecha del primer cobro" help="" required={true} />
                        <ComboBox id="cre_id_tipo_credito" label="Tipo de credito" tabla='tipo_credito' value={"id_tipo_credito"} description={"descripcion"} evento={this.tipo_credito} />

                        <Title title="Agregar pagos" />

                        <TextMoney id="cre_monto_abono" label="Monto pagado" holder="Monto pagado" help="" />
                        <DateTimePicker id="cre_fecha_pago" label="Fecha del pago" holder="Fecha del pago" help="" />
                        <BtnSubmit id="cre_btn_agregar_pago" class="btn-info col-sm-12 col-md-12 col-lg-8 mb-3" url="#" label="Agregar pago" evento={this.agregarPago} />
                        <div className="w-100"></div>
                        <Table id="cre_tabla_pagos" items={this.state.pagos} evento={this.elimianrPago} />


                    </div>
                    <BtnSubmit id="cre_btnenviar" class={"btn-lg btn-block btn-success mb-3"} url="#" label="Registrar credito" evento={this.enviar} />
                </div>
            </React.Fragment>
        );
    }
}

export default SolicitarDinero;