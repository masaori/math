# 対象ラベル: claim_gauged_terminal_matrix_skew
import os, glob, sys
_sk_here=os.path.dirname(os.path.abspath(__file__))
if not os.path.isfile(os.path.join(_sk_here, '_prelude.sage')):
    _sk_here=os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(_sk_here,'_prelude.sage'))
for filename in sorted(glob.glob(os.path.join(_sk_here,'check_*.sage'))):
    load(filename)
for root_power in (1,3,5,7):
    z=_dg_primitive_root**root_power
    table=((0,z**(-1),1,z),(z,0,z**(-1),1),(1,z,0,z**(-1)),(z**(-1),1,z,0))
    for r,t in product(range(4),repeat=2):
        R=_sk_phase(z,(r+2)%4,t)
        assert R==table[r][t]
        expected=0 if r==t else z**(-2-r+t) if r<t else z**(2-r+t)
        assert R==expected
        assert _sk_sigma(r,t)==-_sk_sigma(t,r)
overlap=0
for c in _sk_cases:
    K=c['transformed'];n=c['n']
    assert K==-K.transpose()
    assert all(K[i,i]==0 for i in range(n))
    assert c['ell']==-c['ell'].transpose()
    assert c['q']==-c['q'].transpose()
    for i in range(n):
        r=c['directions'][i];j=c['rev'][i]
        assert c['parities'][j]==c['parities'][i]
        assert c['directions'][j]==(r+2)%4
        assert 2+r-c['directions'][j]==(0 if r<2 else 4)
        if c['cond'][i,j]:
            overlap+=1
            assert c['L']==1
assert overlap==64
print('PASS integrated: 48 exact matrices, 25088 entries, 64 overlapping conditions at L=1')
print('PASS line total: %d files, %d equations'%(len(_sk_counts),sum(_sk_counts.values())))
print('PASS auxiliary total: %d files, %d comparisons'%(len(_sk_aux_counts),sum(_sk_aux_counts.values())))
