import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';
import Fecha from '../../../../lib/util.js';
// COMPONENTES ----------------------------------------------------



import './ModalCollect.css';

// SECURITY  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
const keys = require('src/lib/guard/keys');
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

/*PROPIEDADES -----------------------------------------------------
    1- numbre               Número de lista
    2- stateItem            Estado (1 Aprobado, 2 En espera, 3 Rechazado )
*/
class ModalCollect extends Component {

    constructor(props) {
        super(props);

        this._isMounted = false;
        this._isUpdate = false;

        this.state = {
            login: sessionStorage.getItem('login'),
            user: sessionStorage.getItem('user'),
            sucursal: sessionStorage.getItem('sucursal'),
            hash: sessionStorage.getItem('hash'),
            rol: sessionStorage.getItem('rol'),
            info: this.props.info,
            solicitud: [],
        };

        this.enviar = this.enviar.bind(this);
    }

    enviar(num) {
        if (this._isMounted) {
            var url = "http://" + keys.database.host + keys.api.url + 'cobrar_pago';
            let _monto = 0;
            let _valor = true; // Si el valor ingresado es negativo

            if (num == 1) {
                _monto = document.getElementById('txtmonto' + this.props.number).value;
                if (_monto == 0) {
                    _monto = this.state.info.monto_pago;
                } else if (_monto < 0) {
                    _valor = false;
                    alert("El monto tiene que ser mayor a cero!");
                }
            }

            if (_valor) {
                var data_text = {
                    solicitud: {
                        folio_credito: this.state.info.folio_credito,
                        monto: (num == 2 ? this.state.info.restante_total : _monto),
                        no_pagos: parseFloat("0.0001"),
                        id_tipo_pago: (num == 2 ? 7 : 0),
                        fecha_abono: Fecha.getShortDate(),
                        id_estado: 1,
                        fecha_reg: Fecha.getDateTime()
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
                                $("#" + this.props.id).modal('hide');
                                console.log(response.data[0][0]);
                                this.props.evento(response.data[0][0]);
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
        } else {
            let _atrasos = this.state.info.atrasos_monto;
            let _extras = this.state.info.extras_monto;
            let _extras_no = this.state.info.extras_no;

            if (_extras > 0) {
                if (_extras > _atrasos) {
                    _atrasos = 0;
                    _extras = _extras - _atrasos;
                    if (_extras_no > this.state.info.atrasos_no) {
                        _extras_no = _extras_no - this.state.info.atrasos_no;
                    } else {
                        _extras_no = 0;
                    }
                } else {
                    _atrasos = _atrasos - _extras;
                    _extras = 0;
                    _extras_no = 0;
                }
            }

            let data = this.state.info;

            data.atrasos_monto = _atrasos;
            data.extras_no = _extras_no;
            data.extras_monto = _extras;

            this.setState({
                info: data
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
        }

        return (
            <div className="modal fade" id={this.props.id} data-backdrop="static" tabIndex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div className="modal-dialog" role="document">
                    <div className="modal-content modalcollect">
                        <div className="modal-body p-0 d-flex flex-column">


                            <div className="d-flex row modalcollect_alias m-0">
                                <div className="col">
                                    <h2 className="tm1" >{this.state.info.alias || ""}</h2>
                                </div>

                                <div className="col-auto">
                                    <button type="button" className="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>

                            <div className="row modalcollect_name m-0 align-items-center">
                                <h4 className="tm2">{this.state.info.nombre}</h4>
                            </div>

                            <div className="row modalcollect_name m-0 align-items-center">
                                <a className="h5 text-warning" href={"tel:" + this.state.info.telefono}>Tel. {this.state.info.telefono}</a>
                            </div>

                            <div className="table table-responsive table-hover">
                                <table className="table">
                                    <thead className="thead-dark">
                                        <tr>
                                            <th scope="col">{"FOLIO: " + this.state.info.folio_credito}</th>
                                            <th scope="col">Pagos</th>
                                            <th scope="col">$ Monto</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr className="table-success">
                                            <th scope="row">Prestamo</th>
                                            <td></td>
                                            <td className="text-primary"><strong>{this.state.info.monto_credito}</strong></td>
                                        </tr>
                                        <tr className="table-primary">
                                            <th scope="row">Total a pagar</th>
                                            <td></td>
                                            <td className="text-primary"><strong>{this.state.info.monto_total}</strong></td>
                                        </tr>
                                        <tr className="table-secondary">
                                            <th scope="row">Pagado</th>
                                            <td></td>
                                            <td className="text-primary"><strong>{this.state.info.pagado}</strong></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Atrasos</th>
                                            <td>{this.state.info.atrasos_no}</td>
                                            <td className="text-danger">{this.state.info.atrasos_monto}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Adelantos</th>
                                            <td>{this.state.info.extras_no}</td>
                                            <td className="text-success">{this.state.info.extras_monto}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Restante</th>
                                            <td>{this.state.info.restante_no}</td>
                                            <td className="text-info">{this.state.info.restante_monto}</td>
                                        </tr>
                                        <tr className="table-info">
                                            <th scope="row" >Restante total</th>
                                            <td></td>
                                            <td className="text-primary"><strong>{this.state.info.restante_total}</strong></td>
                                        </tr>
                                        <tr className="bg-success text-light">
                                            <th scope="row" >Pagado hoy</th>
                                            <td></td>
                                            <td className="text-light"><strong>{this.state.info.abono_hoy}</strong></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>



                            <div className="row modalcollect_monto m-0 py-0 my-0">
                                <span className="h3"> Pago del día:        <strong className="text-primary">{"    $" + this.state.info.monto_pago}</strong> </span>
                            </div>

                            <div className="row modalcollect_body m-0 p-1">

                                <div className="input-group bg-warning mx-3 my-1 p-1">
                                    <input id={'txtmonto' + this.props.number} type="number" className="form-control" min={0} placeholder={this.state.info.monto_pago} aria-label="Text input with radio button" />
                                </div>

                                <div className="w-100"></div>
                            </div>
                        </div>
                        <div className="modal-footer px-3 mx-0">
                            <div className="col">
                                <button type="button" className="btn btn-info col-12 text-white">Info.</button>
                            </div>
                            <div className="col">
                                <button id={this.props.id + "btnRenovacion"} type="button" className="btn btn-primary col-12 text-white" onClick={(e) => this.enviar(2)}>Renovar</button>
                            </div>
                            <div className="col">
                                <button id={this.props.id + "btnNoPago"} type="button" className="btn btn-danger col-12 text-white" onClick={(e) => this.enviar(0)}>No pagó</button>
                            </div>
                            <div className="col">
                                <button id={this.props.id + "btnGuardar"} type="button" className="btn btn-success col-12 text-white" onClick={(e) => this.enviar(1)}>Guardar pago</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}

export default ModalCollect;