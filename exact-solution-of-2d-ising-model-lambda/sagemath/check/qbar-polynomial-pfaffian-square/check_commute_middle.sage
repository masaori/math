# 中央の単項積と符号係数の交換
# 対象ラベル: claim_qbar_polynomial_pfaffian_square_expansion
# 対象: tools_claim_qbar_polynomial_pfaffian_square_expansion の「中央の単項積と符号係数の交換」の等号
# 帰属: Q(zeta_8)[x]。左辺と右辺は下の二つの lambda で同じ括弧のまま記す。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_term("commute_middle",
    lambda c,b,d,e: (c*(b*d))*e,
    lambda c,b,d,e: (c*(d*b))*e)
