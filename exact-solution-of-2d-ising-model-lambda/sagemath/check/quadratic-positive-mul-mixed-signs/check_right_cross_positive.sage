# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 第二係数を正にする正因子
# 式・判定: 0 < u * cp
# 根拠: 0<u,\ 0<c'
checked = 0
for a, u, cp, bp, b, ap, A, B, C, D in qpm_cases:
    assert (0) < (u * cp)
    checked += 1
assert checked == 67308
qpm_record('right_cross_positive', checked, 'rational comparison')
