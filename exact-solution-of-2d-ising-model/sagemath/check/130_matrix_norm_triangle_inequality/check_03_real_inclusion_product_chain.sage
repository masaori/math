# 対象ラベル: matrix_norm_triangle_inequality（Step 1 の ι_{ℝ→ℂ} が積を保つ鎖）
# 鎖の各行を、行に書かれた式どおりに別々に組み、隣り合う項が等しいことを確かめる。
#   ι(x)·ι(y) = (x,0)·(y,0) = (xy − 0·0, x·0 + 0·y) = (xy − 0·0, 0 + 0·y) = (xy − 0, 0 + 0)
#             = (xy, 0 + 0) = (xy, 0) = ι(xy)
# 3〜6 行目は real_times_zero_is_zero（x → x）・real_zero_times_is_zero を 2 箇所へ（x → 0, y）・
# real_minus_zero_is_self（a → xy）・ℝ で 0 + 0 = 0。
# 複素数は definition_of_cc のとおり実数の組で持ち、積はその式で組む。
# 帰属: QQ 上の多項式環 QQ[x, y]（x, y は不定元）。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ。
P = PolynomialRing(QQ, "x,y")
x, y = P.gens()
zero = P(0)


def cc_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])  # definition_of_cc の積


def iota(r):
    return (r, zero)                                                # inclusion_rr_to_cc


chain = [
    cc_mul(iota(x), iota(y)),                   # ι(x)·ι(y)
    cc_mul((x, zero), (y, zero)),               # (x,0)·(y,0)
    (x * y - zero * zero, x * zero + zero * y), # 複素数の積の定め方
    (x * y - zero * zero, zero + zero * y),     # real_times_zero_is_zero (x → x)
    (x * y - zero, zero + zero),                # real_zero_times_is_zero を 2 箇所へ (x → 0, y)
    (x * y, zero + zero),                       # real_minus_zero_is_self (a → xy)
    (x * y, zero),                              # ℝ で 0 + 0 = 0
    iota(x * y),                                # ι(xy)
]
for t in range(len(chain) - 1):
    assert chain[t] == chain[t + 1], t
print(f"checked the chain of {len(chain)} terms with indeterminates x, y")
# 対照: 第 2 成分の 0 を 1 に替えると積は保たれない
bad = cc_mul((x, P(1)), (y, zero))
assert bad != iota(x * y)
print("negative control: (x,1)·(y,0) != ι(xy)")
print("RESULT: PASS")
