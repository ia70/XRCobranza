import React from 'react';
import './TextPassword.css';
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
 
    ==>  id="" label="" holder="" help="" required={true} col={null} cls=""

    ------------------------------------------------------------------------
    NOTAS: Preferentemente el campo ó conjunto de campos debe ser contenido dentro de un "div" con className: "row"
*/

export function TextPassword(props) {
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
                <input type="password" className="form-control" id={props.id || "01"} aria-describedby="textHelp" placeholder={props.holder || ""} minLength={props.minlength || 1} maxLength={props.maxlength || 20} required />
                <small id="textHelp" className="form-text text-muted">{props.help || ""}</small>
            </div>
        );
    } else {
        return (
            <div className={"form-group" + columna + addclass}>
                <label htmlFor={props.id || "01"}>{props.label || ""}</label>
                <input type="password" className="form-control" id={props.id || "01"} aria-describedby="textHelp" placeholder={props.holder || ""} minLength={props.minlength || 1} maxLength={props.maxlength || 20} />
                <small id="textHelp" className="form-text text-muted">{props.help || ""}</small>
            </div>
        );
    }
}