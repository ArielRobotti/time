import Time "../src/time";

actor {

    public func now(): async Int{
        await Time.now();
    };

    public func micros(): async Int{
        await Time.micros();
    };
    
    public func seg(): async Int{
        await Time.seg();
    };

    public func millis(): async Int{
        await Time.millis();
    };

    public func nanos(): async Int{
        await Time.nanos();
    };

    public func fromSec(t: Int): async Time.Date{
        Time.fromSec(t);
    };

    public func fromMillis(t: Int): async Time.Date{
        Time.fromMillis(t);
    };

    public func fromMicros(t: Int): async Time.Date{
        Time.fromMicros(t);
    };

    public func fromNanos(t: Int): async Time.Date{
        Time.fromNanos(t);
    };


    public func secToString(t: Int):async  Text{
        Time.secToString(t);
    };

    public func millisToString(t: Int):async  Text{
        Time.millisToString(t);
    };

    public func microsToString(t: Int):async  Text{
        Time.microsToString(t);
    };

    public func nanosToString(t: Int):async  Text{
        Time.nanosToString(t);
    };

    
};