"""固定された語長三の切断旗係数を位置ビットの閉式へ直す。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

一辺二・三の有限合同系が強制する語長三の切断旗係数のうち、
語位置の旗と端点の旗が異なる軸に属する 16 係数を、軸・境界側・
端点番号・端点側の四ビットで表す。有限集合と F_2 の厳密演算だけを使う。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-forced-coefficient-core/check.sage")

from itertools import permutations, product


def parse_flag(name):
    if name.startswith("row"):
        return 0, int(name == "rowlast")
    if name.startswith("col"):
        return 1, int(name == "collast")
    raise ValueError("未知の切断旗: %s" % name)


def parse_cross_axis_term(name):
    step_name, endpoint_name = name.split("*")
    step_flag = step_name.removeprefix("step1_wrap_")
    endpoint, endpoint_flag = endpoint_name.split("_wrap_")
    step_axis, step_side = parse_flag(step_flag)
    endpoint_axis, endpoint_side = parse_flag(endpoint_flag)
    if step_axis == endpoint_axis:
        return None
    return (step_axis, step_side, int(endpoint == "end1"), endpoint_side)


forced_values = {}
for value, named_terms in ((1, forced_nonzero_named), (0, forced_zero_named)):
    for length, name in named_terms:
        if length != 3:
            continue
        position = parse_cross_axis_term(name)
        if position is not None:
            assert position not in forced_values
            forced_values[position] = GF(2)(value)

all_positions = tuple(product((0, 1), repeat=4))
assert set(forced_values) == set(all_positions)
assert sum(forced_values.values()) == 8

# 四ビット上の関数には一意な代数標準形がある。Möbius 反転で係数を得る。
anf = [forced_values[tuple((mask >> bit) & 1 for bit in range(4))]
       for mask in range(16)]
for bit in range(4):
    for mask in range(16):
        if mask & (1 << bit):
            previous_mask = int(mask).__xor__(int(1 << bit))
            anf[mask] += anf[previous_mask]

active_masks = tuple(mask for mask, coefficient in enumerate(anf) if coefficient)
assert active_masks == (0, 2, 3, 4, 7, 9, 14)


def position_coefficient(axis, step_side, endpoint, endpoint_side):
    """a=axis, s=step_side, e=endpoint, t=endpoint_side とした閉式。"""
    a, s, e, t = map(GF(2), (axis, step_side, endpoint, endpoint_side))
    return 1 + s + a * s + e + a * s * e + a * t + s * e * t


for position in all_positions:
    assert position_coefficient(*position) == forced_values[position]

# 座標四ビットの置換と反転だけからなる 384 個の再表示では、固定係数表を
# 保つものは恒等写像だけである。正準二項の選択が位置対称性を破っており、
# 有限データから非自明な位置対称性を主張できないことを固定する。
symmetries = []
for permutation in permutations(range(4)):
    for flips in product((0, 1), repeat=4):
        preserves = True
        for position in all_positions:
            image = tuple((position[permutation[index]] + flips[index]) % 2
                          for index in range(4))
            if forced_values[image] != forced_values[position]:
                preserves = False
                break
        if preserves:
            symmetries.append((permutation, flips))
assert symmetries == [((0, 1, 2, 3), (0, 0, 0, 0))]

# 一般語長への候補は、端の語位置を除く各位置へ同じ四ビット閉式を置く。
# 語長三では内部位置が step1 だけなので、上の強制八項へ正確に戻る。
def candidate_terms(length):
    assert length >= 1
    terms = []
    for step in range(1, length - 1):
        for axis, step_side, endpoint, endpoint_side in all_positions:
            if position_coefficient(axis, step_side, endpoint, endpoint_side) == 0:
                continue
            step_flag = (("col" if axis else "row") +
                         ("last" if step_side else "0"))
            endpoint_flag = (("row" if axis else "col") +
                             ("last" if endpoint_side else "0"))
            terms.append("step%d_wrap_%s*end%d_wrap_%s" %
                         (step, step_flag, endpoint, endpoint_flag))
    return tuple(terms)


expected_length_three = tuple(
    name for length, name in forced_nonzero_named
    if length == 3 and parse_cross_axis_term(name) is not None)
assert set(candidate_terms(3)) == set(expected_length_three)
assert tuple(len(candidate_terms(length)) for length in range(1, 7)) == (0, 0, 8, 16, 24, 32)

print("POSITION FORMULA: 1 + s + a*s + e + a*s*e + a*t + s*e*t")
print("SYMMETRIES: identity only among coordinate permutations and bit flips")
print("GENERAL-WORD CANDIDATE: repeat the 8-term rule at each internal word position")
print("RESULT: PASS")
