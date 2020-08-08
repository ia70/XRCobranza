import React from 'react';
//PROPIEDADES -----------------------
// checked | id | label | name | value

export function RadioButton(props) {
    if (props.checked) {
        return (
            <div className="form-check">
                <input className="form-check-input" type="radio" name={props.name} id={props.id} value={props.value} defaultChecked />
                <label className="form-check-label" htmlFor={props.id}>
                    {props.label}
                </label>
            </div>
        );
    } else {
        return (
            <div className="form-check">
                <input className="form-check-input" type="radio" name={props.name} id={props.id} value={props.value} />
                <label className="form-check-label" htmlFor={props.id}>
                    {props.label}
                </label>
            </div>
        );
    }
}