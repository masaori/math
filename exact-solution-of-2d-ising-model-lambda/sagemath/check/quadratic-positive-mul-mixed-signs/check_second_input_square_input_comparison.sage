# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 第二入力の平方比較
# 式・判定: ap * ap < (2 * bp) * bp
# 根拠: \blkref{def_quadratic_positive_cone}
checked = 0
for a, u, cp, bp, b, ap, A, B, C, D in qpm_cases:
    assert (ap * ap) < ((2 * bp) * bp)
    checked += 1
assert checked == 67308
qpm_record('second_input_square_input_comparison', checked, 'rational comparison')
