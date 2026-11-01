# 対象ラベル: sqrt_squared_is_original
# 主張: z ∈ ℂ について √z·√z = z。
# √z を def_sqrt_cc の式どおり（φ_polar(z) の類の半径の非負平方根と、角度の類の [0,2π) の代表元の半分）に作り、
# ℂ の積の定義で二乗して、座標で直接与えた z と比べる。代表元の取り方を替えても √z が変わらないことも確かめる。
load("_prelude.sage")

cnt = 0
for z, p0 in SAMPLE_Z:
    values = set()
    for p in reps_of(p0):
        w = sqrt_cc_by_definition(z, p)
        assert cc_mul(w, w) == z
        values.add(w)
        cnt += 1
    assert len(values) == 1                       # √z は代表元によらない

# 対照: [0,2π) の代表元を使わず角度の半分をそのまま取ると、代表元によって値が −1 倍に変わる
z, p0 = SAMPLE_Z[6]
rr, t = p0
w_a = phi_cartesian((sqrt_aa(rr), t / 2))
w_b = phi_cartesian((sqrt_aa(rr), (t + 2 * pi_) / 2))
assert w_a == (-w_b[0], -w_b[1]) and w_a != w_b
print(f"sqrt(z)*sqrt(z) == z exactly on {cnt} (z, representative) pairs over {len(SAMPLE_Z)} values of z")
print("RESULT: PASS")
