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
# 式・判定: 2 * (((a * bp) * (a * bp) + (a * bp) * (u * cp)) + ((u * cp) * (a * bp) + (u * cp) * (u * cp))) = 2 * (((a * a) * (bp * bp) + (a * u) * (bp * cp)) + ((u * a) * (cp * bp) + (u * u) * (cp * cp)))
# 根拠: \text{上の四因子の並べ替え}
assert (2 * (((a * bp) * (a * bp) + (a * bp) * (u * cp)) + ((u * cp) * (a * bp) + (u * cp) * (u * cp)))) == (2 * (((a * a) * (bp * bp) + (a * u) * (bp * cp)) + ((u * a) * (cp * bp) + (u * u) * (cp * cp))))
qpm_record('second_square_regroup_products', 1, 'polynomial identity')
