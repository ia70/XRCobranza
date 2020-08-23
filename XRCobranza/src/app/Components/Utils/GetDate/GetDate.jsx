export function GetDate() {

    let date = new Date();

    let day = date.getDate();
    let month = date.getMonth() + 1;
    let year = date.getFullYear();

    let fecha = "";

    if (day < 10) {
        fecha = "0" + day + "\/";
    } else {
        fecha = day + "\/";
    }

    if (month < 10) {
        fecha += "0" + month + "\/";
    } else {
        fecha += month + "\/";
    }

    fecha += year;

    return fecha;
}