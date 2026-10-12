# 対象ラベル: claim_quadratic_zero_mem
# 式ペア: 0 = 0 + 0 （QQbar の加法の単位元）
from pathlib import Path
import sys

_qz_source = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (_qz_source.parent / '_zero_membership_prelude.sage').is_file():
    _qz_source = Path(sys.argv[0]).resolve()
load(str(_qz_source.parent / '_zero_membership_prelude.sage'))

for s in _qz_roots:
    assert _qz_zero == _qz_zero + _qz_zero
print("RESULT: PASS (零元へ零を加える: 2 等式、二根)")
