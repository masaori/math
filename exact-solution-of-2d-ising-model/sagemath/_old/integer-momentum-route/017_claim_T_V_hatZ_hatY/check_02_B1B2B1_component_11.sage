# ---------------------------------------------------------
# SageMath: B_1(theta) B_2 B_1(theta) の (2,2) 成分 = A(theta) の (2,2) 成分
# 対象: structured-latex T_V_hatZ_hatY の proof Step 2-5
# 式ペア: (B_1 B_2 B_1)_(2,2) = gamma_1(theta)
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))
load(os.path.join(_dir, '_prelude.sage'))

expr1 = B1_B2_B1(theta_mu)[1][1]
expr2 = A_theta(theta_mu)[1][1]

numerical_check(expr1, expr2, tol=1e-5, label="(B_1 B_2 B_1)_(2,2) = A(theta)_(2,2)")
