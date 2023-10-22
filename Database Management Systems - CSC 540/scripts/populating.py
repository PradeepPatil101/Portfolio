services={101:2,
102:3,
103:4,
104:2,
105:3,
106:3,
107:5,
108:3,
109:1,
110:2,
111:4,
112:3,
113:6,
114:7,
115:8}

cars = ["Honda","Nissan","Toyota"]

store1Prices = [
50,
70,
60,
140,
175,
160,
400,
500,
450,
590,
700,
680,
1000,
1200,
1100,
120,
190,
200,
195,
210,
215,
300,
310,
305]

store2Prices = [
70,
90,
80,
160,
195,
180,
420,
520,
470,
610,
720,
700,
1020,
1220,
1120,
125,
195,
205,
200,
215,
220,
305,
315,
310
]

store3Prices = [
85,
105,
95,
175,
210,
195,
435,
535,
485,
625,
735,
715,
1035,
1235,
1135,
140,
180,
195,
210,
220,
215,
310,
305,
310
]

s = ""



for service in services:
    for i in range(3):
        tier = services[service]
        priceIndex = (tier-1) * 3 + i
        s += "insert into service values ( '"+cars[i]+"', "+str(service)+", 30001, "+str(store1Prices[priceIndex])+");\n"

for service in services:
    for i in range(3):
        tier = services[service]
        priceIndex = (tier-1) * 3 + i
        s += "insert into service values ( '"+cars[i]+"', "+str(service)+", 30002, "+str(store2Prices[priceIndex])+");\n"

for service in services:
    for i in range(3):
        tier = services[service]
        priceIndex = (tier-1) * 3 + i
        s += "insert into service values ( '"+cars[i]+"', "+str(service)+", 30003, "+str(store3Prices[priceIndex])+");\n"

print(s)

s = ""
i=1
for week in range(4):
    for day in range(7):
        for slot in range(11):
            s += "insert into Timeslot values ( "+str(i)+", "+str(slot+1)+", "+str(week+1)+", "+str(day+1)+");\n"
            i = i+1

print(s)