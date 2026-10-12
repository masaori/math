# 対象ラベル: claim_quadratic_zero_representation
# 式ペア: 0+\iota(0_Q)s=0+0s
# 帰属: 係数は QQ、値は QQbar の厳密計算。
from pathlib import Path
import sys

if '_qzr_cases' not in globals():
    _qzr_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_qzr_source.parent / '_representation_prelude.sage').is_file():
        _qzr_source = Path(sys.argv[0]).resolve()
    load(str(_qzr_source.parent / '_representation_prelude.sage'))
_qzr_check('reverse', 3, 'reverse_right_embedding')
