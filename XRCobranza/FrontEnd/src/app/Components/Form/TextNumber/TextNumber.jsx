import React from 'react';
//PROPIEDADES -----------------------
// required | id | label | holder | help

export function TextNumber(props) {
    if (props.required) {
        return (
            <div className="form-group col-xs-12 col-sm-4 col-lg-3">
                <label htmlFor={props.id}>{props.label}</label>
                <input type="number" className="form-control" id={props.id} aria-describedby="textHelp" placeholder={props.holder} onChangeCapture={(props.evento != null ? (e) => props.evento(document.getElementById(props.id).value) : null)} required min={0} />
                <small id="textHelp" className="form-text text-muted">{props.help}</small>
            </div>
        );
    } else {
        return (
            <div className="form-group col-xs-12 col-sm-4 col-lg-3">
                <label htmlFor={props.id}>{props.label}</label>
                <input type="number" className="form-control" id={props.id} aria-describedby="textHelp" placeholder={props.holder} onChangeCapture={(props.evento != null ? (e) => props.evento(document.getElementById(props.id).value) : null)} min={0} />
                <small id="textHelp" className="form-text text-muted">{props.help}</small>
            </div>
        );
    }
}