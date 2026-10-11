# 対象ラベル: claim_gauged_terminal_matrix_determinant
# 帰属: Q(zeta_8)[x]。各行の両辺を独立に計算した行列式から作る。
from itertools import permutations
load('sagemath/check/gauged-terminal-matrix-skew/_prelude.sage')
_gdet_rows = {key: [] for key in ('identity_entry', 'identity_product', 'identity_zero',
    'identity_weight', 'identity', 'root', 'scalar', 'inverse', 'determinant')}
for root_power in (1,3,5,7):
    z=_dg_primitive_root**root_power
    _gdet_rows['root'].append((z**8,(z**4)**2,(-_dg_field.one())**2,_dg_field.one()))
for c in _sk_cases:
    L,z,n=c['L'],c['z'],c['n']
    assert n==4*L**2
    C,x=_sk_ring,_sk_x
    one,zero=C.one(),C.zero()
    U,V=c['U'].change_ring(C),c['V'].change_ring(C)
    J=c['delta']
    T=J-x*c['beta']
    M=matrix(_dg_field,n,lambda i,j:c['eps'][j]*_sk_phase(z,c['directions'][i],c['directions'][j])
        if _sk_tgt(L,c['edges'][i])==_sk_src(L,c['edges'][j]) and j!=c['rev'][i] else 0)
    I=identity_matrix(C,n)
    K=I-x*M.change_ring(C)
    assert T==J*K
    B=(V*T)*U
    scalar=C(z**2)
    G=c['transformed']
    detV,detT,detU=V.det(),T.det(),U.det()
    detVT,detB,detG=(V*T).det(),B.det(),G.det()
    detI,detVU,detK=I.det(),(V*U).det(),K.det()
    _gdet_rows['scalar'].append((scalar**n,C(z**2)**(4*L**2),C((z**2)**(4*L**2)),
        C(z**(2*(4*L**2))),C(z**(8*L**2)),C((z**8)**(L**2)),
        C(_dg_field.one()**(L**2)),C(_dg_field.one()),one))
    _gdet_rows['inverse'].append((detV*detU,detVU,detI,one))
    _gdet_rows['determinant'].append((detG,(scalar*B).det(),scalar**n*detB,one*detB,detB,
        detVT*detU,(detV*detT)*detU,detV*(detT*detU),detV*(detU*detT),
        (detV*detU)*detT,one*detT,detT,detK))
    # 置換の全列挙は L=1（四添字）で行う。高次元は上の行列式で検算する。
    if L!=1:
        continue
    identity=tuple(range(n))
    terms=[]
    for perm in permutations(range(n)):
        sign=ZZ(-1)**sum(perm[i]>perm[j] for i in range(n) for j in range(i+1,n))
        factors=[I[i,perm[i]] for i in range(n)]
        product_value=prod(factors,one)
        terms.append(C(sign)*product_value)
        if perm!=identity:
            moved=next(i for i in range(n) if perm[i]!=i)
            _gdet_rows['identity_entry'].append((I[moved,perm[moved]],zero))
            _gdet_rows['identity_product'].append((product_value,zero))
            _gdet_rows['identity_zero'].append((C(sign)*product_value,C(sign)*zero,zero))
    identity_sign=ZZ(-1)**sum(identity[i]>identity[j] for i in range(n) for j in range(i+1,n))
    weight=C(identity_sign)
    _gdet_rows['identity_weight'].append((weight,C(_dg_field.one()),one))
    _gdet_rows['identity'].append((detI,sum(terms,zero),weight*prod([I[i,identity[i]] for i in range(n)],one),
        weight*prod([one for i in range(n)],one),one*prod([one for i in range(n)],one),one*one,one))
_gdet_counts={}
def _gdet_check(group,step,name):
    rows=_gdet_rows[group]
    assert rows
    for row in rows:
        assert row[step]==row[step+1],(name,row)
    _gdet_counts[name]=len(rows)
    print('PASS %s: %d exact equations'%(name,len(rows)))
_gdet_ready=True
