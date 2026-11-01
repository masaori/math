# 対象ラベル: arcsin_is_bijection
# 証明の「準備」「値域」「全単射（存在）」の段落を具体の値で確かめる。
# R への脱出: π と弧の長さは実数なので RB で扱い、比べるのは区間の端点（厳密な上界・下界）である。
# - 準備: f(0) = 0（y = 0 では内接・外接の折れ線が両方 0 で、挟み込みが 0 に潰れる）。
#   f(1) を挟む区間が π/2 を含む（f([0,1]) = [0,π/2] の上端に当たる）。
# - 値域: 0 <= y < 1 で区間が [0, π/2) に入り、-1 < y' < 0 で (-π/2, 0) に入る（証明の -f(-y') < -f(0) = 0）。
#   y = ±1 は区間が ±π/2 を含むことまでしか言えない（区間演算では等号を決められない）。
# - 全射の証人: θ_k := kπ/24（k = -12..12）について y_k := sin θ_k を AA で厳密に作り
#   （exp(iπ/24) は 1 の原始 48 乗根なので y_k は代数的数）、y_k ∈ [-1,1] で、arcsin(y_k) を挟む区間が θ_k を含む。
#   一意性は狭義単調増加から従い、check_strict_monotonicity.sage が担う。
load("_prelude.sage")

half_pi = RB.pi() / 2

assert arcsin_enclosure(AA(0)) == (0, 0)
lo1, hi1 = arcsin_enclosure(AA(1))
assert lo1 <= half_pi.lower() and half_pi.upper() <= hi1
lom1, him1 = arcsin_enclosure(AA(-1))
assert lom1 <= -half_pi.upper() and -half_pi.lower() <= him1

for y in Y_ALL:
    lo, hi = arcsin_enclosure(y)
    if 0 <= y < 1:
        assert lo >= 0 and hi < half_pi.lower()
    elif -1 < y < 0:
        assert hi < 0 and lo > -half_pi.lower()

zeta = QQbar.zeta(48)
witnesses = 0
for k in range(-12, 13):
    yk = AA((zeta^k).imag())
    assert -1 <= yk <= 1
    theta = RB.pi() * k / 24
    lo, hi = arcsin_enclosure(yk)
    assert lo <= theta.lower() and theta.upper() <= hi, k
    witnesses += 1

print(f"checked f(0), f(1), the range for {len(Y_ALL)} values and {witnesses} surjectivity witnesses")
print("RESULT: PASS")
