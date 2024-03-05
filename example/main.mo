import Time "../src/time";

actor {

    public query func now(): async Int{
        Time.now();
    };

    public query func micros(): async Int{
        Time.micros();
    };
    
    public query func seg(): async Int{
        Time.seg();
    };

    public query func millis(): async Int{
        Time.millis();
    };

    public query func nanos(): async Int{
        Time.nanos();
    };

    public query func fromSec(t: Int): async Time.Date{
        Time.fromSec(t);
    };

    public query func fromMillis(t: Int): async Time.Date{
        Time.fromMillis(t);
    };

    public query func fromMicros(t: Int): async Time.Date{
        Time.fromMicros(t);
    };

    public query func fromNanos(t: Int): async Time.Date{
        Time.fromNanos(t);
    };


    public query func secToString(t: Int):async  Text{
        Time.secToString(t);
    };

    public query func millisToString(t: Int):async  Text{
        Time.millisToString(t);
    };

    public query func microsToString(t: Int):async  Text{
        Time.microsToString(t);
    };

    public query func nanosToString(t: Int):async  Text{
        Time.nanosToString(t);
    };

    public query func fromString(date: Text):async  Int{
        Time.fromString(date);

    };
};