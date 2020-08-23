import React, { Component } from 'react';
import './TextBox.css';
/* -->  PROPIEDADES  VERIFICADO --------------------------------------------

    1- id           > Identificador único del campo
    2- label        > Etiqueta que aparecerá sobre el campo
    3- holder       > Texto que aparecerá dentro del campo
    4- help         > Texto de ayuda que aparecerá debajo del campo
    5- required     > Especifica si el campo es requerido (true | false)
    6- col          > Especifica el tamaño del campo estilo Bootstrap (1 - 12)
    7- cls          > Agregar clases Bootstrap ("clas1 class2 etc")
    8- minlength    > Indica el número minimo de caracteres del campo (número)
    9- maxlength    > Indica el número maximo de caracteres del campo (número)
    10- event       >Evento del campo o función
 
    ==>  id="" label="" holder="" help="" required={true} col={null} cls=""

    ------------------------------------------------------------------------
    NOTAS: Preferentemente el campo ó conjunto de campos debe ser contenido dentro de un "div" con className: "row"
*/

class TextBox extends Component {

    constructor(props) {
        super(props);
        this.handleChange = this.handleChange.bind(this);
    }

    handleChange(e) {
        //let name = e.target.name;
        //let value = e.target.value;

        //props.evento(e);
        /*
        this.setState({
            [name]: value
        })*/
    };

    render() {
        let size = " col-xs-12 col-sm-4 col-lg-3";
        let addclass = "";
        let lectura = false;

        if (this.props.size != null) {
            size = " " + this.props.size + " ";
        }

        if (this.props.class != null) {
            addclass = " " + this.props.class;
        }

        try {
            lectura = this.props.readonly;
        } catch (error) {
            lectura = false;
        }


        if (this.props.required) {
            return (
                <div className={"form-group" + size}>
                    <label htmlFor={this.props.id || "01"}>{this.props.label || ""}</label>
                    <input type="text" className={"form-control " + addclass} id={this.props.id || "01"} aria-describedby="textHelp"
                        onChange={this.handleChange} placeholder={this.props.holder || ""} minLength={this.props.minlength || 1}
                        maxLength={this.props.maxlength || 20} required readOnly={lectura} />
                    <small id="textHelp" className="form-text text-muted">{this.props.help || ""}</small>
                </div>
            );
        } else {
            return (
                <div className={"form-group" + size}>
                    <label htmlFor={this.props.id || "01"}>{this.props.label || ""}</label>
                    <input type="text" className={"form-control " + addclass} id={this.props.id || "01"} aria-describedby="textHelp"
                        onChange={this.handleChange} placeholder={this.props.holder || ""} minLength={this.props.minlength || 1}
                        maxLength={this.props.maxlength || 20} readOnly={lectura} />
                    <small id="textHelp" className="form-text text-muted">{this.props.help || ""}</small>
                </div>
            );
        }
    }
}

export default TextBox;