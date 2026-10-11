# 対象ラベル: claim_kw_dual_transform_domain
# 帰属: QQbar の厳密計算。one = 1、inverse = (1 + xi)^(-1)。
# 式ペア: one + kw(xi) = one + (one - xi) * inverse
from pathlib import Path
_check_dir = Path("sagemath/check/kw-dual-transform-domain")
if not _check_dir.is_dir():
    _check_dir = Path(".")
load(str(_check_dir / "_prelude.sage"))

check_calculation_step(
    "双対変換の定義",
    lambda xi, one, inverse: one + kw(xi),
    lambda xi, one, inverse: one + (one - xi) * inverse,
)

