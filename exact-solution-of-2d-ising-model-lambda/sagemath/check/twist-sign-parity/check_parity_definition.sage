# 対象ラベル: claim_twist_sign_from_parity
# 本文の等号: ねじれ偶奇の定義
from pathlib import Path
load(str(Path(__file__).resolve().with_name("_prelude.sage")))

for n, q, r, kappa, sign, kind in _twist_sign_cases:
    assert ZZ(-1)**r == ZZ(-1)**kappa, (n, q, r, kappa, sign, kind)
print("PASS: ねじれ偶奇の定義 (%s equalities)" % len(_twist_sign_cases))
