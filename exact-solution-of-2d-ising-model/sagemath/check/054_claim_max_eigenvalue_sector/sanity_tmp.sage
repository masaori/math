import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)),'_prelude.sage'))

def flip_index(M, k):
    return (2 ** M - 1) - k

def sector_basis(M, sgn):
    d = 2 ** M
    cols = []
    for k in range(d):
        kb = flip_index(M, k)
        if k < kb:
            v = vector(RDF, d)
            v[k] = 1 / sqrt(RDF(2)); v[kb] = sgn / sqrt(RDF(2))
            cols.append(v)
    return matrix(RDF, cols).transpose()

def top_eig(A):
    return max([RDF(CDF(z).real()) for z in A.eigenvalues()])

for M in [2,3,4,5]:
    O = SpinOps(M)
    E = eps_op(O)
    # check epsilon is 0/1 permutation matrix
    d = 2**M
    perm_ok = all(abs(E[i,j]) < 1e-12 or abs(E[i,j]-1) < 1e-12 for i in range(d) for j in range(d))
    fl_ok = all(abs(E[flip_index(M,k), k] - 1) < 1e-12 for k in range(d))
    for p in EIG_PARAMS:
        K1 = RDF(p['K1']); K2 = RDF(p['K2']); P = coeffs(K1,K2)
        W = W_op(O,K1,K2)
        Wr = matrix(RDF, [[W[i,j].real() for j in range(d)] for i in range(d)])
        cM = top_eig(Wr); Bp = sector_basis(M,+1); Bm = sector_basis(M,-1)
        cp = top_eig(Bp.transpose()*Wr*Bp); cm = top_eig(Bm.transpose()*Wr*Bm)
        Lh = Lambda_delta_M(O,P,RDF(1)/2)
        print(M, param_label(p), "perm",perm_ok,fl_ok, "cm<=cp",bool(cm<=cp*(1+1e-12)), "c=cp", float(abs(cM-cp)/cM), "c=Lh", float(abs(cM-Lh)/cM))
