
import time
Q = 1461
# now = int(time.time())
# dias = int(now/ 86400)
# print("Dias: " , dias)
# años = int(dias/Q) * 4
# print("Año: ", años +1970)
# resto = dias % Q
# print(resto- 365 -365 - 31 - 28)

def date(TS):
    dia = int(TS/86400) + 1
    años = (dia//1461) * 4
    dia %= 1461
    mes = 1
    for i in (365,365,366,365):
        print(i)
        if i < dia:
            dia -= i
            años += 1
        else:
            meses = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]     
            if i == 366:
                meses[1] = 29
            for m in meses:
                if dia > m:
                    dia -= m
                    mes += 1
                else:
                    break

    return str(años + 1970), str(mes), str(dia)

a = 365*24*60*60 * 15
print(a)

print(date(a))

print(24 * 60 *60 *1000)