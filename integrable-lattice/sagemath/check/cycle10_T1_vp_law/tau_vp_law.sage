# cycle 10 / T1: 全域木数 τ(L)=#spanning trees of L×L トーラス の v_p(τ(L)) の L 依存則。
# τ(L) を厳密整数で計算(Kirchhoff, spanning_trees_count)。Λ側=Φ_L=log τ(L) の ℓ_p 係数。

def torus(L):
    C=graphs.CycleGraph(L)
    return C.cartesian_product(C)

print("="*70)
print("τ(L)=#spanning trees(L×L torus) の素因数分解と v_p 則")
print("="*70)
taus={}
for L in range(2,13):
    G=torus(L)
    t=ZZ(G.spanning_trees_count())
    taus[L]=t
    fac=factor(t)
    print(f"  L={L:2}: τ={t}")
    print(f"        = {fac}")

print("\n--- v_p(τ(L)) を p 別に(L=2..12) ---")
for p in [2,3,5,7,11,13]:
    row=[taus[L].valuation(p) for L in range(2,13)]
    print(f"  p={p:2}: {row}")

print("\n--- 素数 L=p での v_p(τ(p)) ---")
for p in [2,3,5,7,11]:
    print(f"  L=p={p}: v_p(τ(p))={taus[p].valuation(p)}")

print("\n"+"="*70)
print("観察: v_p(τ(L)) の L 依存則を読む(下の README に記述)。")
print(" 全て有限 L で厳密整数=決定可能(Λ側)。ℝ側は (1/L^2)logτ→4G/π。")
print("="*70)
