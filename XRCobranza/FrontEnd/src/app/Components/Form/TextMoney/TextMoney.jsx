import React from 'react';
//PROPIEDADES -----------------------
// required | id | label | holder | help

export function TextMoney(props) {
    let classs = "col-xs-12 col-sm-4 col-lg-3";

    if(props.clases != null){
        classs = props.clases;
    }


    if (props.required != null) {
        return (
            <div className={"form-group " + classs}>
                <label htmlFor={props.id}>{props.label}</label>
                <div className="input-group">
                    <div className="input-group-prepend">
                        <span className="input-group-text">$</span>
                    </div>
                    <input id={props.id} type="number" onChangeCapture={(props.evento != null ? (e) => props.evento(document.getElementById(props.id).value) : null)} className="form-control" min={0} placeholder={props.holder || ""} aria-label="Amount (to the nearest dollar)" required />
                </div>
            </div>
        );
    } else {
        return (
            <div className={"form-group " + classs}>
                <label htmlFor={props.id}>{props.label}</label>
                <div className="input-group">
                    <div className="input-group-prepend">
                        <span className="input-group-text">$</span>
                    </div>
                    <input id={props.id} type="number" onChangeCapture={(props.evento != null ? (e) => props.evento(document.getElementById(props.id).value) : null)} className="form-control" min={0}  placeholder={props.holder || ""} aria-label="Amount (to the nearest dollar)" />
                </div>
            </div>
        );
    }
}