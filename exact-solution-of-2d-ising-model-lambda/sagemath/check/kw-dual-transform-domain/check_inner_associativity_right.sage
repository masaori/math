# 対象ラベル: claim_kw_dual_transform_domain
# 対象: 証明の分配則の後の計算。各記号は QQbar の元。
# inverse = (1 + xi)^(-1), one = 1。
# 式ペア: (one + ((one + xi) + (-xi))) * inverse = (one + (one + (xi + (-xi)))) * inverse
from pathlib import Path
_check_dir = Path("sagemath/check/kw-dual-transform-domain")
if not _check_dir.is_dir():
    _check_dir = Path(".")
load(str(_check_dir / "_prelude.sage"))

check_calculation_step(
    "内側の加法の結合則を順向きに適用",
    lambda xi, one, inverse: (one + ((one + xi) + (-xi))) * inverse,
    lambda xi, one, inverse: (one + (one + (xi + (-xi)))) * inverse,
)
