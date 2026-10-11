# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 第二係数の平方の二倍の展開
# 式・判定: 2 * (B * B) = 2 * ((a * bp + u * cp) * (a * bp + u * cp))
# 根拠: \text{第二係数の表示}
assert (2 * (B * B)) == (2 * ((a * bp + u * cp) * (a * bp + u * cp)))
qpm_record('second_square_substitute_coefficient', 1, 'polynomial identity')
