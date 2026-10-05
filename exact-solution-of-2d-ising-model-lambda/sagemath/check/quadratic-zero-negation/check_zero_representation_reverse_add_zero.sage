# 対象ラベル: claim_quadratic_zero_representation
# 式ペア: 0+0=0
# 帰属: 係数は QQ、値は QQbar の厳密計算。
from pathlib import Path
if '_qzr_cases' not in globals():
    load(str(Path(__file__).resolve().parent / '_representation_prelude.sage'))
_qzr_check('reverse', 5, 'reverse_add_zero')
