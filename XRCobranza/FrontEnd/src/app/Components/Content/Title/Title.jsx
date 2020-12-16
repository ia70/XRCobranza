import React from 'react';
import './Title.css';
//PROPIEDADES
// title
export function Title(props) {
    return (
        <div className={"col-12 title "} >
            <h3>{props.title}</h3>
        </div>
    );
}