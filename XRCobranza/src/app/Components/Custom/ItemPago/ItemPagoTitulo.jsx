import React from 'react';

import './ItemPagoTitulo.css';

/* --> PROPIEDADES
    1- id
    2- label

*/
export function ItemPagoTitulo(props) {
    return (
            <div className="row px-3 itemtitulo m-0">
                <div className="col-8">
                    <h5>Concepto</h5>
                </div>
                <div className="col-4">
                    <h5>Monto</h5>
                </div>
            </div>
    );
}