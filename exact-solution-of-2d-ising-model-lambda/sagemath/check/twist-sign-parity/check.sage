# 対象ラベル: claim_twist_sign_from_parity
from pathlib import Path
check_dir = Path(__file__).resolve().parent
load(str(check_dir / "_prelude.sage"))
assert sum(case[-1] == "edge" for case in _twist_sign_cases) == 880
assert sum(case[-1] == "scalar" for case in _twist_sign_cases) == 258
for n, q, r, kappa, sign, kind in _twist_sign_cases:
    assert n in NN and q in NN and r in NN and kappa in NN and sign in ZZ
    assert r in (0, 1) and kappa in (0, 1)
check_files = ['check_sign_definition.sage', 'check_division_exponent.sage', 'check_power_add.sage', 'check_power_mul.sage', 'check_negative_one_square.sage', 'check_one_power.sage', 'check_one_mul.sage', 'check_parity_definition.sage']
for check_file in check_files:
    __file__ = str(check_dir / check_file)
    load(__file__)
print("RESULT: PASS (880 edge cases, 258 scalar cases, 8 lines, 9104 equalities)")
