# cycle 11 / T2: XXZ 2マグノンセクター(Bethe 可解の最小非自明)の有限 N スペクトル∈ℚ̄。
# H_XXZ = Σ_j (X_jX_{j+1}+Y_jY_{j+1}+Δ Z_jZ_{j+1}), 周期。M=2(down 2個)セクターに制限。
def pauli():
    X=matrix(QQ,[[0,1],[1,0]]); Yi=matrix(QQ,[[0,-1],[1,0]]); Z=matrix(QQ,[[1,0],[0,-1]]); I=identity_matrix(QQ,2)
    return X,Yi,Z,I
def op_at(op,j,N,I):
    m=[op if k==j else I for k in range(N)]
    M=m[0]
    for k in range(1,N): M=M.tensor_product(m[k])
    return M
def Hxxz(N,D):
    X,Yi,Z,I=pauli(); dim=2^N; H=matrix(QQ,dim,dim)
    for j in range(N):
        jp=(j+1)%N
        H+= op_at(X,j,N,I)*op_at(X,jp,N,I) - op_at(Yi,j,N,I)*op_at(Yi,jp,N,I) + D*op_at(Z,j,N,I)*op_at(Z,jp,N,I)
    return H
def sector_M(N,M):
    # down-spin(bit=1) が M 個の基底の index
    return [i for i in range(2^N) if bin(i).count('1')==M]

print("XXZ 2マグノンセクターの固有値∈ℚ̄:")
for (N,D) in [(4,QQ(1)/2),(6,QQ(1)/2),(6,QQ(2))]:
    H=Hxxz(N,D); idx=sector_M(N,2)
    Hs=H.matrix_from_rows_and_columns(idx,idx)
    cp=Hs.charpoly()
    evs=Hs.eigenvalues(extend=True)
    allalg=all(e in QQbar for e in evs)
    degs=sorted(set(QQbar(e).minpoly().degree() for e in evs))
    print(f"  N={N},Δ={D}: M=2 dim={len(idx)}, charpoly={cp.factor()}")
    print(f"      全固有値∈QQbar={allalg}, 最小多項式次数={degs}")
