# 対象ラベル: arctan_zero
# arctan 0 = 0 の証明の鎖 8 行を、隣り合う行の式どうしの等号で確かめる。
#   1 行目: arctan 0 = arcsin(0/√(1+0^2))（def_arctan の x → 0）。Sage の arctan(0) と def_arctan の右辺を記号計算で比べる
#   2〜6 行目: arcsin の引数を 0/√(1+0^2) → 0/√(1+0·0) → 0/√(1+0) → 0/√1 → 0/1 → 0 と一行ずつ。√ は AA の sqrt
#   7 行目: 0 = sin 0（sine_zero）。_shared/polar_trigonometry_exact.sage の cos_sin で角度 0 の sin を作る（AA）
#   8 行目: arcsin(sin 0) = 0（def_sin を 0 ∈ [-π/2, π/2] で）。0 が [-π/2, π/2] に入ることと、記号計算の arcsin(sin 0)
# 帰属: 2〜7 行目は QQ と AA で厳密。1・8 行目は Sage の記号計算（SR）で厳密。浮動小数点は使わない。

load("../../_shared/polar_trigonometry_exact.sage")   # cos_sin（角度 0 での cos・sin を 1 の冪根の実部・虚部で）

eq_count = 0
z = QQ(0)
one = QQ(1)

# 1 行目: def_arctan(x) := arcsin(x/√(1+x^2)) を x → 0 で、Sage の arctan(0) と比べる
assert bool(arctan(SR(0)) == arcsin(SR(0) / sqrt(1 + SR(0)**2))); eq_count += 1
# arcsin の引数の列（2〜6 行目）
args = [
    z / sqrt_aa(one + z**2),       # 1 行目の引数
    z / sqrt_aa(one + z * z),      # 2 行目: square_of_real_number_is_product（r → 0）
    z / sqrt_aa(one + z),          # 3 行目: ℝ で 0·x = 0（x → 0）
    z / sqrt_aa(one),              # 4 行目: a + 0 = a（a → 1）
    z / one,                       # 5 行目: sqrt_of_real_one_is_one
    z,                             # 6 行目: 0/x = 0（x → 1）
]
# 各段で置き換えた部分式が等しいこと
assert z**2 == z * z; eq_count += 1
assert z * z == z; eq_count += 1
assert one + z == one; eq_count += 1
assert sqrt_aa(one) == one; eq_count += 1
assert z / one == z; eq_count += 1
# 隣り合う行の arcsin の引数が等しい
for a, b in zip(args, args[1:]):
    assert a == b; eq_count += 1
# 7 行目: 0 = sin 0（sine_zero）。角度 0 の cos・sin を _shared の cos_sin で作り、その sin
cos0, sin0 = cos_sin(Ang(0))
assert sin0 == z; eq_count += 1
# 8 行目: 0 ∈ [-π/2, π/2] で def_sin の arcsin(sin y) = y、y → 0
assert bool(-pi / 2 <= 0) and bool(0 <= pi / 2)
assert bool(arcsin(sin(SR(0))) == 0); eq_count += 1

# 否定コントロール: 分母を √(1+0^2) から √2 や 1+1 に取り違えても引数は 0 のまま（0 は分子だけで決まる）なので、
# 分子を 0 から取り違えたときに引数が 0 でなくなり、鎖の終わり arctan 0 = 0 と食い違うことを確かめる。
broken = 0
for num in [QQ(1), QQ(-1), QQ(1) / 2]:
    if num / sqrt_aa(one + num**2) != 0:
        broken += 1
# sin 0 を cos 0 = 1 に取り違えると 7 行目が崩れる
if cos0 != z:
    broken += 1
assert broken == 4
print(f"等号 {eq_count} 個を確かめた（arctan 0 の鎖 8 行。arcsin の引数は QQ と AA で厳密、1・8 行目は記号計算）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
