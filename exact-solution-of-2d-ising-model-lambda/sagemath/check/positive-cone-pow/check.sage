# 対象ラベル: claim_quadratic_positive_cone_pow_closed
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。

two = QQbar(2)
R = PolynomialRing(QQbar, "t")
t = R.gen()
s_candidates = (t**2 - two).roots(multiplicities=False)


def representation_product(left, right):
    a, b = left
    c, d = right
    return (a * c + 2 * b * d, a * d + b * c)


def positive(a, b):
    return (
        (a >= 0 and b >= 0 and (a, b) != (QQ(0), QQ(0)))
        or (a > 0 and b < 0 and 2 * b * b < a * a)
        or (a < 0 and b > 0 and a * a < 2 * b * b)
    )


# 三つの条件をそれぞれ満たす正錐の元を含む。
samples = [
    (QQ(1), QQ(0)),
    (QQ(2), QQ(1)),
    (QQ(3), QQ(-1)),
    (QQ(-1), QQ(1)),
]

checked = 0
for s in s_candidates:
    assert s * s == two
    for pair in samples:
        assert positive(*pair)
        xi = QQbar(pair[0]) + QQbar(pair[1]) * s
        rep = (QQ(1), QQ(0))

        # 出発点 xi^0 = 1 と、その表示 (1,0) の正値性。
        assert xi**0 == QQbar(1)
        assert positive(*rep)

        for m in range(0, 9):
            assert QQbar(rep[0]) + QQbar(rep[1]) * s == xi**m
            assert positive(*rep)

            # 一歩: rep(xi^(m+1)) は積の表示で得られ、値は通常の冪と一致する。
            next_rep = representation_product(rep, pair)
            assert QQbar(next_rep[0]) + QQbar(next_rep[1]) * s == xi ** (m + 1)
            assert positive(*next_rep)
            rep = next_rep
            checked += 1

assert checked == len(s_candidates) * len(samples) * 9
print(f"OK: claim_quadratic_positive_cone_pow_closed ({checked} 帰納法ステップ)")

from pathlib import Path
import sys
_pcp_source = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (_pcp_source.parent / '_prelude.sage').is_file():
    _pcp_source = Path(sys.argv[0]).resolve()
_pcp_directory = _pcp_source.parent
load(str(_pcp_directory / '_prelude.sage'))
_pcp_files = [
    'check_input_field.sage',
    'check_rational_one_positive.sage',
    'check_embedded_one_field.sage',
    'check_embedded_one_cone.sage',
    'check_zero_power.sage',
    'check_embedded_one_identity.sage',
    'check_zero_field_transport.sage',
    'check_zero_cone_transport.sage',
    'check_product_field.sage',
    'check_product_cone.sage',
    'check_successor_power.sage',
    'check_successor_field_transport.sage',
    'check_successor_cone_transport.sage',
    'check_coe_bridge.sage',
]
assert {p.name for p in _pcp_directory.glob('check_*.sage')} == set(_pcp_files)
for _pcp_filename in _pcp_files:
    __file__ = str(_pcp_directory / _pcp_filename)
    load(__file__)
assert len(_pcp_results) == 14
assert sum(_pcp_results.values()) == 1008
print('PASS: positive-cone-pow line checks (14 files, 1008 exact checks)')
