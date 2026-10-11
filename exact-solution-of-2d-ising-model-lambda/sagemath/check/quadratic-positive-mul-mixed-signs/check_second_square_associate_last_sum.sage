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
# 式・判定: ((a * a) * (2 * (bp * bp)) + 4 * ((a * cp) * (u * bp))) + (2 * (u * u)) * (cp * cp) = (a * a) * (2 * (bp * bp)) + (4 * ((a * cp) * (u * bp)) + (2 * (u * u)) * (cp * cp))
# 根拠: \text{和の結合則}
assert (((a * a) * (2 * (bp * bp)) + 4 * ((a * cp) * (u * bp))) + (2 * (u * u)) * (cp * cp)) == ((a * a) * (2 * (bp * bp)) + (4 * ((a * cp) * (u * bp)) + (2 * (u * u)) * (cp * cp)))
qpm_record('second_square_associate_last_sum', 1, 'polynomial identity')
