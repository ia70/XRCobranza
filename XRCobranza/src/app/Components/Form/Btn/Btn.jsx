// DEPENDENCIES --------------------------------------------
import React from 'react';
import { Link } from 'react-router-dom';


// ESTYLE --------------------------------------------------
import './Btn.css';

/* PROPIEDADES ---------------------------------------------
    1- id           Identificador único
    2- label        Etiqueta a mostrar
    3- url          Link al cual acceder
    4- clases       (Opcional) añadir clases al componente
*/


export function Btn(props) {
    let clasesI = "btn-warning";
    let evento = ()=> null;

    if (props.clases != null) {
        clasesI = props.clases;
    }

    if (props.evento != null) {
        evento = (e) => props.evento();
    }

    return (
        <Link to={props.url || ""}>
            <button onClick={evento} id={props.id || "btn01"} type="button" className={"btn imagen " + clasesI } >{props.label || ""} </button>
        </Link>

    );
}