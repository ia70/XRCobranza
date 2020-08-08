import React, { Component } from 'react';
//PROPIEDADES -----------------------
// required | id | label | holder | help

class TextSearchExt extends Component  {

    constructor(props) {
        super(props);
        this.state = {
        };

        this.leer = this.leer.bind(this);
    }

    leer(){
        try {
            let cadena = document.getElementById(this.props.id).value;
            return cadena;
        } catch (error) {
            return "";
        }
    }

    render(){
        return (
            <div className="form-group col-xs-12 col-sm-6 col-lg-6" >
                <label htmlFor={this.props.id}>{this.props.label}</label>
                
                <div className="input-group">
                    <input id={this.props.id} type="text" className="form-control" placeholder="Buscar" aria-label="Recipient's username" 
                    aria-describedby="button-addon2" />

                    <div className="input-group-append">
                        <button className="btn btn-outline-secondary" type="button" id="button-addon2" 
                        onClick={(e) => this.props.evento(this.leer())} >Buscar</button>
                    </div>
                </div>
            </div>
        );
        }
}

export default TextSearchExt;