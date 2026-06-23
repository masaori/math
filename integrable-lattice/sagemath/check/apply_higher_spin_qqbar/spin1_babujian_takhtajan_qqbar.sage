# step 4: 本命(高スピン可積分)への適用。
# 可積分スピン1鎖(Babujian–Takhtajan 点): H = sum_j [ (S_j·S_{j+1}) - (S_j·S_{j+1})^2 ].
# 六頂点(スピン1/2)の高スピン版。熱力学極限(Haldane ギャップ・相関の閉形式)は
# スピン1/2 XXZ より遥かに非自明＝「可積分だが極限が難しい」母集団。
#
# 主張(C-U3/lambda-statement-program): 有限 N スペクトルは代数的(ℚ̄)・最小多項式 witness・
# 決定可能・ℝ 不使用。極限のみが ℝ 側。

# スピン1 行列。Sx,Sy は √2,i を含むが S·S は有理。QQbar で組んで有理係数を確認。
r2 = QQbar(2).sqrt()
I_ = QQbar(I)
Sx = (1/r2)*matrix(QQbar,[[0,1,0],[1,0,1],[0,1,0]])
Sy = (1/r2)*matrix(QQbar,[[0,-I_,0],[I_,0,-I_],[0,I_,0]])
Sz = matrix(QQbar,[[1,0,0],[0,0,0],[0,0,-1]])
I3 = identity_matrix(QQbar,3)

def emb(op,i,N):
    mats=[op if k==i else I3 for k in range(N)]
    M=mats[0]
    for k in range(1,N):
        M=M.tensor_product(mats[k])
    return M

def dot_two_site(i,j,N):
    return emb(Sx,i,N)*emb(Sx,j,N)+emb(Sy,i,N)*emb(Sy,j,N)+emb(Sz,i,N)*emb(Sz,j,N)

def H_BT(N):
    dim=3^N
    H=matrix(QQbar,dim,dim)
    for j in range(N):
        jp=(j+1)%N
        SS=dot_two_site(j,jp,N)
        H += SS - SS*SS
    # S·S 由来は有理 ⇒ H を QQ へ coerce 可能か確認しつつ返す
    return H

print("="*70)
print("可積分スピン1鎖(Babujian–Takhtajan)の有限 N スペクトル ∈ ℚ̄")
print("="*70)

for N in [2,3,4]:
    H = H_BT(N)
    # 有理性確認: 全成分が有理
    is_rat = all(e in QQ for e in H.list())
    Hq = H.change_ring(QQ) if is_rat else H
    cp = Hq.charpoly()
    fac = cp.factor()
    evs = Hq.eigenvalues(extend=True)
    all_alg = all(ev in QQbar for ev in evs)
    degs = sorted(set(QQbar(ev).minpoly().degree() for ev in evs))
    print(f"\nN={N}: dim={3^N}, H 成分は有理={is_rat}, charpoly∈QQ[x] deg={cp.degree()}")
    print(f"   全固有値∈QQbar={all_alg}, 固有値の最小多項式次数={degs}")
    print(f"   charpoly 既約分解(次数別の因子数): {[ (g.degree(),m) for g,m in fac ]}")
    if N in (2,3):
        # 非自明(degree>=2)な最小多項式を1つ提示(witness 例)
        wit=[QQbar(ev).minpoly() for ev in evs if QQbar(ev).minpoly().degree()>=2]
        if wit:
            print(f"   witness 例(次数≥2 の最小多項式): {wit[0]}")
        else:
            print(f"   (この N では全固有値が有理)")

print("\n"+"="*70)
print("結論:")
print(" - 高スピン可積分(スピン1 BT)でも有限 N スペクトルは QQbar・最小多項式 witness・決定可能。")
print(" - ℝ 不使用。極限(Haldane ギャップ/相関の閉形式=未解決)のみが ℝ 側。")
print(" - 六頂点(スピン1/2)で見た構造的分離が高スピンでも保たれる(C-U3 の射程確認)。")
print("="*70)
