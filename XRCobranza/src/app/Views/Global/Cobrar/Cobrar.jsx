import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';

//CONMPONENTS --------------------------------------------------
import Navbar from '../../../Components/Content/Navbar/Navbar.jsx';
import { ItemList } from '../../../Components/Custom/ItemList/ItemList.jsx';
import TextSearch from '../../../Components/Form/TextSearch/TextSearch.jsx';
import ComboBox from '../../../Components/Form/ComboBox/ComboBox.jsx';

import './Cobrar.css';

// SECURITY  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
const keys = require('src/lib/guard/keys');
const cipher = require('src/lib/guard/cipher');
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

const max = 178542, min = 413;
class Cobrar extends Component {
    constructor(props) {
        super(props);

        sessionStorage.setItem('route', 'cobrar');

        this._isMounted = false;
        this._isUpdate = false;

        this.state = {
            login: sessionStorage.getItem('login'),
            user: sessionStorage.getItem('user'),
            sucursal: sessionStorage.getItem('sucursal'),
            hash: sessionStorage.getItem('hash'),
            rol: sessionStorage.getItem('rol'),
            pagado: 0,
            opcionCartera: 0,
            opcion: 5,
            total: 0,
            solicitud: [],
            filtro: []
        };

        this.filtrar = this.filtrar.bind(this);
        this.filtrarCombo = this.filtrarCombo.bind(this);
        this.modificarEstado = this.modificarEstado.bind(this);
        this.filtrarCartera = this.filtrarCartera.bind(this);
    }

    filtrarCartera(cadena) {
        let _total = 0;
        let _pagado = 0;
        if (this._isMounted) {
            if (cadena == "0") {
                this.state.solicitud.map((item) => {
                    _total += item.monto_pago;
                    if (item.abono_hoy > item.monto_pago) {
                        _pagado += item.monto_pago;
                    } else {
                        _pagado += item.abono_hoy;
                    }
                });
                this.setState({ opcionCartera: cadena, filtro: this.state.solicitud, opcion: 5, total: _total, pagado: _pagado });
            } else {
                this.state.solicitud.map((item) => {
                    if (item.id_ruta == cadena) {
                        _total += item.monto_pago;
                        if (item.abono_hoy > item.monto_pago) {
                            _pagado += item.monto_pago;
                        } else {
                            _pagado += item.abono_hoy;
                        }
                    }
                });
                let datos = this.state.solicitud.filter((item) => (item.id_ruta == cadena));
                this.setState({ opcionCartera: cadena, filtro: datos, opcion: 5, total: _total, pagado: _pagado });
            }
        }
    }

    filtrar(cadena) {
        if (this._isMounted) {
            let admin = false;
            let op = document.getElementById("filtro").value;
            let datos = [];

            cadena = cadena.toLowerCase();

            if ((this.state.rol == 1 || this.state.rol == 4) && this.state.opcionCartera == 0) {
                admin = true;
            }

            if (cadena == "" || cadena == null) {
                this.filtrarCombo(op);
            } else {
                if (cadena.length > 0) {
                    if (this.state.rol == 1 || this.state.rol == 4) {
                        datos = this.state.solicitud.filter((item) => (item.alias + " " + item.nombre + " " + item.ine + " " + item.folio_credito).toLowerCase().indexOf(cadena) >= 0 && (item.id_tipo_pago == op || op == 7) && (item.id_ruta == this.state.opcionCartera || admin));
                        this.setState({ filtro: datos, opcion: op });
                    } else {
                        datos = this.state.solicitud.filter((item) => (item.alias + " " + item.nombre + " " + item.ine + " " + item.folio_credito).toLowerCase().indexOf(cadena) >= 0 && (item.id_tipo_pago == op || op == 7));
                        this.setState({ filtro: datos, opcion: op });
                    }
                }
            }
        }
    }

