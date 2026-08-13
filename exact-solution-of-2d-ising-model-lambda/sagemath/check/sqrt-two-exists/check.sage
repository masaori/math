# 対象ラベル: claim_sqrt_two_exists
# 帰属: QQbar（代数的数）の厳密計算。浮動小数点を使わない。

# 主張（claim_sqrt_two_exists）: ある s ∈ QQbar が存在して s * s = 2。
# 証明の組み立てを一行ずつ突き合わせる:
#   prep:  g := t^2 + (-2) ∈ QQbar[t] の係数 ac_2(g) = 1（次数 1 以上であること）
#   root:  aev_s(g) = 0 を満たす s が存在する（代数閉性。QQbar では根を列挙できる）
#   chain: s*s = aev_s(t)*aev_s(t) = aev_s(t*t) = aev_s(t^2)
#              = aev_s(t^2) + ((-2)+2) = (aev_s(t^2) + aev_s(-2)) + 2
#              = aev_s(g) + 2 = 0 + 2 = 2

R = PolynomialRing(QQbar, "t")
t = R.gen()

# 準備: g = t^2 + (-2)。係数 ac_2(g) = 1 ≠ 0（次数 1 以上）。
minus_two = -(QQbar(1) + QQbar(1))
g = t**2 + R(minus_two)
assert g[2] == QQbar(1) + QQbar(0), "ac_2(g) = ac_2(t^2) + ac_2(-2) = 1 + 0 が壊れている"
assert g[2] != QQbar(0), "ac_2(g) ≠ 0（次数 1 以上）が壊れている"
assert g.degree() == 2, "g の次数が 2 でない"

# 根の存在（代数閉性）: QQbar では根を厳密に列挙できる。
roots = g.roots(multiplicities=False)
assert len(roots) == 2, f"t^2 - 2 の根の個数が 2 でない: {len(roots)}"

# 各根 s について、証明の鎖を一行ずつ突き合わせる。
two = QQbar(1) + QQbar(1)
checked = 0
for s in roots:
    aev_t = t(s)  # aev_s(t)
    assert aev_t == s, "aev_s(t) = s が壊れている"
    lhs = s * s
    assert lhs == aev_t * aev_t, "s*s = aev_s(t)·aev_s(t) が壊れている"
    assert aev_t * aev_t == (t * t)(s), "aev_s(t)·aev_s(t) = aev_s(t·t)（積を保つ）が壊れている"
    assert (t * t)(s) == (t**2)(s), "t·t = t^2（冪の約束）が壊れている"
    assert (t**2)(s) == (t**2)(s) + QQbar(0), "零元との和が壊れている"
    assert QQbar(0) == minus_two + two, "(-2) + 2 = 0（加法の逆元）が壊れている"
    assert R(minus_two)(s) == minus_two, "aev_s(-2) = -2（定数の値）が壊れている"
    assert ((t**2)(s) + R(minus_two)(s)) + two == (t**2 + R(minus_two))(s) + two, \
        "aev は和を保つ、が壊れている"
    assert (t**2 + R(minus_two))(s) == g(s), "g の定義が壊れている"
    assert g(s) == QQbar(0), "aev_s(g) = 0（根であること）が壊れている"
    assert lhs == two, f"主張 s*s = 2 が壊れている: s = {s}"
    checked += 1

# 2 根は互いに加法の逆元であり相異なる（本文の後続セクションの準備としての観察。
# 主張そのものは存在だけを述べる）。
assert roots[0] == -roots[1], "2 根が互いに加法の逆元でない"
assert roots[0] != roots[1], "2 根が相異なることが壊れている"

print(f"OK: claim_sqrt_two_exists — 2 根の両方で鎖の全段を厳密検査した（検査した根: {checked} 個）")
