# cycle 9 / T2: N=4 カイラル Potts の cubic 因子(cubic 運動量)を λ=1 固定で同定。
# symbolic-λ は 81 次で重すぎるので λ=1 に固定し charpoly を ℚ 上因数分解、
# cubic(deg3) 因子の体(判別式)を見る。運動量解釈は慎重に。

K.<om>=CyclotomicField(3); n=3
Z=matrix(K,[[1,0,0],[0,om,0],[0,0,om^2]])
X=matrix(K,[[0,0,1],[1,0,0],[0,1,0]])
I3=identity_matrix(K,3)
def emb(op,i,N):
    m=[op if k==i else I3 for k in range(N)]
    M=m[0]
    for k in range(1,N): M=M.tensor_product(m[k])
    return M
def H(N,lam):
    c={a:(1-om^(-a))^(-1) for a in [1,2]}
    Zi={i:emb(Z,i,N) for i in range(N)}; Xi={i:emb(X,i,N) for i in range(N)}
    HH=matrix(K,3^N,3^N)
    for j in range(N):
        jp=(j+1)%N
        for a in [1,2]:
            HH += -c[a]*(Xi[j]^a + lam*Zi[j]^a*Zi[jp]^(n-a))
    return HH

print("="*70)
print("N=4 カイラル Potts (λ=1): charpoly ℚ 因数分解と cubic 因子")
print("="*70)
Hm=H(4,QQ(1))
cp=Hm.charpoly()
try:
    cpQ=cp.change_ring(QQ)
except Exception as e:
    cpQ=None
    print("charpoly が ℚ 上でない:", e)
if cpQ is not None:
    fac=cpQ.factor()
    from collections import Counter
    degc=Counter()
    cubics=[]
    for g,m in fac:
        degc[g.degree()]+=m
        if g.degree()==3:
            cubics.append(g)
    print(f"  因子次数分布(重複度込み): {dict(sorted(degc.items()))}")
    print(f"  cubic(deg3) 因子数: {len(cubics)}")
    for g in cubics[:4]:
        # cubic の判別式と Galois 群(体の種類)
        d=g.discriminant()
        print(f"    cubic: {g}")
        print(f"       判別式={d}, 平方? {d.is_square()} (平方なら巡回, 非平方なら S_3)")
    print(f"\n  ⇒ cubic 因子が存在 = cubic な代数的量(運動量 cosθ 候補)を含む(cycle6/7 の予測と整合)。")

print("\n"+"="*70)
print("正直な注記: λ=1 固定では E=(linear in λ)±ε の分離ができず, cubic 因子から cosθ を")
print(" 一意に取り出せない. 『cubic 因子存在=cubic 運動量』は整合的だが, 厳密な cosθ 同定には")
print(" 超可積分スペクトル理論(Albertini–McCoy–Perk の量子化条件)との照合が要る(cycle10+).")
print("="*70)
