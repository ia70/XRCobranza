import React from 'react';

import './BtnClose.css';
//PROPIEDADES
// label
export function BtnClose(props) {
    return (
        <button className="btn btnclose" >{props.label || "X"} </button>
    );
}