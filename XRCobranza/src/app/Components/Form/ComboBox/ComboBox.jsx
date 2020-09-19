import React, { Component } from 'react';

// SECURITY  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
const keys = require('src/lib/guard/keys');
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

//PROPIEDADES -----------------------
/*
    - id            Identificador único para cada componente
    - label         Etiqueta o texto que se mostrará
    - tabla         Nombre de la tabla de la base de datos que será el origen de datos
    - items         Arreglo de elementos del combobox
    - value         Nombre del campo que se almacenará en propiedad value del selecoption
    - description   Nombre del campo que contiene el texto que se mostrará en el combo box
*/

const max = 178542, min = 413;
class ComboBox extends Component {

    constructor(props) {
        super(props);
        this._isMounted = false;
        this._isUpdate = false;

        this._elementos = [];

        this.state = {
            elementos: []
        };
        this.leer = this.leer.bind(this);
    }

    componentDidMount() {

    }

    componentWillMount() {
        this._isMounted = true;
        try {
            if (this._isUpdate == false) {
                this._isUpdate = true;
                var url = "http://" + keys.database.host + ":" + keys.server.port + keys.api.url;
                if (this.props.tabla != null) {
                    url += this.props.tabla;
                    fetch(url, {
                        method: 'GET',
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    }).then(res => res.json())
                        .catch(error => console.error(error))
                        .then(response => {
                            if (this._isMounted) {
                                this.setState({ 'elementos': response[this.props.tabla] || [] });
                            }
                        });
                } else {
                    if (this._isMounted) {
                        this.setState({ 'elementos': this.props.items || [] });
                    }
                }
            }
        } catch (e) {
            console.log(e);
        }
    }

    componentWillUnmount() {
        this._isMounted = false;
        this._elementos = [];
    }

    componentWillUpdate() {
        this._isUpdate = true;
    }

    leer() {
        try {
            let cadena = document.getElementById(this.props.id).value;
            return cadena;
        } catch (error) {
            return "";
        }
    }

    componentDidUpdate() {

    }

    render() {
        try {
            this._elementos = this.props.items;
        } catch (error) {
            this._elementos = [];
            console.log(e);
        }

        let valu = "";
        let des = "";
        let lista = [];
        let evento = null;

        if (this.props.evento != null) {
            evento = (e) => this.props.evento(this.leer())
        }

        try {
            valu = this.props.value;
            des = this.props.description;
        } catch (error) {
            console.log(e);
        }

        if (this.props.tabla != null) {
            if (valu != null) {
                lista = this.state.elementos.map(i => <option key={this.props.id + 'opt' + Math.random() * (max - min) + min} value={i[valu]} >{i[des]}</option>);
            } else
                lista = "";
        } else {
            try {
                lista = this._elementos.map(i => <option key={this.props.id + 'opt' + Math.random() * (max - min) + min} value={i[valu]} >{i[des]}</option>);
            } catch (e) {
                console.log(e);
            }
        }

        return (
            <div className="form-group col-xs-12 col-sm-4 col-lg-4">
                <label key={'lbl' + this.props.id + Math.random() * (max - min) + min} htmlFor={this.props.id}>{this.props.label || "Seleccione una opción."}</label>
                <select key={'sel' + this.props.id + Math.random() * (max - min) + min} className="form-control" id={this.props.id} onChange={evento} >
                    {lista}
                </select>
            </div>
        );
    }
}

export default ComboBox;