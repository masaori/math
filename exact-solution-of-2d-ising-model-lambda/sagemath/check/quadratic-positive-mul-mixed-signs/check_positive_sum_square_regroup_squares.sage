# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 補助量 C の平方展開
# 式・判定: ((a * cp) * (a * cp) + (a * cp) * (2 * (u * bp))) + ((2 * (u * bp)) * (a * cp) + (2 * (u * bp)) * (2 * (u * bp))) = ((a * a) * (cp * cp) + (a * cp) * (2 * (u * bp))) + ((2 * (u * bp)) * (a * cp) + (2 * 2) * ((u * bp) * (u * bp)))
# 根拠: \text{上の四因子の並べ替え}
assert (((a * cp) * (a * cp) + (a * cp) * (2 * (u * bp))) + ((2 * (u * bp)) * (a * cp) + (2 * (u * bp)) * (2 * (u * bp)))) == (((a * a) * (cp * cp) + (a * cp) * (2 * (u * bp))) + ((2 * (u * bp)) * (a * cp) + (2 * 2) * ((u * bp) * (u * bp))))
qpm_record('positive_sum_square_regroup_squares', 1, 'polynomial identity')
