# 対象ラベル: claim_no_rational_square_two
# 指数：r*r=2 による w2 の引数の置換
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
_nrs_assumption("check_square_assumption", "具体版・導出版の hDouble 内の w(2)=w(r*r)")
