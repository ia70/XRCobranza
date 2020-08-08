import React, { Component } from 'react';

import { Btn } from '../../Form/Btn/Btn.jsx';
import { GetDate } from '../../utils/GetDate/GetDate.jsx';

import './Navbar.css';

//PROPIEDADES ------------------------------
//setLogo | setTitle | setDate | url

class Navbar extends Component {

    constructor(props) {
        super(props);

    }

    render() {
        let meta = "";
        let color_ = "";
        let fecha_ = "";

        if (this.props.meta != null) {
            if (this.props.meta < 40)
                color_ = "meta_mal";
            else if (this.props.meta < 70)
                color_ = "meta_regular";
            else
                color_ = "meta_bien";
            meta = <div className="col-auto mx-2 pb-1">
                <div className="row align-items-center">
                    <h4 className="navbarextends_label1 m-0 ">Avance total</h4>
                </div>

                <div className="row align-items-center">
                    <h4 className={"navbarextends_label2 m-0 col-auto " + color_}>{this.props.meta + "%"}</h4>
                </div>
            </div>
        }

        if (this.props.fecha != null) {
            fecha_ = <div className="col-auto mx-2 pb-1">
                <div className="row align-items-center">
                    <h4 className="navbarextends_fecha m-0 col-auto">{GetDate()}</h4>
                </div>
            </div>;
        }

        return (
            <div className="container-fluid bg-dark text-white">
                <div className="row align-items-center">

                    <div className="col">
                        <div className="row align-items-center m-0">
                            <div className="col p-0 align-items-center m-0">
                                <h3>{this.props.title}</h3>
                            </div>
                        </div>
                    </div>
                    {fecha_}
                    {meta}

                    <div className="col-auto mx-2 pb-1">
                        <div className="row align-items-center">
                            <h4 className="navbarextends_label1 m-0 ">{this.props.label1}</h4>
                        </div>

                        <div className="row align-items-center">
                            <h4 className="navbarextends_label2 m-0 col-auto">{this.props.label2}</h4>
                        </div>
                    </div>
                    <div className="col-auto p-0 m-1">
                        <Btn evento={this.props.evento} url={this.props.url || "/dashboard"} />
                    </div>

                </div>
            </div>
        );
    }
}

export default Navbar;