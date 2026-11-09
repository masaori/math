# 対象ラベル: arcsin_of_one_is_half_pi
# arcsin(1) = π/2 の証明の鎖を一行ずつ確かめる。
#   準備: f(y) := l(AP)（def_arcsin の第一の式）、f は狭義単調増加で f([0,1]) = [0,π/2]（齋藤微積分 命題 2.1.5）。
#         f(1) ∈ [0,π/2]、0 ≤ π/2、f(y_1) = π/2 となる y_1 ∈ [0,1]。
#   準備の鎖 2 行: π/2 = f(y_1)・f(y_1) ≤ f(1)（y_1 ≤ 1 と f の単調増加）
#   本体の鎖 2 行: arcsin(1) = f(1)（def_arcsin の第一の式の y → 1）・f(1) = π/2（反対称律）
# 帰属: 等号は Sage の記号計算（SR）で厳密。不等号は RealBallField(256) のボールの比較で確かめる
#       （π と弧の長さが実数なので ℝ へ脱出する。ボールの比較は真と判定できたときだけ真を返す）。
# 本文の f（弧の長さ）が [0,1] 上で標準の arcsin に等しいことは arcsin_is_bijection の検算が扱う。
# ここでは f を標準の arcsin で置き、外部から持ち込む二点（狭義単調増加・像が [0,π/2]）を標本点で確かめ、
# そのうえで証明の各行を確かめる。

R = RealBallField(256)
pi_b = R.pi()
eq_count = 0
ineq_count = 0

def f_b(y):
    return R(y).arcsin()

# 外部から持ち込む二点の標本検査: 狭義単調増加、像が [0, π/2] に入り、端点 0, π/2 を取る
samples = [QQ(k) / 64 for k in range(65)]
for a, b in zip(samples, samples[1:]):
    assert f_b(a) < f_b(b)
    ineq_count += 1
for y in samples[1:-1]:
    assert R(0) < f_b(y) and f_b(y) < pi_b / 2
    ineq_count += 2
assert bool(arcsin(SR(0)) == 0)
eq_count += 1

# 準備: f(1) ∈ [0, π/2]（右端は SR で等号として確かめる）
assert R(0) < f_b(1); ineq_count += 1
assert bool(arcsin(SR(1)) <= pi / 2); ineq_count += 1
# 準備: 0 ≤ π/2
assert R(0) < pi_b / 2
ineq_count += 1
# 準備: f(y_1) = π/2 となる y_1 ∈ [0,1]（y_1 = 1）
y1 = QQ(1)
assert 0 <= y1 <= 1
assert bool(arcsin(SR(y1)) == pi / 2)
eq_count += 1

# 準備の鎖
# 1 行目: π/2 = f(y_1)
assert bool(pi / 2 == arcsin(SR(y1))); eq_count += 1
# 2 行目: f(y_1) ≤ f(1)（y_1 ≤ 1 と単調増加。y_1 = 1 なので等号）
assert y1 <= 1
assert bool(arcsin(SR(y1)) <= arcsin(SR(1))); ineq_count += 1

# 本体の鎖
# 1 行目: arcsin(1) = f(1)（def_arcsin の第一の式。P = (√(1 − 1^2), 1) = (0, 1)）
assert sqrt(QQ(1) - QQ(1)^2) == 0; eq_count += 1
assert bool(arcsin(SR(1)) == arcsin(SR(1))); eq_count += 1
# 2 行目: f(1) = π/2（f(1) ≤ π/2 と π/2 ≤ f(1) の反対称律）
assert bool(arcsin(SR(1)) == pi / 2); eq_count += 1

# 否定コントロール
broken = 0
# 像を [0, π] と取り違えると、f(1) = π は成り立たない（本体の 2 行目の取り違え）
if not bool(arcsin(SR(1)) == pi):
    broken += 1
# 本体の 1 行目で def_arcsin の第一の式の y を 1 でなく 0 に取り違えると、f(0) = π/2 は成り立たない
if not bool(arcsin(SR(0)) == pi / 2):
    broken += 1
# 単調減少と取り違えると準備の鎖の 2 行目の向きが逆になる。f(1/2) < f(1) を正の向きで確かめてから数える
assert f_b(QQ(1) / 2) < f_b(1)
if not (f_b(1) < f_b(QQ(1) / 2)):
    broken += 1
assert broken == 3

print(f"等号 {eq_count} 個・不等号 {ineq_count} 件を確かめた（等号は SR で厳密、不等号は RealBallField(256)）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
