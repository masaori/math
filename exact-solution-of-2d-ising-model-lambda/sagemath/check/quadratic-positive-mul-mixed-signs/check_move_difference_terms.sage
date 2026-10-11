# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 比較の移項
# 式・判定: (a * a) * (cp * cp) + (2 * (u * u)) * (2 * (bp * bp)) < (a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp)
# 根拠: \text{上の比較の移項}
checked = 0
for a, u, cp, bp, b, ap, A, B, C, D in qpm_cases:
    assert ((a * a) * (cp * cp) + (2 * (u * u)) * (2 * (bp * bp))) < ((a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp))
    checked += 1
assert checked == 67308
qpm_record('move_difference_terms', checked, 'rational comparison')
