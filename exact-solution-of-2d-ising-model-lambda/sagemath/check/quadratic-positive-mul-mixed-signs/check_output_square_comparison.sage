# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 正錐の定義の括弧との接続
# 式・判定: A * A < 2 * (B * B)
# 根拠: \text{上で示した平方の比較}
checked = 0
for a, u, cp, bp, b, ap, A, B, C, D in qpm_cases:
    assert (A * A) < (2 * (B * B))
    checked += 1
assert checked == 67308
qpm_record('output_square_comparison', checked, 'rational comparison')
