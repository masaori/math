# 対象ラベル: claim_shifted_mode_riemann_sums
# 結論の式鎖の二行目「h_L^2 = 4π²/L² を代入」: 1/(2L²) = (1/(8π²))·h_L² を記号計算で検算する。
# 極限の定数倍と小区画の誤差評価は実数体の解析の定理で、有限検算では証明できない
# （Lean 具体版 `halfInvSq_sampleSum_tendsto` が根拠）。
var('L S I', domain='real')
h = 2*pi/L
assert bool((1/(2*L**2) - 1/(8*pi**2)*h**2).simplify_full() == 0)
assert bool((1/(2*L**2)*S - 1/(8*pi**2)*(h**2*S)).simplify_full() == 0)
# 三行目の値: (1/(8π²))·I = I/(8π²)
assert bool(1/(8*pi**2)*I == I/(8*pi**2))
for LL in range(1, 9):
    hh = 2*pi/LL
    assert bool((QQ(1)/(2*LL**2) - 1/(8*pi**2)*hh**2).simplify_full() == 0)
print("PASS: check_limit_rewrite_lines")
