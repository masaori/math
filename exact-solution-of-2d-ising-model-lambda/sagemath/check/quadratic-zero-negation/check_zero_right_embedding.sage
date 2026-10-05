# 対象ラベル: claim_quadratic_zero_mem
# 式ペア: iota(0_Q) + 0 * s = iota(0_Q) + iota(0_Q) * s （包含が零を保つことを右だけへ適用）
from pathlib import Path
load(str(Path(__file__).resolve().with_name('_zero_membership_prelude.sage')))

for s in _qz_roots:
    assert (_qz_iota(_qz_rational_zero) + _qz_zero * s ==
            _qz_iota(_qz_rational_zero) + _qz_iota(_qz_rational_zero) * s)
print("RESULT: PASS (右の係数を包含で移す: 2 等式、二根)")
