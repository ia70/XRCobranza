// DEPENDENCIES ----------------------------------------------
import React, { Component } from 'react';
import { Link } from 'react-router-dom';


/* PROPERTIES ------------------------------------------------
    1- id       Identificador único
    2- label    Etiqueta a mostrar
    3- src      Imagen
    4- url      Link al cual dirigirse
*/

import './BtnRounded.css';

class BtnRounded extends Component {
    render() {
        return (

            <div className="col m-1  btn btn-outline-info">
                <Link to={this.props.url || ""}>
                    <div className="row">
                        <div className="col-12">
                            <img src={this.props.src} className="border border-warning rounded-circle" />
                        </div>
                        <div className="col-12">
                            <strong className="text-center text-dark" >{this.props.label}</strong>
                        </div>
                    </div>
                </Link>
            </div>

        );
    }
}

export default BtnRounded;