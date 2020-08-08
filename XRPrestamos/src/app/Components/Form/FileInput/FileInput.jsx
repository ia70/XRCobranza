import React from 'react';
//PROPIEDADES -----------------------
// required | id | label | holder | help

export function FileInput(props) {
    let columna = " col-xs-12 col-sm-4 col-lg-3";
    let addclass = "";

    if (props.col != null) {
        columna = " col-" + props.col;
    }

    if (props.cls != null) {
        addclass = " " + props.cls;
    }

    if (props.required) {
        return (
            <div className={"form-group" + columna + addclass}>
                <label htmlFor={props.id || "01"}>{props.label || ""}</label>
                <input type="file" className="form-control" id={props.id || "01"} aria-describedby="textHelp"
                    placeholder={props.holder || ""} minLength={props.minlength || 1}
                    maxLength={props.maxlength || 20} required />
                <small id="textHelp" className="form-text text-muted">{props.help || ""}</small>
            </div>
        );
    } else {
        return (
            <div className={"form-group" + columna + addclass}>
                <label htmlFor={props.id || "01"}>{props.label || ""}</label>
                <input type="file" className="form-control" id={props.id || "01"} aria-describedby="textHelp"
                    placeholder={props.holder || ""} minLength={props.minlength || 1}
                    maxLength={props.maxlength || 20} required />
                <small id="textHelp" className="form-text text-muted">{props.help || ""}</small>
            </div>
        );
    }
}