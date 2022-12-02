function mysql_real_escape_string (str) {
    return str.replace(/[\x09\n\r"'\\]/g, function (char) {
        switch (char) {
            case "\x09":
                return "\\t";
            case "\n":
                return "\\n";
            case "\r":
                return "\\r";
            case "\"":
            case "'":
            case "\\":
                return "\\"+char; // prepends a backslash to backslash, percent,
                                  // and double/single quotes
        }
    });
}

function escapeObjectStrings(obj) {
    for (var property in obj) {
        if (obj.hasOwnProperty(property)) {
            if (typeof obj[property] !== "string")
                escapeObjectStrings(obj[property]);
            else
            //console.log(property + "   " + obj[property]);
                obj[property] = mysql_real_escape_string(obj[property]);
        }
    }

}

module.exports = {

    escapeObjectStrings: escapeObjectStrings

}