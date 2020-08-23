import React from 'react';
//PROPIEDADES -----------------------
// required | id | label | holder | help

export function TextTime(props) {
    if(props.required){
        return (
            <div className="form-group col-xs-12 col-sm-4 col-lg-3">
                <label htmlFor={props.id}>{props.label}</label>
                <input type="time" className="form-control" id={props.id} aria-describedby="emailHelp" placeholder={props.holder} required />
                    <small id="emailHelp" className="form-text text-muted">{props.help}</small>
            </div>
        );
    }else{
        return (
            <div className="form-group col-xs-12 col-sm-4 col-lg-3">
                <label htmlFor={props.id}>{props.label}</label>
                <input type="time" className="form-control" id={props.id} aria-describedby="emailHelp" placeholder={props.holder} />
                    <small id="emailHelp" className="form-text text-muted">{props.help}</small>
            </div>
        );
    }
}