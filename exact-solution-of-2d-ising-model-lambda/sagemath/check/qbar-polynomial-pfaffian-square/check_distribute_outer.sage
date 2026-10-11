# 外側の和への分配
# 対象ラベル: claim_qbar_polynomial_pfaffian_square_expansion
# 対象: tools_claim_qbar_polynomial_pfaffian_square_expansion の「外側の和への分配」の等号
# 帰属: Q(zeta_8)[x]。左辺と右辺は下の二つの lambda で同じ括弧のまま記す。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_total("distribute_outer",
    lambda pf, data: sum((c*b for c, b in data), R(0))*sum((d*e for d, e in data), R(0)),
    lambda pf, data: sum(((c*b)*sum((d*e for d, e in data), R(0)) for c, b in data), R(0)))
