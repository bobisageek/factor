
USING: kernel namespaces arrays sequences threads math math.vectors
       ui random bake springies springies.ui ;

IN: springies.models.2x2snake

: model ( -- )

{ } clone >nodes
{ } clone >springs
0.002 >time-slice
gravity off

1 147.0 324.0 0.0 0.0 1.0 1.0 mass
2 164.0 324.0 0.0 0.0 1.0 1.0 mass
3 182.0 324.0 0.0 0.0 1.0 1.0 mass
4 200.0 324.0 0.0 0.0 1.0 1.0 mass
5 218.0 324.0 0.0 0.0 1.0 1.0 mass
6 236.0 324.0 0.0 0.0 1.0 1.0 mass
7 254.0 324.0 0.0 0.0 1.0 1.0 mass
8 272.0 324.0 0.0 0.0 1.0 1.0 mass
9 290.0 324.0 0.0 0.0 1.0 1.0 mass
10 308.0 324.0 0.0 0.0 1.0 1.0 mass
11 326.0 324.0 0.0 0.0 1.0 1.0 mass
12 344.0 324.0 0.0 0.0 1.0 1.0 mass
13 362.0 324.0 0.0 0.0 1.0 1.0 mass
14 380.0 324.0 0.0 0.0 1.0 1.0 mass
15 398.0 324.0 0.0 0.0 1.0 1.0 mass
16 416.0 324.0 0.0 0.0 1.0 1.0 mass
17 434.0 324.0 0.0 0.0 1.0 1.0 mass
18 452.0 324.0 0.0 0.0 1.0 1.0 mass
19 470.0 324.0 0.0 0.0 1.0 1.0 mass
20 147.0 298.0 0.0 0.0 1.0 1.0 mass
21 164.0 298.0 0.0 0.0 1.0 1.0 mass
22 182.0 298.0 0.0 0.0 1.0 1.0 mass
23 200.0 298.0 0.0 0.0 1.0 1.0 mass
24 218.0 298.0 0.0 0.0 1.0 1.0 mass
25 236.0 298.0 0.0 0.0 1.0 1.0 mass
26 254.0 298.0 0.0 0.0 1.0 1.0 mass
27 272.0 298.0 0.0 0.0 1.0 1.0 mass
28 290.0 298.0 0.0 0.0 1.0 1.0 mass
29 308.0 298.0 0.0 0.0 1.0 1.0 mass
30 326.0 298.0 0.0 0.0 1.0 1.0 mass
31 344.0 298.0 0.0 0.0 1.0 1.0 mass
32 362.0 298.0 0.0 0.0 1.0 1.0 mass
33 380.0 298.0 0.0 0.0 1.0 1.0 mass
34 398.0 298.0 0.0 0.0 1.0 1.0 mass
35 416.0 298.0 0.0 0.0 1.0 1.0 mass
36 434.0 298.0 0.0 0.0 1.0 1.0 mass
37 452.0 298.0 0.0 0.0 1.0 1.0 mass
38 470.0 298.0 0.0 0.0 1.0 1.0 mass
1 1 2 200.0 1.500000 18.0 spng
2 3 2 200.0 1.500000 18.0 spng
3 3 4 200.0 1.500000 18.0 spng
4 4 5 200.0 1.500000 18.0 spng
5 5 6 200.0 1.500000 18.0 spng
6 6 7 200.0 1.500000 18.0 spng
7 7 8 200.0 1.500000 18.0 spng
8 8 9 200.0 1.500000 18.0 spng
9 9 10 200.0 1.500000 18.0 spng
10 10 11 200.0 1.500000 18.0 spng
11 11 12 200.0 1.500000 18.0 spng
12 12 13 200.0 1.500000 18.0 spng
13 13 14 200.0 1.500000 18.0 spng
14 14 15 200.0 1.500000 18.0 spng
15 15 16 200.0 1.500000 18.0 spng
16 16 17 200.0 1.500000 18.0 spng
17 17 18 200.0 1.500000 18.0 spng
18 18 19 200.0 1.500000 18.0 spng
19 1 3 200.0 1.500000 36.0 spng
20 2 4 200.0 1.500000 36.0 spng
21 3 5 200.0 1.500000 36.0 spng
22 4 6 200.0 1.500000 36.0 spng
23 5 7 200.0 1.500000 36.0 spng
24 6 8 200.0 1.500000 36.0 spng
25 7 9 200.0 1.500000 36.0 spng
26 8 10 200.0 1.500000 36.0 spng
27 9 11 200.0 1.500000 36.0 spng
28 10 12 200.0 1.500000 36.0 spng
29 11 13 200.0 1.500000 36.0 spng
30 12 14 200.0 1.500000 36.0 spng
31 13 15 200.0 1.500000 36.0 spng
32 14 16 200.0 1.500000 36.0 spng
33 15 17 200.0 1.500000 36.0 spng
34 16 18 200.0 1.500000 36.0 spng
35 17 19 200.0 1.500000 36.0 spng
36 20 21 200.0 1.500000 18.0 spng
37 22 21 200.0 1.500000 18.0 spng
38 22 23 200.0 1.500000 18.0 spng
39 23 24 200.0 1.500000 18.0 spng
40 24 25 200.0 1.500000 18.0 spng
41 25 26 200.0 1.500000 18.0 spng
42 26 27 200.0 1.500000 18.0 spng
43 27 28 200.0 1.500000 18.0 spng
44 28 29 200.0 1.500000 18.0 spng
45 29 30 200.0 1.500000 18.0 spng
46 30 31 200.0 1.500000 18.0 spng
47 31 32 200.0 1.500000 18.0 spng
48 32 33 200.0 1.500000 18.0 spng
49 33 34 200.0 1.500000 18.0 spng
50 34 35 200.0 1.500000 18.0 spng
51 35 36 200.0 1.500000 18.0 spng
52 36 37 200.0 1.500000 18.0 spng
53 37 38 200.0 1.500000 18.0 spng
54 20 22 200.0 1.500000 36.0 spng
55 21 23 200.0 1.500000 36.0 spng
56 22 24 200.0 1.500000 36.0 spng
57 23 25 200.0 1.500000 36.0 spng
58 24 26 200.0 1.500000 36.0 spng
59 25 27 200.0 1.500000 36.0 spng
60 26 28 200.0 1.500000 36.0 spng
61 27 29 200.0 1.500000 36.0 spng
62 28 30 200.0 1.500000 36.0 spng
63 29 31 200.0 1.500000 36.0 spng
64 30 32 200.0 1.500000 36.0 spng
65 31 33 200.0 1.500000 36.0 spng
66 32 34 200.0 1.500000 36.0 spng
67 33 35 200.0 1.500000 36.0 spng
68 34 36 200.0 1.500000 36.0 spng
69 35 37 200.0 1.500000 36.0 spng
70 36 38 200.0 1.500000 36.0 spng
71 1 20 200.0 1.500000 26.0 spng
72 2 21 200.0 1.500000 26.0 spng
73 3 22 200.0 1.500000 26.0 spng
74 4 23 200.0 1.500000 26.0 spng
75 5 24 200.0 1.500000 26.0 spng
76 25 6 200.0 1.500000 26.0 spng
77 7 26 200.0 1.500000 26.0 spng
78 27 8 200.0 1.500000 26.0 spng
79 9 28 200.0 1.500000 26.0 spng
80 29 10 200.0 1.500000 26.0 spng
81 11 30 200.0 1.500000 26.0 spng
82 31 12 200.0 1.500000 26.0 spng
83 13 32 200.0 1.500000 26.0 spng
84 33 14 200.0 1.500000 26.0 spng
85 15 34 200.0 1.500000 26.0 spng
86 35 16 200.0 1.500000 26.0 spng
87 17 36 200.0 1.500000 26.0 spng
88 37 18 200.0 1.500000 26.0 spng
89 19 38 200.0 1.500000 26.0 spng
90 1 21 200.0 1.500000 31.064449 spng
91 2 20 200.0 1.500000 31.064449 spng
92 2 22 200.0 1.500000 31.622777 spng
93 3 21 200.0 1.500000 31.622777 spng
94 3 23 200.0 1.500000 31.622777 spng
95 4 22 200.0 1.500000 31.622777 spng
96 4 24 200.0 1.500000 31.622777 spng
97 5 23 200.0 1.500000 31.622777 spng
98 5 25 200.0 1.500000 31.622777 spng
99 6 24 200.0 1.500000 31.622777 spng
100 6 26 200.0 1.500000 31.622777 spng
101 7 25 200.0 1.500000 31.622777 spng
102 7 27 200.0 1.500000 31.622777 spng
103 8 26 200.0 1.500000 31.622777 spng
104 8 28 200.0 1.500000 31.622777 spng
105 9 27 200.0 1.500000 31.622777 spng
106 9 29 200.0 1.500000 31.622777 spng
107 10 28 200.0 1.500000 31.622777 spng
108 10 30 200.0 1.500000 31.622777 spng
109 11 29 200.0 1.500000 31.622777 spng
110 11 31 200.0 1.500000 31.622777 spng
111 12 30 200.0 1.500000 31.622777 spng
112 12 32 200.0 1.500000 31.622777 spng
113 13 31 200.0 1.500000 31.622777 spng
114 13 33 200.0 1.500000 31.622777 spng
115 14 32 200.0 1.500000 31.622777 spng
116 14 34 200.0 1.500000 31.622777 spng
117 15 33 200.0 1.500000 31.622777 spng
118 15 35 200.0 1.500000 31.622777 spng
119 16 34 200.0 1.500000 31.622777 spng
120 16 36 200.0 1.500000 31.622777 spng
121 17 35 200.0 1.500000 31.622777 spng
122 17 37 200.0 1.500000 31.622777 spng
123 18 36 200.0 1.500000 31.622777 spng
124 18 38 200.0 1.500000 31.622777 spng
125 19 37 200.0 1.500000 31.622777 spng
126 1 22 200.0 1.500000 43.600459 spng
127 3 20 200.0 1.500000 43.600459 spng
128 2 23 200.0 1.500000 44.407207 spng
129 4 21 200.0 1.500000 44.407207 spng
130 3 24 200.0 1.500000 44.407207 spng
131 5 22 200.0 1.500000 44.407207 spng
132 4 25 200.0 1.500000 44.407207 spng
133 6 23 200.0 1.500000 44.407207 spng
134 5 26 200.0 1.500000 44.407207 spng
135 7 24 200.0 1.500000 44.407207 spng
136 6 27 200.0 1.500000 44.407207 spng
137 8 25 200.0 1.500000 44.407207 spng
138 7 28 200.0 1.500000 44.407207 spng
139 9 26 200.0 1.500000 44.407207 spng
140 8 29 200.0 1.500000 44.407207 spng
141 10 27 200.0 1.500000 44.407207 spng
142 9 30 200.0 1.500000 44.407207 spng
143 11 28 200.0 1.500000 44.407207 spng
144 10 31 200.0 1.500000 44.407207 spng
145 12 29 200.0 1.500000 44.407207 spng
146 11 32 200.0 1.500000 44.407207 spng
147 13 30 200.0 1.500000 44.407207 spng
148 12 33 200.0 1.500000 44.407207 spng
149 14 31 200.0 1.500000 44.407207 spng
150 13 34 200.0 1.500000 44.407207 spng
151 15 33 200.0 1.500000 31.622777 spng
152 32 15 200.0 1.500000 44.407207 spng
153 14 35 200.0 1.500000 44.407207 spng
154 16 33 200.0 1.500000 44.407207 spng
155 15 36 200.0 1.500000 44.407207 spng
156 34 17 200.0 1.500000 44.407207 spng
157 16 37 200.0 1.500000 44.407207 spng
158 18 35 200.0 1.500000 44.407207 spng
159 17 38 200.0 1.500000 44.407207 spng
160 19 36 200.0 1.500000 44.407207 spng

! Send the half of the snake in a random direction

nodes> 10 [ swap nth ]      curry* map
nodes> 10 [ 19 + swap nth ] curry* map append
100 random -50 +   100 random 100 + { -1 1 } random *  2array
[ swap set-node-vel ] curry
each ;

: go ( -- ) [ model ] go* ;

MAIN: go