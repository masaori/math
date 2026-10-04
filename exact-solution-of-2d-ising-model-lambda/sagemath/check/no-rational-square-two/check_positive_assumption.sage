# 対象ラベル: claim_no_rational_square_two
# 正の枝：q*q=2 の仮定
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
_nrs_assumption("check_positive_assumption", "noRationalSquareTwo の正の枝、および導出版の hSquare")
