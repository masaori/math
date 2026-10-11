# 対象ラベル: claim_kw_dual_transform_domain
# 帰属: QQbar の厳密計算。one = 1、inverse = (1 + xi)^(-1)。
# 式ペア: one = (one + xi) * inverse
from pathlib import Path
_check_dir = Path("sagemath/check/kw-dual-transform-domain")
if not _check_dir.is_dir():
    _check_dir = Path(".")
load(str(_check_dir / "_prelude.sage"))

check_calculation_step(
    "背理法で逆元の等式を逆向きに適用",
    lambda xi, one, inverse: one,
    lambda xi, one, inverse: (one + xi) * inverse,
)

