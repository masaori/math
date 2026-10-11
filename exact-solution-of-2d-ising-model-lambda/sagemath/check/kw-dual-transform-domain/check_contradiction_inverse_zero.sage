# 対象ラベル: claim_kw_dual_transform_domain
# 式ペア: (1 + xi) * r = (1 + xi) * 0（仮定 r = 0 による置換）。
# 帰属: QQbar[r]。矛盾する仮定を実際の逆元の値に課さず、代入写像で検査する。
from pathlib import Path
_check_dir = Path("sagemath/check/kw-dual-transform-domain")
if not _check_dir.is_dir():
    _check_dir = Path(".")
load(str(_check_dir / "_prelude.sage"))

polynomials = PolynomialRing(QQbar, "r")
r = polynomials.gen()
checked = 0
for xi in test_points:
    left = (QQbar(1) + xi) * r
    right = polynomials((QQbar(1) + xi) * QQbar(0))
    assert left != right
    assert (left - right)(QQbar(0)) == 0
    checked += 1
assert checked == 16
print(f"背理法の仮定 r = 0 による置換: {checked} 点; RESULT: PASS")
