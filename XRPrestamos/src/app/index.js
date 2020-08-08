import React from 'react';
import ReactDOM from 'react-dom';
import App from "./App.jsx";

let container = document.getElementById('root');
let component = <App />;

ReactDOM.render(component, container);

/*
    NO OLVIDAR CAMBIAR DEL WEBPACK DONDE SE SERVIRA EL SERVICIO. SI NO ES CORRECTA NO SE EJECUTARA!
                    *************************************************************
*/