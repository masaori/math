# 対象ラベル: claim_quadratic_zero_mem
# 所属の証人: (0_Q, 0_Q) in QQ x QQ、0 = iota(0_Q) + iota(0_Q) * s
from pathlib import Path
load(str(Path(__file__).resolve().with_name('_zero_membership_prelude.sage')))

for s in _qz_roots:
    a, b = QQ(0), QQ(0)
    assert a.parent() is QQ and b.parent() is QQ
    assert _qz_zero == _qz_iota(a) + _qz_iota(b) * s
print("RESULT: PASS (零元の所属の証人: 2 例、二根)")
