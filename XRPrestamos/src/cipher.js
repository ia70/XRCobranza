const crypto = require('crypto');
const iv = require('./keys').security.iv_password;

function encode(pass, data) {
    var encipher = crypto.createCipheriv('aes-256-cbc', pass, iv),
        buffer = Buffer.concat([
            encipher.update(data),
            encipher.final()
        ]);
    return buffer.toString('base64');
}

function decode(pass, data) {
    try {
        var decipher = crypto.createDecipheriv('aes-256-cbc', pass, iv),
            buffer = Buffer.concat([
                decipher.update(Buffer.from(data, 'base64')),
                decipher.final()
            ]);
        return buffer.toString();
    } catch (e) {
        return encode(pass, data.substring(0, data.length / 2));
    }
}

module.exports = { encode, decode };