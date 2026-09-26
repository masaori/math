# ---------------------------------------------------------
# SageMath: Step 9-11 gamma_2(theta)/gamma_2(-theta) の簡約
# 対象: parts/008_.../028_claim_a_theta_mu.typ Step 9-11
# 式ペア: gamma_2(theta)/gamma_2(-theta) = e^(i*theta)*(c_1*cos(theta)-i*sin(theta)-s_1*c_2) / (e^(-i*theta)*(c_1*cos(theta)+i*sin(theta)-s_1*c_2))
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# ---------------------------------------------------------
# 式1: gamma_2(theta_mu) / gamma_2(-theta_mu) (定義そのまま)
# ---------------------------------------------------------
# 式1(typst):
# (gamma_2(theta_(mu))) / (gamma_2(-theta_(mu)))
expr1 = gamma_2(theta_mu) / gamma_2(-theta_mu)

# ---------------------------------------------------------
# 式2: i*s_2* を約分した後の式 (Step 11)
# ---------------------------------------------------------
# 式2(typst):
# (e^(sqrt(-1) theta_(mu)) (c_1 cos(theta_(mu)) - sqrt(-1) sin(theta_(mu)) - s_1 c_2))
# / (e^(-sqrt(-1) theta_(mu)) (c_1 cos(theta_(mu)) + sqrt(-1) sin(theta_(mu)) - s_1 c_2))
expr2 = (
    exp(i*theta_mu) * (c_1*cos(theta_mu) - i*sin(theta_mu) - s_1*c_2)
) / (
    exp(-i*theta_mu) * (c_1*cos(theta_mu) + i*sin(theta_mu) - s_1*c_2)
)

# ---------------------------------------------------------
# 検証
# ---------------------------------------------------------
numerical_check(expr1, expr2, label="Step 9-11: gamma_2 ratio simplified")
