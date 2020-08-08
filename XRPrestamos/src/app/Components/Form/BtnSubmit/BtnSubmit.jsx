// DEPENDENCIES --------------------------------------
import React from 'react';
import { Link } from 'react-router-dom';



import './BtnSubmit.css';

/* --> PROPIEDADES
    1- id
    2- label
    3- url

*/
export function BtnSubmit(props) {
    let _clases = "col-xs-12 col-sm-4 col-lg-3 btn btn-success";
    if (props.class != null) {
        _clases = "btn " + props.class;
    }

    return (
        <div className={_clases} onClick={props.evento}>
            <Link to={props.url || ""}>
                <div className="text-white">{props.label || "Guardar"}</div>
            </Link>
        </div>
    );
}