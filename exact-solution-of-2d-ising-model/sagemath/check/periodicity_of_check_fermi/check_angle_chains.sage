# 対象ラベル: periodicity_of_check_fermi
# (2) の θ~_{μ+kM} の鎖・-θ~_{μ+kM} の鎖、(3) の θ~_ν・-θ~_ν の鎖、準備の第二 (-k)_R = -k_R を一行ずつ確かめる。
# 一般の点: π・μ_R・k_R・(M)_R を QQ 上の不定元にした有理関数体で、本文の各行を別々の式として組み、隣と比べる。
# 具体の点: M = 2..8、μ, k ∈ ZZ の範囲で、各行を θ/π ∈ QQ として厳密に比べる。浮動小数点なし。
load("_prelude.sage")

rep = Report("periodicity_of_check_fermi: 角度の鎖")

R.<PI, mu, kk, MM> = PolynomialRing(QQ)
Fr = R.fraction_field()
PI, mu, kk, MM = [Fr(v) for v in (PI, mu, kk, MM)]
h = QQ(1) / 2

def tt(m):
    """θ~ の定義（antiperiodic_exp_sum）: 添字の像 m を受け取って 2π(m - 1/2)/(M)_R。"""
    return 2 * PI * (m - h) / MM

# ---- (2) θ~_{μ+kM} の鎖 ----
# 包含 ι_{Z→R} は和・積を保つので、(μ + kM)_R を不定元の式 μ_R + k_R(M)_R で表す。第 1〜3 行は有理関数体の上では
# 同じ式になる（ι を和・積の準同型として持つ以外の表し方が無い）。この 2 行の中身は具体の点の整数で確かめる。
chain2 = [
    2 * PI * ((mu + kk * MM) - h) / MM,              # θ~ の定義を μ+kM で（像 (μ+kM)_R）
    2 * PI * ((mu + (kk * MM)) - h) / MM,            # ι は和を保つ
    2 * PI * ((mu + kk * MM) - h) / MM,              # ι は積を保つ
    2 * PI * ((kk * MM + mu) - h) / MM,              # 加法の交換律
    2 * PI * ((kk * MM + mu) + (-h)) / MM,           # 差の定義
    2 * PI * (kk * MM + (mu + (-h))) / MM,           # 加法の結合律
    2 * PI * (kk * MM + (mu - h)) / MM,              # 差の定義を右辺から左辺へ
    2 * PI * ((mu - h) + kk * MM) / MM,              # 加法の交換律
    (2 * PI * (mu - h) + 2 * PI * (kk * MM)) / MM,   # 分配法則
    (2 * PI * (mu - h) + 2 * PI * (kk * MM)) * MM**(-1),             # def_real_quotient
    (2 * PI * (mu - h)) * MM**(-1) + (2 * PI * (kk * MM)) * MM**(-1),  # 右からの分配律
    2 * PI * (mu - h) / MM + (2 * PI * (kk * MM)) * MM**(-1),        # def_real_quotient を右辺から左辺へ
    tt(mu) + (2 * PI * (kk * MM)) * MM**(-1),        # θ~_μ の定義
    tt(mu) + ((2 * PI * kk) * MM) * MM**(-1),        # 乗法の結合律を右辺から左辺へ
    tt(mu) + (2 * PI * kk) * (MM * MM**(-1)),        # 乗法の結合律
    tt(mu) + (2 * PI * kk) * 1,                      # 乗法の逆元（(M)_R ≠ 0）
    tt(mu) + 2 * PI * kk,                            # 乗法の単位元
]
rep.check(len(chain2) == 17, "(2) θ~_(μ+kM) の鎖は 17 行")
for j in range(len(chain2) - 1):
    rep.check(chain2[j] == chain2[j + 1], f"(2) θ~_(μ+kM) の鎖 第 {j+1} 行 = 第 {j+2} 行")
rep.check(chain2[0] == tt(mu + kk * MM), "(2) θ~_(μ+kM) の鎖 第 1 行は θ~ の定義")
rep.check(tt(mu + kk * MM) != tt(mu) + PI * kk, "(2) 対照: θ~_(μ+kM) ≠ θ~_μ + kπ")
rep.check(MM * MM**(-1) == 1 and MM * MM**(-1) != MM, "(2) 乗法の逆元の行: (M)_R (M)_R^(-1) = 1_R（対照: (M)_R とは違う）")

neg2 = [
    -(tt(mu) + 2 * PI * kk),
    (-tt(mu)) + (-(2 * PI * kk)),
    (-tt(mu)) + 2 * PI * (-kk),
    (-tt(mu)) + 2 * PI * (-kk),   # 準備の第二 (-k)_R = -k_R。不定元の上では同じ式（中身は下の整数の検算）
]
rep.check(-chain2[0] == neg2[0], "(2) -θ~_(μ+kM) の鎖 第 1 行は上の鎖")
for j in range(len(neg2) - 1):
    rep.check(neg2[j] == neg2[j + 1], f"(2) -θ~_(μ+kM) の鎖 第 {j+1} 行 = 第 {j+2} 行")

# ---- (3) θ~_ν・-θ~_ν の鎖（ν = M + 1 - μ） ----
one = Fr(1)
nu_chain = [
    2 * PI - tt(mu),                  # conjugate_index_of_check_Z_Y (1)
    2 * PI + (-tt(mu)),               # 差の定義
    (-tt(mu)) + 2 * PI,               # 加法の交換律
    (-tt(mu)) + 2 * PI * one,         # 1_R は積の単位元
    (-tt(mu)) + 2 * PI * one,         # ι は単位元を保つ（像 (1)_R = 1_R。中身は下の整数の検算）
]
rep.check(tt(MM + 1 - mu) == nu_chain[0], "(3) conjugate_index_of_check_Z_Y (1): θ~_(M+1-μ) = 2π - θ~_μ")
for j in range(len(nu_chain) - 1):
    rep.check(nu_chain[j] == nu_chain[j + 1], f"(3) θ~_ν の鎖 第 {j+1} 行 = 第 {j+2} 行")
