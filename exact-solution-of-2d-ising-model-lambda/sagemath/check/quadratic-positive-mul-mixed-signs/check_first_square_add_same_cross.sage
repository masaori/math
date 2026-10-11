# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 二つの平方の比較
# 式・判定: (a * a) * (cp * cp) + (2 * (u * u)) * (2 * (bp * bp)) + 4 * ((a * cp) * (u * bp)) < (a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp) + 4 * ((a * cp) * (u * bp))
# 根拠: \text{移項した比較の両辺へ同じ項を加える}
checked = 0
for a, u, cp, bp, b, ap, A, B, C, D in qpm_cases:
    assert ((a * a) * (cp * cp) + (2 * (u * u)) * (2 * (bp * bp)) + 4 * ((a * cp) * (u * bp))) < ((a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp) + 4 * ((a * cp) * (u * bp)))
    checked += 1
assert checked == 67308
qpm_record('first_square_add_same_cross', checked, 'rational comparison')
