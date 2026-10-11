# 対象ラベル: claim_no_rational_square_two
# 正の枝：q*q=2 の仮定
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
_nrs_assumption("check_positive_assumption", "具体版・必要十分版の正の枝での hSquare")
