# 対象ラベル: claim_twist_sign_from_parity
# 本文の等号: 単位元との積
from pathlib import Path
load(str(Path(__file__).resolve().with_name("_prelude.sage")))

for n, q, r, kappa, sign, kind in _twist_sign_cases:
    assert ZZ(1) * ZZ(-1)**r == ZZ(-1)**r, (n, q, r, kappa, sign, kind)
print("PASS: 単位元との積 (%s equalities)" % len(_twist_sign_cases))
