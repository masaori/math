# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 平方差の正値性
# 式・判定: 0 < a * a - 2 * (u * u)
# 根拠: 2\cdot(u\cdot u)<a\cdot a\text{ の移項}
checked = 0
for a, u, cp, bp, b, ap, A, B, C, D in qpm_cases:
    assert (0) < (a * a - 2 * (u * u))
    checked += 1
assert checked == 67308
qpm_record('difference_positive', checked, 'rational comparison')
