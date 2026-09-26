# ---------------------------------------------------------
# SageMath: Step 12b c_1*cos(theta) + i*sin(theta) のEuler表示
# 対象: parts/008_.../028_claim_a_theta_mu.typ Step 12
# 式ペア: c_1*cos(theta) + i*sin(theta) = ((c_1+1)*e^(i*theta) + (c_1-1)*e^(-i*theta))/2
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# ---------------------------------------------------------
# 式1: c_1*cos(theta_mu) + i*sin(theta_mu)
# ---------------------------------------------------------
# 式1(typst):
# c_1 cos(theta_(mu)) + sqrt(-1) sin(theta_(mu))
expr1 = c_1*cos(theta_mu) + i*sin(theta_mu)

# ---------------------------------------------------------
# 式2: ((c_1+1)*e^(i*theta) + (c_1-1)*e^(-i*theta))/2
# ---------------------------------------------------------
# 式2(typst):
# ((c_1 + 1) e^(sqrt(-1) theta_(mu)) + (c_1 - 1) e^(-sqrt(-1) theta_(mu))) / 2
expr2 = ((c_1 + 1)*exp(i*theta_mu) + (c_1 - 1)*exp(-i*theta_mu)) / 2

# ---------------------------------------------------------
# 検証
# ---------------------------------------------------------
numerical_check(expr1, expr2, tol=1e-6, label="Step 12b: c_1*cos + i*sin = Euler form")
