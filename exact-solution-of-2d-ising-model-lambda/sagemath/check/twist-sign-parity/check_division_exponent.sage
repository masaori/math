# 対象ラベル: claim_twist_sign_from_parity
# 本文の等号: 自然数の商と余り
from pathlib import Path
load(str(Path(__file__).resolve().with_name("_prelude.sage")))

for n, q, r, kappa, sign, kind in _twist_sign_cases:
    assert ZZ(-1)**n == ZZ(-1)**(2*q+r), (n, q, r, kappa, sign, kind)
print("PASS: 自然数の商と余り (%s equalities)" % len(_twist_sign_cases))
