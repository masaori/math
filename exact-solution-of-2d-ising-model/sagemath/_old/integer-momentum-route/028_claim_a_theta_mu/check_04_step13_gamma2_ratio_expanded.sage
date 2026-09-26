# ---------------------------------------------------------
# SageMath: Step 13 gamma_2 ratio の展開形
# 対象: parts/008_.../028_claim_a_theta_mu.typ Step 13
# 式ペア: gamma_2(theta)/gamma_2(-theta) = ((c_1-1)*e^(2i*theta) + (c_1+1) - 2*s_1*c_2*e^(i*theta)) / ((c_1+1) + (c_1-1)*e^(-2i*theta) - 2*s_1*c_2*e^(-i*theta))
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# ---------------------------------------------------------
# 式1: gamma_2(theta_mu) / gamma_2(-theta_mu)
# ---------------------------------------------------------
expr1 = gamma_2(theta_mu) / gamma_2(-theta_mu)

# ---------------------------------------------------------
# 式2: Step 13 最終形 (e^(i*theta)を分配した後)
# ---------------------------------------------------------
# 式2(typst):
# ((c_1 - 1) e^(2 sqrt(-1) theta_(mu)) + (c_1 + 1) - 2 s_1 c_2 e^(sqrt(-1) theta_(mu)))
# / ((c_1 + 1) + (c_1 - 1) e^(-2 sqrt(-1) theta_(mu)) - 2 s_1 c_2 e^(-sqrt(-1) theta_(mu)))
x = exp(i*theta_mu)
expr2 = (
    (c_1 - 1)*x^2 + (c_1 + 1) - 2*s_1*c_2*x
) / (
    (c_1 + 1) + (c_1 - 1)*x^(-2) - 2*s_1*c_2*x^(-1)
)

# ---------------------------------------------------------
# 検証
# ---------------------------------------------------------
numerical_check(expr1, expr2, label="Step 13: gamma_2 ratio expanded")
