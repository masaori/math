# 対象ラベル: def_rayleigh_sup
# 𝓡 が上に有界であることの鎖（|x_k| ≤ 1 の下で）を、有理数成分の行列と単位ベクトルで確かめる。
#   項ごとの 6 行: |x_iW_ijx_j| = |x_iW_ij||x_j| = |x_i||W_ij||x_j| ≤ |x_i||W_ij|·1 = |x_i||W_ij| ≤ 1·|W_ij| = |W_ij|
#   各 i の 2 行: |Σ_j x_iW_ijx_j| ≤ Σ_j|x_iW_ijx_j| ≤ Σ_j|W_ij|
#   外側の 4 行: x^⊤Wx ≤ |x^⊤Wx| = |ΣΣ x_iW_ijx_j| ≤ Σ_i|Σ_j x_iW_ijx_j| ≤ ΣΣ|W_ij|
# 帰属: QQ。‖x‖ = 1 の有理点はピタゴラス数で作る（x を QQ^d に取り、Σ x_k^2 = 1）。浮動小数点は使わない。
def rabs(q):
    """def_real_absolute_value: q >= 0 なら q、q < 0 なら -q。"""
    return q if q >= 0 else -q


PTS = [QQ(-7), QQ(-5)/2, QQ(-1), QQ(-1)/3, QQ(0), QQ(1)/4, QQ(1), QQ(3)/2, QQ(6)] + [AA(2).sqrt(), -AA(3).sqrt()]

def fsum(rs):
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s


def unit_rational(d):
    """QQ^d の単位ベクトル（Σ x_k^2 = 1）を、単位円の有理点 (1-t^2)/(1+t^2), 2t/(1+t^2) を重ねて作る。"""
    x = [QQ(1)]
    for k in range(d - 1):
        t = QQ(randint(-5, 5)) / randint(1, 5)
        c, s = (1 - t^2) / (1 + t^2), 2*t / (1 + t^2)
        x = [y * c for y in x] + [s]
    return x


set_random_seed(20261106)
n = 0
for trial in range(60):
    d = randint(1, 6)
    W = matrix(QQ, d, d, lambda i, j: QQ(randint(-9, 9)) / randint(1, 4))
    x = unit_rational(d)
    assert fsum([xk^2 for xk in x]) == 1
    assert all(rabs(xk) <= 1 for xk in x)                             # 前の段で示した |x_k| ≤ 1
    for i in range(d):
        for j in range(d):
            t = (x[i]*W[i,j])*x[j]                                    # def_real_bilinear_value の項 (x_iW_ij)x_j
            l = [rabs(t), rabs(x[i]*W[i,j])*rabs(x[j]), rabs(x[i])*rabs(W[i,j])*rabs(x[j]),
                 rabs(x[i])*rabs(W[i,j])*1, rabs(x[i])*rabs(W[i,j]), 1*rabs(W[i,j]), rabs(W[i,j])]
            assert l[0] == l[1] == l[2] and l[2] <= l[3] and l[3] == l[4] and l[4] <= l[5] and l[5] == l[6]
        row = [(x[i]*W[i,j])*x[j] for j in range(d)]
        assert rabs(fsum(row)) <= fsum([rabs(r) for r in row]) <= fsum([rabs(W[i,j]) for j in range(d)])
    q = fsum([fsum([(x[i]*W[i,j])*x[j] for j in range(d)]) for i in range(d)])
    qv = vector(QQ, x) * W * vector(QQ, x)
    assert q == qv                                                    # 比べる側: Sage の x^⊤Wx
    inner = [fsum([(x[i]*W[i,j])*x[j] for j in range(d)]) for i in range(d)]
    bound = fsum([fsum([rabs(W[i,j]) for j in range(d)]) for i in range(d)])
    assert qv <= rabs(qv) and rabs(qv) == rabs(q) and rabs(q) <= fsum([rabs(r) for r in inner]) and fsum([rabs(r) for r in inner]) <= bound
    n += 1
print(f"{n} 組の (W, x) で項ごとの 6 行・各 i の 2 行・外側の 4 行を確かめた")
print("RESULT: PASS")
