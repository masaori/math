# ---------------------------------------------------------
# SageMath: T_(V')(psi_mu^dagger) = exp(gamma(theta_mu)) psi_mu^dagger
# Target: parts/008_T_V1_hatZとhatZ_hatYの関係/037_claim_T_Vprimeのpsiへの作用.typ
# ---------------------------------------------------------
import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, 'common.sage'))

print("\n--- Numerical Verification: T_(V')(psi_mu^dagger) = exp(gamma(theta_mu)) psi_mu^dagger ---")
run_TVprime_action_check('psi_dagger')
