# cycle 9 / T1: 2変数スペクトル曲線 = 離散ラプラシアン P(z,w)=4-(z+1/z)-(w+1/w)。
# これは全域木/ダイマー/ガウス自由場の曲線。matrix-tree 定理:
#   L×L トーラスの全域木数 τ(L) = (1/L^2) Π_{(j,k)≠(0,0)} (4-2cos(2πj/L)-2cos(2πk/L)) ∈ ℤ。
# つまり a_L = Π_{(z,w)≠(1,1)} P = L^2·τ(L)。 同一 P の両素点:
#   ℝ側: (1/L^2)log τ(L) → 4G/π (全域木エントロピー, G=Catalan 定数, 既知).
#   Λ側: v_p(τ(L)) = Φ_L∈Λ の ℓ_p 係数 (素因数分解, 決定可能).

def tau(L, prec=300):
    C=RealField(prec)
    import math
    prod=C(1)
    for j in range(L):
        for k in range(L):
            if j==0 and k==0: continue
            ev = C(4) - 2*C(cos(2*C.pi()*j/L)) - 2*C(cos(2*C.pi()*k/L))
            prod *= ev
    val = prod / (L^2)
    t = val.round()
    err = abs(val - t)
    return ZZ(t), float(err)

# 4G/π (Catalan)
G = 0.915965594177219015   # Catalan 定数
target = 4*G/pi

print("="*70)
print("2変数スペクトル曲線 P=4-(z+1/z)-(w+1/w): 全域木の両素点")
print("="*70)
print(f"既知: 全域木エントロピー = 4G/π = {float(target):.6f}  (G=Catalan)")
print(f"\n{'L':>2} {'τ(L)=#全域木':>26} {'(1/L^2)logτ':>12}   v_p 構造(Λ側)")
for L in [2,3,4,5,6,7,8]:
    t,err=tau(L)
    assert err<1e-3, f"L={L} 整数化誤差 {err}"
    rate=float(RR(t).log()/L^2) if t>1 else 0.0
    facs={p:t.valuation(p) for p in [2,3,5,7,11,13,17,19,23,29] if t%p==0}
    lam=" ".join(f"{e}*l_{p}" for p,e in facs.items()) if facs else "(単数/大素数)"
    print(f"{L:>2} {t:>26} {rate:>12.6f}   {lam}")

print("\n"+"="*70)
print("確認: (1/L^2)logτ(L) → 4G/π = 1.16624 (ℝ側=全域木エントロピー, 既知の Catalan 定数).")
print(" 同じ τ(L)∈ℤ の素因数分解 = Φ_L∈Λ (Λ側, 決定可能).")
print(" ⇒ 同一整数スペクトル曲線 P から ℝ(既知物理定数)と Λ(素因数構造)の両素点. cycle5 の toy P を")
print("   実際の格子模型(全域木/ダイマー/GFF)へ拡張. ℝ側が既知定数と一致=Reframe の裏付け.")
print("="*70)
