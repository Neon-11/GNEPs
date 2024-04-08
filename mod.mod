var x1 integer;
var x2 integer;

var v11;
var v12;
var v13;
var v14;

var v21;
var v22;
var v23;
var v24;

param x_minus_1;
param x_minus_2; 
param O1;
param O2;
param M_obj;
param M_fea;

# option solver gurobi;
minimize Displacement: (x1 - (-1*v11 -2*v12 + (2*x2-1)*v13 + (-2*x2-2)*v14)) + (3*x2 - (-(1+x1)*v21 + (x1 - 2)*v22 - ((1+x1)/2)*v23 + ((-2+x1)/2)*v24));

#################################################################
# binary variable
# var z integer;
# subject to bin0: z >= 0;
# subject to bin1: z <= 1;

# NO-GOOD CUT = 1pt removed
# var del1 integer;
# subject to bin0: del1 >= 0;
# subject to bin1: del1 <= 1;
# var z1 integer;
# subject to c1: z1 <= x1 - x_minus_2 + (4)*del1;
# subject to c2: z1 <= -(x1 - x_minus_2) + (4)*(1-del1);
# var del2 integer;
# subject to bin_0: del2 >= 0;
# subject to bin_1: del2 <= 1;
# var z2 integer;
# subject to c3: z2 <= x2 - x_minus_1 + (4)*del2;
# subject to c4: z2 <= -(x2 - x_minus_1) + (4)*(1-del2);
# subject to c5: z1 + z2 >= 1;
# 
# MY PROPOSED SOLUTION
# subject to new_cut: (x1 - x_minus_2)*(x1- x_minus_2) + (x2 - x_minus_1)*(x2 - x_minus_1) >= 1;
################################################################

# OBVIOUSLY THIS WILL NOT WORK:
# subject to cond: (x1 - (-1*v11 -2*v12 + (2*x2-1)*v13 + (-2*x2-2)*v14)) + (3*x2 - (-(1+x1)*v21 + (x1 - 2)*v22 - ((1+x1)/2)*v23 + ((-2+x1)/2)*v24)) <= 1;

################################################################

# additional constraint
# subject to cut: (-1)*v21 + (-2)*v22 + (-.5)*v23 + (-1)*v24 >= O2 - M_obj*(1-z);
# subject to space1: x2 >= x_minus_1 + (-M_fea)*(1-z);
# subject to space2: x2 <= x_minus_1 + (M_fea)*(1-z);

# knwoing the cut:
# subject to cut: (-1)*v11 + (-2)*v12 + (-3)*v13 + (0)*v14 >= O1;
# subject to cut: (-1)*v11 + (-2)*v12 + (-3)*v13 + (0)*v14 >= O1 - M_obj*(1-z);
# subject to space1: z*(x2 - x_minus_1) = 0;
# subject to space2: (x2 - x_minus_1)*(x2 - x_minus_1) >= 1-z;

subject to C11: v11 >=0;
subject to C12: v12 >=0;
subject to C13: v13 >=0;
subject to C14: v14 >=0;

subject to C21: v21 >=0;
subject to C22: v22 >=0;
subject to C23: v23 >=0;
subject to C24: v24 >=0;

subject to C_1: v11 - v12 + v13 - v14 = 1;
subject to C_2: v24 - v23 = 3;

subject to C1: -1 <= x1 <= 2;
subject to C2: 2*x2 <= x1 + 1;
subject to C3: 2*x2 >= x1 - 2;
