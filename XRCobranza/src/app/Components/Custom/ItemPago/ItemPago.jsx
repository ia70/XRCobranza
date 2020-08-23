import React from 'react';
import { BtnClose } from '../../Form/BtnClose/BtnClose.jsx';
import ModalRuta from '../ModalRuta/ModalRuta.jsx';

import './ItemPago.css'
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
export function ItemPago(props) {
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

    let porcentaje = (100 / props.info.total_deberia_recolectar_dia) * props.info.total_recolectado_sin_extras;
    let estado = 0;

    if(porcentaje < 65) {
        estado = 4;
        texto = Math.round(porcentaje) + "%   Mal";
    }else if(porcentaje <= 75){
        estado = 2;
        texto = Math.round(porcentaje) + "%   Regular";
    }else if(porcentaje <= 90){
        estado = 1;
        texto = Math.round(porcentaje) + "%   Bien";
    }else{
        estado = 5;
        texto = Math.round(porcentaje) + "%   Muy bien";
    }


    if (texto == "") {
        class_br = "stateitem_border_br";
        class_bl = "stateitem_border_bl";
    }

    return (
        <div className="col-xs-12 col-sm-6 col-lg-4 col-xl-3 mb-1">
            <div className="col-12 mb-2" data-toggle={mtoggle} data-target={mtarget}>
                <div className={"main container-fluid stateitem_border_br stateitem_border_bl stateitem_border_tr stateitem_border_tl stateitem_state_" + estado}>
                    <div className="row">
                        <div className={"col-xs-12 col-auto stateitem_num stateitem_center stateitem_border_tl " + class_bl}>
                            <h2>{props.number}</h2>
                        </div>
                        <div className="col col-xs-12">
                            <div className="row stateitem_alias stateitem_center stateitem_border_tr">
                                <div className="col col-xs-12 stateitem_center">
                                    {props.info.ruta_descripcion}
                                </div>
                            </div>
                            <div className="row stateitem stateitem_name stateitem_center">
                                {props.info.id_usuario}
                            </div>
                            <div className={"row align-self-stretch stateitem_center " + class_br}>
                                <div className="col col-xs-12 stateitem_state_amount_description">
                                    {"Recolectado: "}
                                </div>
                                <div className={"col-auto col-xs-12 align-self-stretch align-items-center stateitem_state_amount " + class_br}>
                                    {props.info.total_recolectado}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="row stateitem stateitem_center stateitem_border_br stateitem_border_bl">
                        {texto}
                    </div>
                </div>
            </div>

            <ModalRuta
                id={"item" + props.number}
                number={props.number}
                info={props.info}
                evento={_evento}
            />
        </div>
    );
}