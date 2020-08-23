export function GetDateDB() {

    let date = new Date();

    let day = date.getDate();
    let month = date.getMonth() + 1;
    let year = date.getFullYear();

    let fecha = "";

    fecha += year + "\/";

    if (month < 10) {
        fecha += "0" + month + "\/";
    } else {
        fecha += month + "\/";
    }

    if (day < 10) {
        fecha += "0" + day;
    } else {
        fecha += day;
    }

    return fecha;
}