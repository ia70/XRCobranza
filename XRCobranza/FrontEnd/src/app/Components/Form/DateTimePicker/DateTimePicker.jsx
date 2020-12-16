import React from 'react';
//PROPIEDADES -----------------------
// required | id | label | holder | help

export function DateTimePicker(props) {
    if(props.required){
        return (
            <div className="form-group col-xs-12 col-sm-4 col-lg-3">
                <label htmlFor={props.id}>{props.label}</label>
                <input type="date" className="form-control" id={props.id} aria-describedby="textHelp" placeholder={props.holder} required />
                    <small id="textHelp" className="form-text text-muted">{props.help}</small>
            </div>
        );
    }else{
        return (
            <div className="form-group col-xs-12 col-sm-4 col-lg-3">
                <label htmlFor={props.id}>{props.label}</label>
                <input type="date" className="form-control" id={props.id} aria-describedby="textHelp" placeholder={props.holder} />
                    <small id="textHelp" className="form-text text-muted">{props.help}</small>
            </div>
        );
    }
}