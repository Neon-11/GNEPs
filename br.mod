# need a code to track player number; taking one player at a time
var x1;
var x2;

# solver
option solver gurobi;

# a number required to indice player for fixing the strategy
# player of concern indiced: "n"
param n;
param x_minus_i;
param a;
param b;

# let a: = (n-2)/(-1);
# let b: = (n-1)/(1);

# if (n = 1) then
# {
  # printf "player 1 best response";
  # let a := 1;
  # let b := 0;
# }
# else
# {
  # printf "player 2 best response";
  # let a := 0;
  # let b := 3;
# }


# .out => .py ot read & create .dat file => br.mod => best response check

# optimization function 
minimize cost: a*x1 + b*x2;

## constraints on player 1
subject to C1: -1 <= x1 <= 2;
subject to C2: 2*x_minus_i <= x1 + 1;
subject to C3: 2*x_minus_i >= x1 - 2;

## constraint on player 2 
# subject to C1: -1 <= x1 <= 2;
# subject to C2: 2*x2 <= x_minus_i + 1;
# subject to C3: 2*x2 >= x_minus_i - 2;
