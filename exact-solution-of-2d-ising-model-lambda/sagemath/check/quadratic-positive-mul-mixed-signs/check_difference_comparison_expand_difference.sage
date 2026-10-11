# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 正因子による比較
# 式・判定: (a * a - 2 * (u * u)) * (2 * (bp * bp)) = (a * a) * (2 * (bp * bp)) - (2 * (u * u)) * (2 * (bp * bp))
# 根拠: \text{分配則}
assert ((a * a - 2 * (u * u)) * (2 * (bp * bp))) == ((a * a) * (2 * (bp * bp)) - (2 * (u * u)) * (2 * (bp * bp)))
qpm_record('difference_comparison_expand_difference', 1, 'polynomial identity')
