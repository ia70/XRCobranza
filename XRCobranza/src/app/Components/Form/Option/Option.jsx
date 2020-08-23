import React from 'react';
//PROPIEDADES -----------------------
// checked | id | label | name 

export function Option(props) {
    if (props.checked) {
        return (
                <label className="btn btn-secondary active">
                    <input type="radio" name={props.name} id={props.id} name={props.name} defaultChecked /> 
                    {props.label} 
                </label>
        );
    } else {
        return (
                <label className="btn btn-secondary">
                    <input type="radio" name={props.name} id={props.id} name={props.name} /> 
                    {props.label} 
                </label>
        );
    }
}