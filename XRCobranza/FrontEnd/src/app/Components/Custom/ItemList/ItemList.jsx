import React from 'react';
import { BtnClose } from '../../Form/BtnClose/BtnClose.jsx';
import ModalCollect from '../ModalCollect/ModalCollect.jsx';

import './ItemList.css';
/*PROPIEDADES -----------------------------------------------------

    	1 - folio_credito
		2 - ine
		3 - nombre (nombre completo)
		4 - alias
		5 - telefono
		6 - monto_credito
		7 - monto_total
		8 - monto_pago
		9 - pagado
		10 - atrasos_no
		11 - atrasos_monto
		12 - extra_no
		13 - extra_monto
		14 - restante_no
		15 - restante_monto
		16 - restante_total
        17 - abono_hoy
        18 - stateItem            Estado (1 Aprobado, 2 En espera, 3 Rechazado )
        19 - stateDescription     Texto de descripcion
        20 - amountDescription    Descripción del monto
        21 - amount               Monto $
        22 - close                Mostrar boton cerrar (true, false)
        23 - modal               (true | false) Especifica si debe mostrar ventana modal

*/
export function ItemList(props) {
    let btncerrar = <BtnClose label="X" />;
    let class_br = "";
    let class_bl = "";
    let texto = "";
    let mtarget = "";
    let mtoggle = "";

    let _evento = [];

    if (props.evento != null) {
        _evento = props.evento;
    }

    if (props.modal != null) {
        if (props.modal) {
            mtarget = "#item" + props.number;
            mtoggle = "modal";
        }
    }

    if (!props.close) {
        btncerrar = "";
    }

    if (props.stateDescription == "" || props.stateDescription == null) {
        switch (props.stateItem) {
            case 1 || "1":
                texto = "Aprobado";
                break;
            case 2 || "2":
                texto = "En espera";
                break;
            case 3 || "3":
                texto = "Rechazado";
                break;
            case 4 || "4":
                texto = "Pendiente";
                break;
        }
    } else {
        texto = props.stateDescription;
    }

    if (texto == "") {
        class_br = "stateitem_border_br";
        class_bl = "stateitem_border_bl";
    }

    return (
        <div className="col-xs-12 col-sm-6 col-lg-4 col-xl-3 mb-1">
            <div className="col-12 mb-2" data-toggle={mtoggle} data-target={mtarget}>
                <div className={"main container-fluid stateitem_border_br stateitem_border_bl stateitem_border_tr stateitem_border_tl stateitem_state_" + props.stateItem}>
                    <div className="row">
                        <div className={"col-xs-12 col-auto stateitem_num stateitem_center stateitem_border_tl " + class_bl}>
                            <h2>{props.number}</h2>
                        </div>
                        <div className="col col-xs-12">
                            <div className="row stateitem_alias stateitem_center stateitem_border_tr">
                                <div className="col col-xs-12 stateitem_center">
                                    {props.info.alias}
                                </div>
                                {btncerrar}
                            </div>
                            <div className="row stateitem stateitem_name stateitem_center">
                                {props.info.nombre}
                            </div>
                            <div className={"row align-self-stretch stateitem_center " + class_br}>
                                <div className="col col-xs-12 stateitem_state_amount_description">
                                    {props.amountDescription}
                                </div>
                                <div className={"col-auto col-xs-12 align-self-stretch align-items-center stateitem_state_amount " + class_br}>
                                    {"$" + props.amount}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="row stateitem stateitem_center stateitem_border_br stateitem_border_bl">
                        {texto}
                    </div>
                </div>
            </div>

            <ModalCollect
                id={"item" + props.number}
                number={props.number}
                info={props.info}
                evento={_evento}
            />
        </div>
    );
}