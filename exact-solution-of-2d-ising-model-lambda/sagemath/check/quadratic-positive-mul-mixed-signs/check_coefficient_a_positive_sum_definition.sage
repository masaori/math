# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 第一係数の表示
# 式・判定: -(a * cp + 2 * (u * bp)) = -C
# 根拠: C\text{ の定義}
assert (-(a * cp + 2 * (u * bp))) == (-C)
qpm_record('coefficient_a_positive_sum_definition', 1, 'polynomial identity')
