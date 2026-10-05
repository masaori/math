import os
from functools import lru_cache
load('sagemath/_shared/defs.sage')
load('sagemath/check/diagonal-gauge-inverse/construction.sage')
_sk_ring = PolynomialRing(_dg_field, 'x')
_sk_x = _sk_ring.gen()

def _sk_src(L, e):
    return endpoints(L, e[0])[e[1]]

def _sk_tgt(L, e):
    return endpoints(L, e[0])[1-e[1]]

def _sk_phase(z, r, t):
    return {0: _dg_field(1), 1: z, 3: z**(-1)}.get((t-r)%4, _dg_field(0))

def _sk_twist(L, a, b, e):
    horizontal = e[0] <= L*L
    n = e[0]-1 if horizontal else e[0]-L*L-1
    row, col = divmod(n,L)
    return ZZ(-1)**(a*ZZ(horizontal and col==L-1)+b*ZZ(not horizontal and row==L-1))

_sk_cases=[]
for L in (1,2,3):
    for a,b in product((0,1),repeat=2):
        for root_power in (1,3,5,7):
            c=diagonal_gauge_case(L,a,b,root_power)
            edges,z,dirs=c['edges'],c['z'],c['directions']
            n=len(edges)
            rev=[edges.index((e[0],1-e[1])) for e in edges]
            eps=[_dg_field(_sk_twist(L,a,b,e)) for e in edges]
            M=matrix(_dg_field,n,lambda i,j: eps[j]*_sk_phase(z,dirs[i],dirs[j])
                if _sk_tgt(L,edges[i])==_sk_src(L,edges[j]) and j!=rev[i] else 0)
            J=matrix(_sk_ring,n,lambda i,j: ZZ(j==rev[i]))
            K=identity_matrix(_sk_ring,n)-_sk_x*M.change_ring(_sk_ring)
            transformed=_sk_ring(z**2)*(c['V'].change_ring(_sk_ring)*(J*K))*c['U'].change_ring(_sk_ring)
            weights=matrix(_dg_field,n,lambda i,j:z**2*(c['vs'][i]*c['us'][j]))
            phases=matrix(_dg_field,n,lambda i,j:_sk_phase(z,(dirs[i]+2)%4,dirs[j]))
            delta=matrix(_sk_ring,n,lambda i,j:ZZ(j==rev[i]))
            cond=matrix(ZZ,n,lambda i,j:ZZ(_sk_src(L,edges[i])==_sk_src(L,edges[j]) and i!=j))
            coeff=matrix(_dg_field,n,lambda i,j:weights[i,j]*(eps[j]*phases[i,j]))
            ell=matrix(_dg_field,n,lambda i,j:weights[i,j] if j==rev[i] else 0)
            q=matrix(_dg_field,n,lambda i,j:coeff[i,j] if cond[i,j] else 0)
            beta=matrix(_sk_ring,n,lambda i,j:_sk_ring(eps[j]*phases[i,j]) if cond[i,j] else 0)
            c.update(n=n,rev=rev,eps=eps,transformed=transformed,weights=weights,phases=phases,
                delta=delta,cond=cond,coeff=coeff,ell=ell,q=q,beta=beta)
            _sk_cases.append(c)

def _sk_sigma(r,t):
    return _dg_field(1 if r<t else -1 if r>t else 0)

