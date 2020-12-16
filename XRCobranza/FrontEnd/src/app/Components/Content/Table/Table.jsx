import React from 'react';
import './Table.css';
//PROPIEDADES
// title
const max = 178542, min = 413;
export function Table(props) {
    let _pagos = [];
    let indice = 0;

    if (props.items != null) {
        _pagos = props.items.map((item) =>
            <tr key={props.id + 'tabla' + Math.random() * (max - min) + min} onClick={(e) => props.evento(item.indice)}>
                <th scope="row">{++indice}</th>
                <td>{item.monto}</td>
                <td>{item.fecha_abono}</td>
            </tr>);
    }

    return (
        <div className="col-12">
            <div className="table table-responsive table-hover">
                <table className="table bg-white">
                    <thead className="thead-dark">
                        <tr>
                            <th scope="col">No.</th>
                            <th scope="col">Monto</th>
                            <th scope="col">Fecha</th>
                        </tr>
                    </thead>
                    <tbody>
                        {_pagos}
                    </tbody>
                </table>
            </div>
        </div>
    );
}