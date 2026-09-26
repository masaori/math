# ---------------------------------------------------------
# SageMath: Step 18 gamma_2 ratio = alpha 積の比
# 対象: parts/008_.../028_claim_a_theta_mu.typ Step 18
# 式ペア: gamma_2(theta)/gamma_2(-theta) = (1-alpha_1*e^(i*theta))*(1-alpha_2^(-1)*e^(i*theta)) / ((1-alpha_1*e^(-i*theta))*(1-alpha_2^(-1)*e^(-i*theta)))
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# ---------------------------------------------------------
# 式1: gamma_2(theta_mu) / gamma_2(-theta_mu)
# ---------------------------------------------------------
# 式1(typst):
# (gamma_2(theta_(mu))) / (gamma_2(-theta_(mu)))
expr1 = gamma_2(theta_mu) / gamma_2(-theta_mu)

# ---------------------------------------------------------
# 式2: alpha 積の比
# ---------------------------------------------------------
# 式2(typst):
# ((1 - alpha_1 e^(sqrt(-1) theta_(mu)))(1 - alpha_2^(-1) e^(sqrt(-1) theta_(mu))))
# / ((1 - alpha_1 e^(-sqrt(-1) theta_(mu)))(1 - alpha_2^(-1) e^(-sqrt(-1) theta_(mu))))
expr2 = (
    (1 - alpha_1*exp(i*theta_mu)) * (1 - (1/alpha_2)*exp(i*theta_mu))
) / (
    (1 - alpha_1*exp(-i*theta_mu)) * (1 - (1/alpha_2)*exp(-i*theta_mu))
)

# ---------------------------------------------------------
# 検証
# ---------------------------------------------------------
numerical_check(expr1, expr2, label="Step 18: gamma_2 ratio = alpha product ratio")
