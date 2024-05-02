var x1 integer;
var x2 integer;

var v11;
var v12;
var v13;
# var v14;

var v21;
var v22;
var v23;
# var v24;

param x_minus_1;
param x_minus_2; 
param O1;
param O2;
param M_obj;
param M_fea;

# option solver gurobi;

# changing the loss functions
# minimize Displacement: (x1 - (-1*v11 -2*v12 + (2*x2-1)*v13 + (-2*x2-2)*v14)) + (x1*x2 - (-(1+x1)*v21 + (x1 - 2)*v22 - ((1+x1)/2)*v23 + ((-2+x1)/2)*v24));
minimize Displacement: (x1 - (0*v11 + (-11/4)*v12 + (-3*x2-8.5)*v13)) + (x1*x1*x2 - (0*v21 + (-13/6)*v22 + (-2*x1-8.5)*v23));

#################################################################
# binary variable
# var z integer;
# subject to bin0: z >= 0;
# subject to bin1: z <= 1;

# # NO-GOOD CUT = 1pt removed => (-1, -2)
var del1 integer;
subject to bin0: del1 >= 0;
subject to bin1: del1 <= 1;
var z1 integer;
subject to c1: z1 <= x1 - x_minus_2 + (4)*del1;
subject to c2: z1 <= -(x1 - x_minus_2) + (4)*(1-del1);
var del2 integer;
subject to bin_0: del2 >= 0;
subject to bin_1: del2 <= 1;
var z2 integer;
subject to c3: z2 <= x2 - x_minus_1 + (4)*del2;
subject to c4: z2 <= -(x2 - x_minus_1) + (4)*(1-del2);
subject to c5: z1 + z2 >= 1;
 
 
param x_minus_1_p;
param x_minus_2_p; 
# # NO-GOOD CUT = 1pt removed => (0, -2)
var del1_p integer;
subject to bin0_p: del1_p >= 0;
subject to bin1_p: del1_p <= 1;
var z1_p integer;
subject to c1_p: z1_p <= x1 - x_minus_2_p + (4)*del1_p;
subject to c2_p: z1_p <= -(x1 - x_minus_2_p) + (4)*(1-del1_p);
var del2_p integer;
subject to bin_0_p: del2_p >= 0;
subject to bin_1_p: del2_p <= 1;
var z2_p integer;
subject to c3_p: z2_p <= x2 - x_minus_1_p + (4)*del2_p;
subject to c4_p: z2_p <= -(x2 - x_minus_1_p) + (4)*(1-del2_p);
subject to c5_p: z1_p + z2_p >= 1;

param x_minus_1_q;
param x_minus_2_q; 
# # NO-GOOD CUT = 1pt removed => (0, 0)
var del1_q integer;
subject to bin0_q: del1_q >= 0;
subject to bin1_q: del1_q <= 1;
var z1_q integer;
subject to c1_q: z1_q <= x1 - x_minus_2_q + (4)*del1_q;
subject to c2_q: z1_q <= -(x1 - x_minus_2_q) + (4)*(1-del1_q);
var del2_q integer;
subject to bin_0_q: del2_q >= 0;
subject to bin_1_q: del2_q <= 1;
var z2_q integer;
subject to c3_q: z2_q <= x2 - x_minus_1_q + (4)*del2_q;
subject to c4_q: z2_q <= -(x2 - x_minus_1_q) + (4)*(1-del2_q);
subject to c5_q: z1_q + z2_q >= 1;

param x_minus_1_r;
param x_minus_2_r; 
# # NO-GOOD CUT = 1pt removed => (-1, 0)
var del1_r integer;
subject to bin0_r: del1_r >= 0;
subject to bin1_r: del1_r <= 1;
var z1_r integer;
subject to c1_r: z1_r <= x1 - x_minus_2_r + (4)*del1_r;
subject to c2_r: z1_r <= -(x1 - x_minus_2_r) + (4)*(1-del1_r);
var del2_r integer;
subject to bin_0_r: del2_r >= 0;
subject to bin_1_r: del2_r <= 1;
var z2_r integer;
subject to c3_r: z2_r <= x2 - x_minus_1_r + (4)*del2_r;
subject to c4_r: z2_r <= -(x2 - x_minus_1_r) + (4)*(1-del2_r);
subject to c5_r: z1_r + z2_r >= 1;

# MY PROPOSED SOLUTION
# subject to new_cut: (x1 - x_minus_2)*(x1- x_minus_2) + (x2 - x_minus_1)*(x2 - x_minus_1) >= 1;
################################################################

# OBVIOUSLY THIS WILL NOT WORK:
# subject to cond: (x1 - (-1*v11 -2*v12 + (2*x2-1)*v13 + (-2*x2-2)*v14)) + (3*x2 - (-(1+x1)*v21 + (x1 - 2)*v22 - ((1+x1)/2)*v23 + ((-2+x1)/2)*v24)) <= 1;

################################################################

# new cut: [as per the discusssion of 10/04/2024]
# subject to new_cut: (-3)*v22 + (-3/2)*v24 >= -3;

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
# subject to C14: v14 >=0;

subject to C21: v21 >=0;
subject to C22: v22 >=0;
subject to C23: v23 >=0;
# subject to C24: v24 >=0;

# subject to C_1: v11 - v12 + v13 - v14 = 1;
# subject to C_2: v24 - v23 = x1;

subject to C_1: (-1)*v11 + (1)*v12 + (2)*v13 = 1;
subject to C_2: (-1)*v21 + (1)*v22 + (3)*v23 = x1*x1;

subject to C1: -11/4 <= x1 <= 0;
subject to C2: -13/6 <= x2 <= 0;
subject to C3: 2*x1 + 3*x2 + 8.5 >=0;
