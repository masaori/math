# 対象ラベル: claim_quadratic_zero_mem
# 式ペア: iota(0_Q) + 0 * s = iota(0_Q) + iota(0_Q) * s （包含が零を保つことを右だけへ適用）
from pathlib import Path
import sys

_qz_source = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (_qz_source.parent / '_zero_membership_prelude.sage').is_file():
    _qz_source = Path(sys.argv[0]).resolve()
load(str(_qz_source.parent / '_zero_membership_prelude.sage'))

for s in _qz_roots:
    assert (_qz_iota(_qz_rational_zero) + _qz_zero * s ==
            _qz_iota(_qz_rational_zero) + _qz_iota(_qz_rational_zero) * s)
print("RESULT: PASS (右の係数を包含で移す: 2 等式、二根)")
