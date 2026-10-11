# 順序付き対へ再添字付け
# 対象ラベル: claim_qbar_polynomial_pfaffian_square_expansion
# 対象: tools_claim_qbar_polynomial_pfaffian_square_expansion の「順序付き対へ再添字付け」の等号
# 帰属: Q(zeta_8)[x]。左辺と右辺は下の二つの lambda で同じ括弧のまま記す。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_total("ordered_pairs",
    lambda pf, data: double_sum(data, lambda c,b,d,e: (c*d)*(b*e)),
    lambda pf, data: sum(((left[0]*right[0])*(left[1]*right[1]) for left, right in product(data, repeat=2)), R(0)))
