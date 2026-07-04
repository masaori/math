# 奇 L=13,15,17,19 で v_2(τ(L))=2(L-1) を検証強化。
def torus(L):
    C=graphs.CycleGraph(L); return C.cartesian_product(C)
print("奇 L で v_2(τ(L)) vs 2(L-1):")
for L in [3,5,7,9,11,13,15,17,19]:
    t=ZZ(torus(L).spanning_trees_count())
    v=t.valuation(2)
    print(f"  L={L}: v_2(τ)={v}, 2(L-1)={2*(L-1)}, 一致={v==2*(L-1)}")
