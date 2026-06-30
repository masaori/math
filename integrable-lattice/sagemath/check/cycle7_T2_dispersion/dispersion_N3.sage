# cycle 8 / T2: N=3 カイラル Potts の λ 記号スペクトルから運動量 cosθ_k を抽出。
# charpoly(x) over ℚ(ω)[λ] を因数分解。deg2(x) 因子の判別式 = A(1+λ^2-2λcosθ) → cosθ。
# 高次(deg 3,4,6) 因子は cubic 等の運動量を符号化(cycle6/7 の説明)。

K.<om>=CyclotomicField(3); n=3
Rl.<lam>=K[]
Z=matrix(K,[[1,0,0],[0,om,0],[0,0,om^2]])
X=matrix(K,[[0,0,1],[1,0,0],[0,1,0]])
I3=identity_matrix(K,3)
def emb(op,i,N):
    m=[op if k==i else I3 for k in range(N)]
    M=m[0]
    for k in range(1,N): M=M.tensor_product(m[k])
    return M
def H_lambda(N):
    c={a:(1-om^(-a))^(-1) for a in [1,2]}
    Zi={i:emb(Z,i,N) for i in range(N)}; Xi={i:emb(X,i,N) for i in range(N)}
    H0=matrix(K,3^N,3^N); H1=matrix(K,3^N,3^N)
    for j in range(N):
        jp=(j+1)%N
        for a in [1,2]:
            H0 += -c[a]*Xi[j]^a
            H1 += -c[a]*Zi[j]^a*Zi[jp]^(n-a)
    return H0.change_ring(Rl)+lam*H1.change_ring(Rl)

N=3
print("="*70); print(f"カイラル Potts N={N}: λ 記号スペクトルと運動量 cosθ_k"); print("="*70)
H=H_lambda(N)
S.<x>=Rl[]
cp=H.charpoly(x)
print("因数分解中(27次, 時間がかかる場合あり)...")
fac=cp.factor()
degcount={}
cosset=[]
for g,mult in fac:
    d=g.degree()
    degcount[d]=degcount.get(d,0)+mult
    if d==2:
        co=g.list(); a2,b1,c0=co[2],co[1],co[0]
        disc=Rl((b1^2-4*a2*c0)/a2^2)
        cl=disc.list()
        if len(cl)==3 and cl[2]!=0 and cl[0]/cl[2]==1:
            costh=-(cl[1]/cl[2])/2
            cosset.append(costh)
            print(f"  deg2(x) x{mult}: disc={disc} → 1+λ²-2λ·({costh}),  cosθ={costh}")
        else:
            print(f"  deg2(x) x{mult}: disc={disc} (Onsager 型でない or 定数項≠λ²係数)")
    else:
        print(f"  deg{d}(x) x{mult}: 高次因子(cubic 等の運動量を符号化)")

print(f"\n  因子次数分布(x について): {degcount}")
print(f"  抽出された cosθ_k(deg2 由来): {sorted(set(cosset))}")
print("\n"+"="*70)
print("読み: deg2 因子から cosθ を直接抽出。高次因子は cosθ が cubic 等(非2冪次数の由来)。")
print(" N とともに cosθ_k が [-1,1] を稠密化 → 連続分散 ε(θ)=√(1+λ²-2λcosθ)(ℝ脱出一点)。")
print("="*70)
