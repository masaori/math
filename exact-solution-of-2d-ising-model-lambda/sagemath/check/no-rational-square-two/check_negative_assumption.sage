# 対象ラベル: claim_no_rational_square_two
# 負の枝：q*q=2 の仮定
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
_nrs_assumption("check_negative_assumption", "具体版・必要十分版の負の枝での hSquare")