neg_nu = [
    -(2 * PI - tt(mu)),
    tt(mu) + (-(2 * PI)),
    tt(mu) + 2 * PI * (-one),
    tt(mu) + 2 * PI * (-one),         # ι は単位元を保つ（像 (1)_R = 1_R。中身は下の整数の検算）
    tt(mu) + 2 * PI * (-one),         # 準備の第二を k = 1 で（中身は下の整数の検算）
]
rep.check(-tt(MM + 1 - mu) == neg_nu[0], "(3) -θ~_ν の鎖 第 1 行")
for j in range(len(neg_nu) - 1):
    rep.check(neg_nu[j] == neg_nu[j + 1], f"(3) -θ~_ν の鎖 第 {j+1} 行 = 第 {j+2} 行")
rep.check(tt(MM + 1 - mu) != (-tt(mu)) + PI, "(3) 対照: θ~_ν ≠ -θ~_μ + π")

# ---- 準備の第二 (-k)_R = -k_R と、包含が和・積・単位元を保つこと（整数の具体の点） ----
# ι_{Z→R} を ZZ → QQ の埋め込みで持つ（QQ ⊂ ℝ。この検算に実数の完備性は要らない）。
iota = lambda a: QQ(a)
ok = True
for k in range(-30, 31):
    lines = [iota(-k), iota(-k) + QQ(0), iota(-k) + (iota(k) + (-iota(k))), (iota(-k) + iota(k)) + (-iota(k)),
             iota((-k) + k) + (-iota(k)), iota(0) + (-iota(k)), QQ(0) + (-iota(k)), -iota(k)]
    ok = ok and all(lines[j] == lines[j + 1] for j in range(len(lines) - 1))
rep.check(ok, "準備の第二 (-k)_R の鎖 7 等号（k = -30..30）")
ok = all(iota(a + b) == iota(a) + iota(b) and iota(a * b) == iota(a) * iota(b) for a in range(-12, 13) for b in range(-12, 13))
rep.check(ok and iota(1) == 1 and iota(0) == 0, "ι は和・積・単位元・零を保つ（-12..12）")

# ---- 具体の点: θ/π ∈ QQ で各行 ----
cnt = 0; bad = 0
for M in M_RANGE:
    for m in range(-2 * M, 3 * M + 1):
        for k in range(-3, 4):
            q = lambda v: QQ(v)
            T = lambda a: theta_tilde_over_pi(M, a)
            lines = [
                T(m + k * M),
                2 * ((QQ(m) + QQ(k * M)) - h) / M,
                2 * ((QQ(m) + QQ(k) * QQ(M)) - h) / M,
                2 * ((QQ(k) * QQ(M) + QQ(m)) - h) / M,
                2 * ((QQ(k) * QQ(M) + QQ(m)) + (-h)) / M,
                2 * (QQ(k) * QQ(M) + (QQ(m) + (-h))) / M,
                2 * (QQ(k) * QQ(M) + (QQ(m) - h)) / M,
                2 * ((QQ(m) - h) + QQ(k) * QQ(M)) / M,
                (2 * (QQ(m) - h) + 2 * (QQ(k) * QQ(M))) / M,
                (2 * (QQ(m) - h) + 2 * (QQ(k) * QQ(M))) * QQ(M)**(-1),
                (2 * (QQ(m) - h)) * QQ(M)**(-1) + (2 * (QQ(k) * QQ(M))) * QQ(M)**(-1),
                2 * (QQ(m) - h) / M + (2 * (QQ(k) * QQ(M))) * QQ(M)**(-1),
                T(m) + (2 * (QQ(k) * QQ(M))) * QQ(M)**(-1),
                T(m) + ((2 * QQ(k)) * QQ(M)) * QQ(M)**(-1),
                T(m) + (2 * QQ(k)) * (QQ(M) * QQ(M)**(-1)),
                T(m) + (2 * QQ(k)) * 1,
                T(m) + 2 * QQ(k),
            ]
            negs = [-(T(m) + 2 * QQ(k)), (-T(m)) + (-(2 * QQ(k))), (-T(m)) + 2 * (-QQ(k)), (-T(m)) + 2 * QQ(-k)]
            cnt += 1
            if not (all(lines[j] == lines[j + 1] for j in range(len(lines) - 1))
                    and -T(m + k * M) == negs[0] and all(negs[j] == negs[j + 1] for j in range(len(negs) - 1))):
                bad += 1
rep.check(bad == 0, f"(2) の二つの鎖の各行（M = 2..8、μ = -2M..3M、k = -3..3、{cnt} 組）")

cnt = 0; bad = 0
for M in M_RANGE:
    for m in range(1, M + 1):
        nu = M + 1 - m
        T = lambda a: theta_tilde_over_pi(M, a)
        cnt += 1
        if not (1 <= nu <= M
                and T(nu) == 2 - T(m) == 2 + (-T(m)) == (-T(m)) + 2 == (-T(m)) + 2 * 1 == (-T(m)) + 2 * QQ(1)
                and -T(nu) == -(2 - T(m)) == T(m) + (-2) == T(m) + 2 * (-1) == T(m) + 2 * (-QQ(1)) == T(m) + 2 * QQ(-1)):
            bad += 1
rep.check(bad == 0, f"(3) ν ∈ M̌ と θ~_ν・-θ~_ν の鎖の各行（M = 2..8 の全 μ ∈ M̌、{cnt} 組）")

rep.finish()