    filtrarCombo(cadena) {
        let op = cadena;
        let datos = [];
        let admin = false;

        if ((this.state.rol == 1 || this.state.rol == 4) && this.state.opcionCartera == 0) {
            admin = true;
        }

        if (op == 7) {
            if (this.state.rol == 2) {
                datos = this.state.solicitud;
            } else {
                datos = this.state.solicitud.filter((item) => item.id_ruta == this.state.opcionCartera || admin);
            }

            this.setState({ filtro: datos, opcion: op });
        } else {
            if (this.state.rol == 2) {
                if (op >= 6) {
                    datos = this.state.solicitud.filter((item) => item.id_tipo_pago >= 6);
                } else {
                    datos = this.state.solicitud.filter((item) => item.id_tipo_pago == cadena);
                }
            } else {
                if (op >= 6) {
                    datos = this.state.solicitud.filter((item) => (item.id_tipo_pago >= 6 && (item.id_ruta == this.state.opcionCartera || admin)));
                } else {
                    datos = this.state.solicitud.filter((item) => (item.id_tipo_pago == cadena && (item.id_ruta == this.state.opcionCartera || admin)));
                }

            }

            this.setState({ filtro: datos, opcion: op });
        }
    }

    modificarEstado(objeto) {
        if (this._isMounted) {
            if (objeto != null) {
                var index = this.state.solicitud.findIndex(obj => obj.folio_credito == objeto.folio_credito);
                if (index >= 0) {
                    let data = this.state.solicitud;
                    data[index] = objeto;
                    this.setState({
                        solicitud: data
                    });
                    this.filtrarCombo(this.state.opcion);
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
        } else {

            if (this._isMounted == false) {
                var url = "http://" + keys.database.host + ":" + keys.server.port + keys.api.url + 'cobrar';

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
                                    this._isUpdate = true;

                                    var total_ = 0;
                                    var pagado_ = 0;

                                    response.solicitud.forEach(i => {
                                        total_ += i.monto_pago;
                                        if (i.abono_hoy > 0) {
                                            if (i.abono_hoy <= i.monto_pago) {
                                                pagado_ += i.abono_hoy;
                                            } else {
                                                pagado_ += i.monto_pago;
                                            }
                                        }
                                    });

                                    this.setState({
                                        solicitud: response.solicitud,
                                        filtro: response.solicitud,
                                        total: total_,
                                        pagado: pagado_
                                    });
                                    this.filtrarCombo(5);
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

    componentDidUpdate() {
        if (this.state.rol == 1 || this.state.rol == 4) {
            document.getElementById("filtroCartera").value = this.state.opcionCartera;
        }
        document.getElementById("filtro").value = this.state.opcion;
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
        let listItems = this.state.filtro.map((i) =>
            <ItemList
                key={i.ine + Math.random() * (max - min) + min}
                number={indice + 1}
                amount={i.monto_pago}
                amountDescription="Pago del día:"
                stateItem={i.id_tipo_pago}
                stateDescription={i.descripcion}

                info={this.state.filtro[indice++]}

                evento={this.modificarEstado}
                modal={true}
                close={false}
            />
        );

        let Combo1 = [];
        if (this.state.rol == 1 || this.state.rol == 4) {
            Combo1 = <ComboBox id="filtroCartera" label="Ruta" tabla='ruta' value={"id_ruta"} description={"descripcion"} evento={this.filtrarCartera} ></ComboBox>;
        }

        let combo = [
            {
                "valor": 5,
                "des": "Por visitar"
            },
            {
                "valor": 1,
                "des": "Pago completo"
            },
            {
                "valor": 3,
                "des": "Pago extra"
            },
            {
                "valor": 2,
                "des": "Abono"
            },
            {
                "valor": 4,
                "des": "Sin pago"
            },
            {
                "valor": 6,
                "des": "Fin de pagos"
            },
            {
                "valor": 7,
                "des": "Ver todos"
            }
        ];

        return (
            <div>
                <Navbar title="Cobrar" label1="Meta" label2={"$" + this.state.total} meta={Math.round(100 / this.state.total * this.state.pagado || 0)} />
                <div className="container-fluid">
                    <div className="row Cobrar mb-3 pt-3">
                        {Combo1}
                        <ComboBox id="filtro" label="Filtrar" items={combo} value={"valor"} description={"des"} evento={this.filtrarCombo} />
                        <TextSearch label="Buscar" id="search_cartera" evento={this.filtrar} />
                    </div>
                    <div className="row mb-4" >

                        {listItems}

                    </div>
                </div>
            </div>
        );
    }
}

export default Cobrar;