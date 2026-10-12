# 対象ラベル: claim_quadratic_trichotomy_at_least_one
# 対象: main-text.ts の二次体の三分律（少なくとも一つ）、負正混合の逆元の第一係数の平方
# 式ペア: aa=(-a)(-a)
# 帰属: a, b は QQ。比較も QQ の順序を使い、浮動小数点を使わない。
from pathlib import Path
import sys

if '_qta_cases' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

_qta_check_pair('negative_positive_negated', lambda a, b: a*a, lambda a, b: (-a)*(-a),
                '=', 'negative_positive_negated_square')
