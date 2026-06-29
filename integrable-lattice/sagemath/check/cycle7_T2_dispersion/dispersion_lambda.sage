# cycle 7 / T2: カイラル Potts(超可積分 ℤ_3)スペクトルの λ 依存を記号的に。
# H(λ)=H0+λH1 over ℚ(ω)[λ]。charpoly(x) を因数分解し、2次因子 x^2+b(λ)x+c(λ) の
# 判別式 disc(λ)=b^2-4c を見る。Onsager 分散なら disc ∝ (1+λ^2-2λ cosθ) 型(λ の2次式)。

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
    # over Rl
    return H0.change_ring(Rl) + lam*H1.change_ring(Rl)

print("="*70)
print("カイラル Potts N=2 スペクトルの λ 依存 (Onsager 分散の確認)")
print("="*70)
N=2
H=H_lambda(N)
S.<x>=Rl[]
cp=H.charpoly(x)   # ∈ Rl[x] = K[lam][x]
fac=cp.factor()
print(f"N={N}: charpoly 因数分解(因子, λ 依存):")
discs=[]
for g,mult in fac:
    dg=g.degree()
    if dg==1:
        root=-g.list()[0]/g.list()[1]
        print(f"  [deg1, x{mult}] 固有値 = {root}")
    elif dg==2:
        co=g.list()  # [c0,c1,c2]
        a2,b1,c0=co[2],co[1],co[0]
        disc=(b1^2-4*a2*c0)/a2^2
        discs.append(disc)
        print(f"  [deg2, x{mult}] x^2+({b1/a2})x+({c0/a2}); 判別式 disc(λ)={disc}")
    else:
        print(f"  [deg{dg}, x{mult}] (高次因子)")

print("\n 判別式(λの式)を 1+λ^2-2λcosθ 型と照合:")
for d in discs:
    # d = A*(λ^2 + B λ + C) の形か。係数を見る。
    dp=Rl(d)
    cl=dp.list()
    print(f"   disc={dp}  係数[定数,λ,λ^2]={cl}")
    if len(cl)==3 and cl[2]!=0:
        A=cl[2]; B=cl[1]/A; C=cl[0]/A
        # 1+λ^2-2λcosθ なら C/A=1, B/A=-2cosθ
        print(f"     → A={A}, λ^2 係数で割ると λ^2 + ({B})λ + ({C}); ")
        print(f"        Onsager 型 (λ^2 -2cosθ λ +1) と比較: 定数項={C}(=1なら適合), cosθ=-{B}/2={-B/2}")

print("\n"+"="*70)
print("読み: 判別式が A(λ^2 - 2cosθ λ + 1) の形なら Onsager 分散 √(1+λ^2-2λcosθ) を確認。")
print(" cosθ が代数的(cubic 等)なら全体次数に 3,6 が出る(cycle6 の説明と整合)。")
print("="*70)
