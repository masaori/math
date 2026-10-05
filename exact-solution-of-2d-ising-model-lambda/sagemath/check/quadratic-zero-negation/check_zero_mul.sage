# 対象ラベル: claim_quadratic_zero_mem
# 式ペア: 0 + 0 = 0 + 0 * s （QQbar の零元との積）
from pathlib import Path
load(str(Path(__file__).resolve().with_name('_zero_membership_prelude.sage')))

for s in _qz_roots:
    assert _qz_zero + _qz_zero == _qz_zero + _qz_zero * s
print("RESULT: PASS (零元との積を代入: 2 等式、二根)")
