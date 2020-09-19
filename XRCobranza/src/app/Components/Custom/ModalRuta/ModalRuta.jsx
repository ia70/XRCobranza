import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';
import Fecha from '../../../../lib/util.js';
// COMPONENTES ----------------------------------------------------

import './ModalRuta.css';

/*PROPIEDADES -----------------------------------------------------
    1- numbre               Número de lista
    2- stateItem            Estado (1 Aprobado, 2 En espera, 3 Rechazado )
*/
class ModalRuta extends Component {

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
                    <div className="modal-content modalruta">
                        <div className="modal-body p-0 d-flex flex-column">


                            <div className="d-flex row modalruta_alias m-0">
                                <div className="col">
                                    <h2 className="tm1" >{this.state.info.ruta_descripcion || ""}</h2>
                                </div>

                                <div className="col-auto">
                                    <button type="button" className="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>

                            <div className="table table-responsive table-hover">
                                <table className="table">
                                    <thead className="thead-dark">
                                        <tr>
                                            <th scope="col"></th>
                                            <th scope="col">Clientes</th>
                                            <th scope="col">$ Monto</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr className="table-success">
                                            <th scope="row">Deberia recolectar</th>
                                            <td><strong>{this.state.info.total_cli_visitar}</strong></td>
                                            <td className="text-light bg-success"><strong>{this.state.info.total_deberia_recolectar_dia}</strong></td>
                                        </tr>
                                        <tr className="bg-secondary text-light">
                                            <th scope="row">Total recdo.</th>
                                            <td><strong>{this.state.info.total_cli_visitados /*this.state.info.total_cli_pago + this.state.info.total_cli_abonaron + this.state.info.total_cli_extra*/}</strong></td>
                                            <td ><strong>{this.state.info.total_recolectado}</strong></td>
                                        </tr>
                                        <tr className="bg-primary text-light">
                                            <th scope="row">Recdo. sin extras</th>
                                            <td><strong>{this.state.info.total_cli_pago + this.state.info.total_cli_abonaron}</strong></td>
                                            <td ><strong>{this.state.info.total_recolectado_sin_extras}</strong></td>
                                        </tr>
                                        <tr className="bg-success text-light">
                                            <th scope="row">M. pago normal</th>
                                            <td><strong>{this.state.info.total_cli_pago}</strong></td>
                                            <td className="table-success text-dark"><strong>{this.state.info.monto_normal}</strong></td>
                                        </tr>
                                        <tr className="bg-warning">
                                            <th scope="row">M. abonos</th>
                                            <td><strong>{this.state.info.total_cli_abonaron}</strong></td>
                                            <td className="table-warning"><strong>{this.state.info.monto_abonos}</strong></td>
                                        </tr>
                                        <tr className="bg-primary text-light">
                                            <th scope="row">M. extras</th>
                                            <td><strong>{this.state.info.total_cli_extra}</strong></td>
                                            <td className="table-primary  text-dark"><strong>{this.state.info.monto_extras}</strong></td>
                                        </tr>
                                        <tr className="bg-info text-light">
                                            <th scope="row" >M. remanente de E.</th>
                                            <td><strong>{this.state.info.no_renovaciones}</strong></td>
                                            <td className="table-info text-dark"><strong>{this.state.info.monto_remanente}</strong></td>
                                        </tr>
                                        <tr className="table-danger">
                                            <th scope="row">Deficit de abonos</th>
                                            <td><strong>{this.state.info.total_cli_abonaron}</strong></td>
                                            <td ><strong>{this.state.info.monto_defici_abonos}</strong></td>
                                        </tr>
                                        <tr className="table-danger">
                                            <th scope="row">Deficit no pagos</th>
                                            <td><strong>{this.state.info.total_cli_no_pago}</strong></td>
                                            <td ><strong>{this.state.info.monto_no_pagos}</strong></td>
                                        </tr>
                                        <tr className="bg-danger text-light">
                                            <th scope="row">Deficit total dia</th>
                                            <td><strong>{this.state.info.total_cli_abonaron + this.state.info.total_cli_no_pago}</strong></td>
                                            <td ><strong>{this.state.info.monto_defici_total}</strong></td>
                                        </tr>
                                        <tr className="bg-secondary text-light">
                                            <th scope="row" >Creditos terminados</th>
                                            <td><strong>{this.state.info.no_creditos_terminados}</strong></td>
                                            <td className="table-light"><strong></strong></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                        <div className="modal-footer px-3 mx-0">

                        </div>
                    </div>
                </div>
            </div>
        );
    }
}

export default ModalRuta;