@lru_cache(None)
def _sk_rows(group):
    out=[]
    if group in ('phase_equal','phase_upper','phase_lower'):
        for root_power in (1,3,5,7):
            z=_dg_primitive_root**root_power
            for r,t in product(range(4),repeat=2):
                R=_sk_phase(z,(r+2)%4,t)
                v=z**(2+r-t)*R
                if group=='phase_equal' and r==t:
                    out.append((v,z**(2+r-t)*0,_dg_field(0)))
                if group=='phase_upper' and r<t:
                    out.append((v,z**(2+r-t)*z**(-2-r+t),z**((2+r-t)+(-2-r+t)),z**0,_dg_field(1)))
                if group=='phase_lower' and r>t:
                    out.append((v,z**(2+r-t)*z**(2-r+t),z**((2+r-t)+(2-r+t)),z**4,_dg_field(-1)))
        return tuple(out)
    for c in _sk_cases:
        z,n=c['z'],c['n']
        C,x=_sk_ring,_sk_x
        indices=((i,i) for i in range(n)) if group in ('sign','reversal','diagonal') else product(range(n),repeat=2)
        for i,j in indices:
            r,t,k,l=c['directions'][i],c['directions'][j],c['parities'][i],c['parities'][j]
            w,h=c['weights'][i,j],c['eps'][j]*c['phases'][i,j]
            R=c['phases'][i,j]
            d=c['coeff'][i,j]
            ell,q=c['ell'][i,j],c['q'][i,j]
            delta,beta=c['delta'][i,j],c['beta'][i,j]
            if group=='weight':
                rows=(w,z**2*((z**(2*k)*z**r)*(z**(-t)*z**(-2*l))),
                    z**2*(z**(2*k+r)*(z**(-t)*z**(-2*l))),z**2*(z**(2*k+r)*z**(-t-2*l)),
                    z**2*z**((2*k+r)+(-t-2*l)),z**(2+((2*k+r)+(-t-2*l))),z**(2+r-t+2*k-2*l))
            elif group=='sign':
                rows=(c['eps'][i],_dg_field(ZZ(-1)**k),_dg_field(-1)**k,(z**4)**k,z**(4*k))
            elif group=='reversal':
                hrev=c['rev'][i];tr=c['directions'][hrev];lr=c['parities'][hrev]
                rows=(c['weights'][i,hrev],z**(2+r-tr+2*k-2*lr),z**(2+r-tr+2*k-2*k),
                    z**(2+r-tr),z**(0 if r<2 else 4),_dg_field(1 if r<2 else -1))
            elif group=='short_value':
                A=2+r-t+2*k-2*l
                rows=(d,z**A*(c['eps'][j]*R),z**A*(z**(4*l)*R),(z**A*z**(4*l))*R,
                    z**(A+4*l)*R,z**((2+r-t)+2*(k+l))*R,(z**(2+r-t)*z**(2*(k+l)))*R,
                    z**(2+r-t)*(z**(2*(k+l))*R),z**(2+r-t)*(R*z**(2*(k+l))),
                    (z**(2+r-t)*R)*z**(2*(k+l)),_sk_sigma(r,t)*z**(2*(k+l)))
            elif group=='short_swap':
                rows=(d,_sk_sigma(r,t)*z**(2*(k+l)),(-_sk_sigma(t,r))*z**(2*(k+l)),
                    -(_sk_sigma(t,r)*z**(2*(k+l))),-(_sk_sigma(t,r)*z**(2*(l+k))),-c['coeff'][j,i])
            elif group=='long_true':
                if j!=c['rev'][i]: continue
                rows=(C(w)*delta,C(w)*C.one(),C(w),C(ell))
            elif group=='long_false':
                if j==c['rev'][i]: continue
                rows=(C(w)*delta,C(w)*C.zero(),C.zero(),C(_dg_field(0)),C(ell))
            elif group=='short_true':
                if not c['cond'][i,j]: continue
                rows=(C(w)*beta,C(w)*C(h),C(w*h),C(q))
            elif group=='short_false':
                if c['cond'][i,j]: continue
                rows=(C(w)*beta,C(w)*C.zero(),C.zero(),C(_dg_field(0)),C(q))
            elif group=='entry':
                rows=(c['transformed'][i,j],C(w)*(delta-x*beta),C(w)*delta-C(w)*(x*beta),
                    C(w)*delta-(C(w)*x)*beta,C(w)*delta-(x*C(w))*beta,
                    C(w)*delta-x*(C(w)*beta),C(ell)-x*(C(w)*beta),C(ell)-x*C(q))
            elif group=='skew':
                er,qr=c['ell'][j,i],c['q'][j,i]
                rows=(c['transformed'][i,j],C(ell)-x*C(q),C(-er)-x*C(q),C(-er)-x*C(-qr),
                    -C(er)-x*C(-qr),-C(er)-x*(-C(qr)),-C(er)-(-(x*C(qr))),
                    -C(er)+(-(-(x*C(qr)))),-(C(er)+(-(x*C(qr)))),
                    -(C(er)-x*C(qr)),-c['transformed'][j,i])
            elif group=='diagonal':
                rows=(c['transformed'][i,i],C(w)*(delta-x*beta),C(w)*(C.zero()-x*beta),
                    C(w)*(C.zero()-x*C.zero()),C(w)*(C.zero()-C.zero()),C(w)*C.zero(),C.zero())
            else:
                raise ValueError(group)
            out.append(rows)
    return tuple(out)

_sk_counts={}
def _sk_check(group,step,name):
    rows=_sk_rows(group)
    for row in rows:
        assert row[step]==row[step+1],(group,step,row)
    assert rows
    _sk_counts[name]=len(rows)
    print('PASS %s: %d equations'%(name,len(rows)))

_sk_aux_counts={}
def _sk_check_aux(name):
    checked=0
    if name in ('phase_formula','direction_sign_swap'):
        for root_power in (1,3,5,7):
            z=_dg_primitive_root**root_power
            for r,t in product(range(4),repeat=2):
                if name=='phase_formula':
                    actual=_sk_phase(z,(r+2)%4,t)
                    expected=0 if r==t else z**(-2-r+t) if r<t else z**(2-r+t)
                else:
                    actual,expected=_sk_sigma(r,t),-_sk_sigma(t,r)
                assert actual==expected,(name,r,t,root_power)
                checked+=1
    else:
        for c in _sk_cases:
            n=c['n'];dirs=c['directions'];rev=c['rev']
            indices=((i,i) for i in range(n)) if name in ('reversal_parity','reversal_direction','reversal_exponent') else product(range(n),repeat=2)
            for i,j in indices:
                if name=='reversal_parity':
                    actual,expected=c['parities'][rev[i]],c['parities'][i]
                elif name=='reversal_direction':
                    actual,expected=dirs[rev[i]],(dirs[i]+2)%4
                elif name=='reversal_exponent':
                    actual,expected=2+dirs[i]-dirs[rev[i]],0 if dirs[i]<2 else 4
                elif name=='phase_agreement':
                    actual,expected=_sk_phase(c['z'],dirs[rev[i]],dirs[j]),c['phases'][i,j]
                elif name=='long_condition':
                    actual,expected=j==rev[i],i==rev[j]
                elif name=='long_coefficient_skew':
                    actual,expected=c['ell'][i,j],-c['ell'][j,i]
                elif name=='short_condition':
                    actual,expected=c['cond'][i,j],c['cond'][j,i]
                elif name=='short_coefficient_skew':
                    actual,expected=c['q'][i,j],-c['q'][j,i]
                else:
                    raise ValueError(name)
                assert actual==expected,(name,c['L'],c['a'],c['b'],c['root_power'],i,j)
                checked+=1
    assert checked
    _sk_aux_counts[name]=checked
    print('PASS %s: %d comparisons'%(name,checked))
