# 対象ラベル: polar_zero_class_criterion
# 主張 [(r,θ)] = [(0,0)] ⟺ r = 0
# 標本と、その同値な別の代表元の全てで、同値の判定（定義 polar_equivalence_class の式）と r = 0 が一致することを確かめる。
# 証明の (⇐)・(⇒) の各行は、定義の二つの選言を読み替えるだけなので、検算として独立に確かめる計算を含まない。
load("../../_shared/polar_representation.sage")

reps = SAMPLE + [x for y in SAMPLE for x in other_reps(y)]
for p in reps:
    assert polar_equiv(p, ZERO) == (p[0] == 0)
# 対照: 半径が正なら、角度が 0 でも [(0,0)] でない
assert not polar_equiv((AA(1)/10^9, Ang(0)), ZERO)
print(f"criterion on {len(reps)} representatives")
print("RESULT: PASS")
