var x_b;
var x_a;
option solver cplex;
maximize P: 2*x_b + 3*x_a;
subject to C1: 2*x_a + 3*x_b <= 10;
subject to C2: x_a <= 4;
subject to C3: x_b <= 3;
