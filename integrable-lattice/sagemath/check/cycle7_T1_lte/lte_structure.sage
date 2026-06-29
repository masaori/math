# cycle 7 / T1: 最も clean な例 P(z)=z-c (1変数) で ℝ/Λ 双対の Λ 側構造を厳密に。
# a_L = Π_{z^L=1} P(z) = Π_{ζ^L=1}(ζ-c) = (-1)^L (c^L - 1)。 |a_L| = c^L - 1。
# ℝ側: (1/L)log|a_L| → log c = m(P)= m(z-c)=max(1,|c|)=c の対数(Mahler 測度=自由エネルギー)。
# Λ側: Φ_L=log(c^L-1)∈Λ, ℓ_p 係数 v_p(c^L-1) は LTE(lifting-the-exponent)で厳密・決定可能:
#   p∤c, p 奇: v_p(c^L-1)= 0 (ord_p(c)∤L) / v_p(c^{ord}-1)+v_p(L) (ord_p(c)|L)。
#   p=2: 別式。
# μ_p(岩澤, 塔 L=p^n の線形成長)は ord_p(c) が p 冪のとき以外 0(=岩澤 μ=0 領域, 稀)。
# ⇒ Λ側の本体は単一数 μ_p でなく、全 L にわたる LTE/円分構造。

def v_p_LTE(c,L,p):
    # 予測式(p 奇, p∤c)
    if c % p == 0: return None
    d = Mod(c,p).multiplicative_order()
    if L % d != 0: return 0
    return (c^d-1).valuation(p) + ZZ(L).valuation(p)

print("="*70)
print("P(z)=z-c, a_L=c^L-1: ℝ側 m(P)=log c, Λ側 v_p=LTE")
print("="*70)
for c in [2,3]:
    print(f"\n#### c={c}: m(P)=log {c} = {float(log(c)):.6f} (ℝ/自由エネルギー)")
    print(f"     (1/L)log|a_L| (L=12) = {float(log(c^12-1)/12):.6f}  → log c")
    for p in [3,5,7,11]:
        if c%p==0: continue
        ok=True; rows=[]
        for L in range(1,25):
            aL=c^L-1
            actual=aL.valuation(p)
            pred=v_p_LTE(c,L,p)
            if pred is None: continue
            if actual!=pred: ok=False
            if L<=12: rows.append((L,actual))
        d=Mod(c,p).multiplicative_order()
        # 岩澤塔 L=p^n
        tower=[ (c^(p^k)-1).valuation(p) for k in range(0,4) ]
        print(f"   p={p}: ord_p({c})={d}, LTE 予測=実測(L=1..24): {ok}; "
              f"v_p(c^L-1) L=1..12: {[r[1] for r in rows]}")
        print(f"        岩澤塔 v_p(c^(p^n)-1) n=0..3: {tower}  (線形成長率=μ_p; ord が p 冪でなければ μ_p=0)")

print("\n"+"="*70)
print("結論:")
print(" - ℝ側: (1/L)log|a_L| → log c = Mahler 測度(=自由エネルギー). 滑らかな極限.")
print(" - Λ側: v_p(c^L-1) は LTE で厳密・決定可能(ord_p(c)|L 条件 + v_p(L) 成長).")
print("   これが Λ側の本体(円分/LTE 構造). 岩澤 μ_p(塔の線形成長率)は ord_p(c) が")
print("   p 冪でなければ 0(岩澤 μ=0 領域, 非自明は稀=Wieferich 的).")
print(" ⇒ 双対の Λ側の豊かさは単一数 μ_p でなく全 L の LTE 構造にある. これは決定可能・形式検証可能.")
print("="*70)
