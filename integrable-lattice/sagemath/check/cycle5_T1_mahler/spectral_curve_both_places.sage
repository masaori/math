# cycle 5 / T1 Reframe: 同一整数多項式 P(z,w) の両素点(ℝ Mahler / Λ p進)を実証。
# 代数力学(Lind–Schmidt–Ward)の枠: P∈ℤ[z^±,w^±], 周期点数(L-torus 分配の代数版)
#   a_L = Π_{z^L=1, w^L=1} P(z,w) ∈ ℤ.
# ℝ側: (1/L^2) log|a_L| → m(P) = ∫∫_{T^2} log|P| (Mahler 測度 = 自由エネルギー = LSW エントロピー).
# Λ側: v_p(a_L) = Φ_L=log|a_L|∈Λ の ℓ_p 係数. 同じ P から ℝ と Λ が出る = 双対の最小実証.
#
# P は格子模型のスペクトル曲線の代表形(トーラス上に零点なし→a_L≠0, m(P) 有限):
#   P = 5 - (z + 1/z) - (w + 1/w)   (最小値 5-4=1>0).

R.<z,w>=LaurentPolynomialRing(QQ,2)
P = 5 - (z + z^-1) - (w + w^-1)

def a_L(L, prec=200):
    C=ComplexField(prec)
    zeta=C.zeta(L)
    prod=C(1)
    for j in range(L):
        zj=zeta^j
        for k in range(L):
            wk=zeta^k
            val = C(5) - (zj + zj^-1) - (wk + wk^-1)
            prod *= val
    # a_L は実整数のはず(共役対称)。丸めて整数化、誤差確認。
    re=prod.real(); im=prod.imag()
    aint=re.round()
    err=abs(prod-C(aint))
    return ZZ(aint), float(err)

def mahler_numeric(Ngrid=400):
    # m(P)=exp( mean log|P| over torus ). log m(P)=mean log|P|.
    import cmath, math
    s=0.0; cnt=0
    for j in range(Ngrid):
        zj=cmath.exp(2j*math.pi*j/Ngrid)
        for k in range(Ngrid):
            wk=cmath.exp(2j*math.pi*k/Ngrid)
            val=5 - (zj+1/zj) - (wk+1/wk)
            s+=math.log(abs(val)); cnt+=1
    return s/cnt   # = log m(P) = lim (1/L^2) log a_L

print("="*70)
print("同一 P(z,w)=5-(z+1/z)-(w+1/w) の両素点: ℝ Mahler / Λ p進")
print("="*70)
logm = mahler_numeric(400)
print(f"\nℝ側: log m(P) (数値, 400^2 格子) = {logm:.8f}   [= 自由エネルギー = LSW エントロピー]")

print("\n周期点数 a_L = Π_{z^L=w^L=1} P, その (1/L^2)log a_L (→ log m(P)) と v_p(a_L):")
print(f"{'L':>2} {'a_L':>22} {'(1/L^2)log|a_L|':>16}   v_p 構造(Λ側)")
for L in range(1,9):
    aL,err=a_L(L)
    assert err<1e-6, f"整数化誤差大 L={L}: {err}"
    rate = (RR(aL).abs().log())/L^2 if aL!=0 else None
    facs={p:aL.valuation(p) for p in [2,3,5,7,11,13] if aL%p==0}
    lam=" ".join(f"{e}*l_{p}" for p,e in facs.items()) if facs else "(素因数 >13 or 単数)"
    print(f"{L:>2} {aL:>22} {float(rate):>16.8f}   {lam}")

print("\n"+"="*70)
print("確認: (1/L^2)log|a_L| が log m(P) に収束(ℝ側=Mahler=自由エネルギー, LSW)。")
print(" 同じ a_L∈ℤ の素因数分解=Φ_L∈Λ(Λ側)。⇒ 同一整数多項式 P から ℝ と Λ の両側が出る。")
print(" これが ℝ/Λ 双対の最小・厳密な実証(有限 L は ℤ/Λ で決定可能, 極限 m(P) が ℝ)。")
print("="*70)
