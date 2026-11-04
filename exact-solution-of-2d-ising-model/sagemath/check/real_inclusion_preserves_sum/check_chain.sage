# 対象ラベル: real_inclusion_preserves_sum（a_C + b_C = (a + b)_C）
# 証明の 4 行:
#   a_C + b_C = (a, 0) + (b, 0)        (inclusion_rr_to_cc を 2 か所へ同時適用)
#             = (a + b, 0 + 0)          (definition_of_cc の和)
#             = (a + b, 0)              (ℝ で 0 + 0 = 0)
#             = (a + b)_C               (inclusion_rr_to_cc)
# 帰属: a, b は QQ 上の多項式環の不定元（厳密計算）。不定元で成り立つ多項式の等号は、実数を代入しても成り立つ。浮動小数点はない。
load("../../_shared/complex_as_real_pairs.sage")

P = PolynomialRing(QQ, ["a", "b"])
a, b = P.gens()
lines = [
    cc_add(iota(a, P), iota(b, P)),
    cc_add((a, P(0)), (b, P(0))),
    (a + b, P(0) + P(0)),
    (a + b, P(0)),
    iota(a + b, P),
]
count = 0
for t in range(len(lines) - 1):
    assert lines[t] == lines[t + 1], t
    count += 1
# 否定コントロール: 虚部を 0 でない値にすると最後の行と一致しない
assert cc_add(iota(a, P), (b, P(1))) != iota(a + b, P)
# 比べる側: Sage の QQ(i) へ送った和
KG = QuadraticField(-1, 'i')
PK = PolynomialRing(KG, P.variable_names())
assert PK(lines[0][0]) + KG.gen() * PK(lines[0][1]) == PK(a) + PK(b)
print(f"checked {count} lines")
print("RESULT: PASS")
