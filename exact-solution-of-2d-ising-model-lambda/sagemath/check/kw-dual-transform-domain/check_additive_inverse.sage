# 対象ラベル: claim_kw_dual_transform_domain
# 対象: 証明の分配則の後の計算。各記号は QQbar の元。
# inverse = (1 + xi)^(-1), one = 1。
# 式ペア: (one + (one + (xi + (-xi)))) * inverse = (one + (one + QQbar(0))) * inverse
from pathlib import Path
_check_dir = Path("sagemath/check/kw-dual-transform-domain")
if not _check_dir.is_dir():
    _check_dir = Path(".")
load(str(_check_dir / "_prelude.sage"))

check_calculation_step(
    "加法の逆元の取消",
    lambda xi, one, inverse: (one + (one + (xi + (-xi)))) * inverse,
    lambda xi, one, inverse: (one + (one + QQbar(0))) * inverse,
)
