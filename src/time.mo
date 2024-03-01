import Prim "mo:⛔";
import Int "mo:base/Int";

module {
    
    public type Date = {
        year : Int;
        month : Int;
        day : Int;
        hour : Int;
        minute : Int;
        second : Int;
        millis : Int;
    };

    public func now() : async Int {
        Prim.nat64ToNat(Prim.time());
    };

    public func seg() : async Int {
        Prim.nat64ToNat(Prim.time()) / 1_000_000_000;
    };

    public func millis() : async Int {
        Prim.nat64ToNat(Prim.time()) / 1_000_000;
    };
    
    public func micros() : async Int {
        Prim.nat64ToNat(Prim.time()) / 1_000;
    };
    
    public func nanos(): async Int{
        Prim.nat64ToNat(Prim.time())
    };

    func dateFrom(t : Int, div : Nat) : Date {
        var day = t / (86_400 * div) + 1;
        var year = (day / 1461) * 4 + 1970;
        var month = 1;
        var millis = t % div;
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
        return { year; month; day; hour; minute; second; millis };
    };

    public func fromSec(t : Int) : Date {
        dateFrom(t, 1);
    };

    public func fromMillis(t : Int) : Date {
        dateFrom(t, 1000);
    };

    public func fromMicros(t : Int) : Date {
        dateFrom(t, 1_000_000);
    };

    public func fromNanos(t : Int) : Date {
        dateFrom(t, 1_000_000_000);
    };

    func fill(d: Text): Text{
        if (d.size() == 1){
            "0" # d;
        }
        else{
            d;
        }
    };

    func toString(date : Date) : Text {
        Int.toText(date.year) #
        "-" #
        fill(Int.toText(date.month)) #
        "-" #
        fill(Int.toText(date.day)) #
        " T " #
        fill(Int.toText(date.hour)) #
        ":" #
        fill(Int.toText(date.minute)) #
        ":" #
        fill(Int.toText(date.second)) #
        "." #
        Int.toText(date.millis);
    };

    public func secToString(t : Int) : Text {
        toString(fromSec(t));
    };

    public func millisToString(t : Int) : Text {
        toString(fromMillis(t));
    };

    public func microsToString(t : Int) : Text {
        toString(fromMicros(t));
    };

    public func nanosToString(t : Int) : Text {
        toString(fromNanos(t));
    };


    //TODO Date to Timestamp

};
