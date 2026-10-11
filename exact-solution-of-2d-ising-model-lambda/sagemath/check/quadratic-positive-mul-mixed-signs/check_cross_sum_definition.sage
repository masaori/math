# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 第二係数の正値性
# 式・判定: a * bp + u * cp = B
# 根拠: \text{第二係数の表示}
assert (a * bp + u * cp) == (B)
qpm_record('cross_sum_definition', 1, 'polynomial identity')
