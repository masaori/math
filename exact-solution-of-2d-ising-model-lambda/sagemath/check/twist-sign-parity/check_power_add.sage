# 対象ラベル: claim_twist_sign_from_parity
# 本文の等号: 冪の加法則
from pathlib import Path
load(str(Path(__file__).resolve().with_name("_prelude.sage")))

for n, q, r, kappa, sign, kind in _twist_sign_cases:
    assert ZZ(-1)**(2*q+r) == ZZ(-1)**(2*q) * ZZ(-1)**r, (n, q, r, kappa, sign, kind)
print("PASS: 冪の加法則 (%s equalities)" % len(_twist_sign_cases))
