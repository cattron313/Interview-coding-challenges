function f(s) {
    rf(s, 0, null, null, false);    
}

function rf(s, index, subs, skipLength, needToSkipOverChars) {
    if (index === s.length) {
        return true;    
    }
    var ch = s.charAt(index);
    
    if (ch === "{") {
        var subs = "", skipLength = 0;
        var endOfInput = rf(s, index + 1, subs, skipLength + 1, needToSkipOverChars);
        if (endOfInput) {
            
        } else {
            return rf(s, index + 1, subs, skipLength + 1, true);
        }
    } else if (ch === "}") {
        print(subs);
        return false;
    } else {
        subs += ch;
        var needToSkipOverChars = rf(s, index + 1, subs, skipLength + 1, needToSkipOverChars);
        if (needToSkipOverChars) {
            return rf(s, index + skipLength + 1, subs, skipLength, false);     
        } else {
            return needToSkipOverChars;    
        }
    }
    
}

f("{a{bc{de}}f}");