import Prim "mo:⛔";
import Int "mo:base/Int";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

module {

    public type Date = {
        year : Int;
        month : Int;
        day : Int;
        dayName : Text;
        hour : Int;
        minute : Int;
        second : Int;
        decimals : Int;
    };

    public func now() : Int { Prim.nat64ToNat(Prim.time()) };

    public func seg() : Int { now() / 1_000_000_000 };

    public func millis() : Int { now() / 1_000_000 };

    public func micros() : Int { now() / 1_000 };

    public func nanos() : Int { now() };

    func dateFrom(t : Int, div : Nat) : Date {
        var day = t / (86_400 * div) + 1;
        var dayName = dayOfWeek(day);
        var year = (day / 1461) * 4 + 1970;
        var month = 1;
        var decimals = t % div;
        let second = (t / (div)) % 60;
        let minute = (t / (60 * div)) % 60;
        let hour = (t / (3_600 * div)) % 24;
        day %= 1461;
        let dInY = [365, 365, 366, 365];
        let dInM = [var 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        var indexY = 0;
        label y loop {
            if (day > dInY[indexY]) {
                day -= dInY[indexY];
                year += 1;
                indexY += 1;
            } else {
                if (dInY[indexY] == 366) {
                    dInM[1] := 29;
                };
                var indexM = 0;
                label m loop {
                    if (day > dInM[indexM]) {
                        day -= dInM[indexM];
                        month += 1;
                        indexM += 1;
                    } else {
                        break m;
                    };
                };
                break y;
            };
        };
        return { year; month; day; dayName; hour; minute; second; decimals };
    };

    public func fromSec(t : Int) : Date { dateFrom(t, 1) };

    public func fromMillis(t : Int) : Date { dateFrom(t, 1000) };

    public func fromMicros(t : Int) : Date { dateFrom(t, 1_000_000) };

    public func fromNanos(t : Int) : Date { dateFrom(t, 1_000_000_000) };

    func fill(d : Text, size: Nat) : Text {
        var result = d;
        while (result.size() < size){
            result  := "0" # result;
        };
        result;
    };

    func toString(date : Date) : Text {
        Int.toText(date.year) #
        "-" #
        fill(Int.toText(date.month), 2) #
        "-" #
        fill(Int.toText(date.day), 2) #
        " " #
        fill(Int.toText(date.hour), 2) #
        ":" #
        fill(Int.toText(date.minute), 2) #
        ":" #
        fill(Int.toText(date.second), 2) #
        "." #
        fill(Int.toText(date.decimals), 9);
    };

    func intToNat(i : Int) : Nat {
        Prim.nat64ToNat(Prim.intToNat64Wrap(i));
    };

    func dayOfWeek(n : Int) : Text {
        let days = ["Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "Monday", "Tuesday"];
        return days[intToNat(n) % 7];
    };

    public func secToString(t : Int) : Text { toString(fromSec(t)) };

    public func millisToString(t : Int) : Text { toString(fromMillis(t)) };

    public func microsToString(t : Int) : Text { toString(fromMicros(t)) };

    public func nanosToString(t : Int) : Text { toString(fromNanos(t)) };

    //TODO Date to Timestamp

    func textToInt(t: Text): Int{
        func charToDigit(c: Char): Int{
            switch c{
                case ('0') {0: Int};
                case ('1') {1: Int};
                case ('2') {2: Int};
                case ('3') {3: Int};
                case ('4') {4: Int};
                case ('5') {5: Int};
                case ('6') {6: Int};
                case ('7') {7: Int};
                case ('8') {8: Int};
                case ('9') {9: Int};
                case _{ assert false; -1}
            };
        };
        var result: Int = 0;
        var i = t.size() - 1: Int;
        for (d in Text.toIter(t)){
            result += charToDigit(d) * (10** i);
            i -= 1;
        };
        result;
    };

    public func fromString(date: Text): Int{
        let components = Iter.toArray(Text.split(date, #char(' ')));
        let dateComp = Iter.toArray(Text.split(components[0], #char('-')));

        let years =  textToInt(dateComp[0]) - 1970;  
        var month = textToInt(dateComp[1]);
        if (month < 1 or month > 12){
            Prim.trap("Month number out of range. Format require -> YYYY-MM-DD HH:MM:SS.sss......")
        };
        let day = textToInt(dateComp[2]);

        var daysResult: Int = 1461 * (years / 4);
        var restY: Int = years % 4; 

        let dInY = [365, 365, 366, 365];
        let dInM = [var 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        
        var indexY = 0;
        while (restY > 0){
            restY -= 1;
            daysResult += dInY[indexY];
            indexY += 1;
        };

        if (indexY == 2){ dInM[1] := 29};
        if (day < 1 or day > dInM[Prim.nat64ToNat(Prim.intToNat64Wrap(month)) - 1]){
            Prim.trap("Day number out of range. Format require -> YYYY-MM-DD HH:MM:SS.sss......")
        };
        
        var indexM = 0;
        while(month > 1){
            daysResult += dInM[indexM];
            indexM += 1;
            month -= 1;
        };

        daysResult += day - 1;
        var nanos = daysResult * 86_400_000_000_000;
    
        if(components.size() > 1){
            let hourComp = Iter.toArray(Text.split(components[1], #char(':')));
            
            let hours = textToInt(hourComp[0]);
            if (hours < 0 or hours > 23){
                Prim.trap("Incorrect hour format. 00 to 23")
            };
            nanos +=  hours * 3_600_000_000_000;
            
            let minutes = textToInt(hourComp[1]);
            if (minutes < 0 or minutes > 59){
                Prim.trap("Incorrect minutes format. 00 to 59")
            };
            nanos +=  minutes * 60_000_000_000;

            let secAndDecimals = Iter.toArray(Text.split(hourComp[2], #char('.')));

            let sec = textToInt(secAndDecimals[0]);
            if (sec < 0 or sec > 59){
                Prim.trap("Incorrect seconds format. 00 to 59")
            };
            nanos +=  sec * 1_000_000_000;

            if(secAndDecimals.size() > 1){
                var decimals = secAndDecimals[1];
                assert (decimals.size() <= 9);
                while (decimals.size() < 9){ decimals := decimals # "0" };

                nanos += textToInt(decimals);
            };
        };
        nanos;
    };
};
