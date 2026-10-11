# 帰属: 円分体 Q(zeta_8)[x]。浮動小数点と変数への代入を使わない。
from itertools import permutations
from functools import lru_cache

qdf_K = CyclotomicField(8)
qdf_zeta = qdf_K.gen()
qdf_R = PolynomialRing(qdf_K, 'x')
qdf_x = qdf_R.gen()

@lru_cache(maxsize=None)
def qdf_permutations(n):
    return tuple(permutations(range(n)))

def qdf_free(sigma):
    return all(sigma[i] != i for i in range(len(sigma)))

def qdf_weight(sigma):
    inversions = sum(1 for i in range(len(sigma)) for j in range(i+1,len(sigma))
                     if sigma[j] < sigma[i])
    return qdf_R((-1)**inversions)

def qdf_product(A,sigma,omit=None):
    return prod((A[i,sigma[i]] for i in range(A.nrows()) if i != omit), qdf_R.one())

def qdf_term(A,sigma):
    return qdf_weight(sigma)*qdf_product(A,sigma)

def qdf_inputs(zero_diagonal):
    for n in range(7):
        for family in range(5):
            def entry(i,j):
                if family == 0:
                    return qdf_R.zero()
                if family == 1:
                    return qdf_R((1+qdf_x if i==j else 0) + (i+1)*(j+2)
                        + qdf_zeta**((2*i+j)%8)*qdf_x + ((i+j)%3)*qdf_x**2)
                if family == 2:
                    def upper(a,b):
                        return qdf_R(a+b+1+qdf_zeta**((a+2*b)%8)*qdf_x+qdf_x**2)
                    return (upper(i,j) if i<j else -upper(j,i) if j<i
                            else qdf_R(i+1+qdf_zeta*qdf_x))
                if family == 3:
                    return qdf_R((1+qdf_zeta*qdf_x+i if j==(i+1)%n else 0)
                                 +(1+(i+1)*qdf_x if i==j else 0))
                return qdf_R((j+1+qdf_zeta*qdf_x if i<j else 0)
                             +(1+(i+1)*qdf_x if i==j else 0))
            A=matrix(qdf_R,n,n,lambda i,j: 0 if zero_diagonal and i==j else entry(i,j))
            assert A.base_ring() is qdf_R
            if zero_diagonal:
                assert all(A[i,i]==0 for i in range(n))
            yield n,family,A

def qdf_total(A,keep=lambda sigma: True):
    return sum((qdf_term(A,sigma) for sigma in qdf_permutations(A.nrows()) if keep(sigma)),
               qdf_R.zero())

def qdf_fixed_cases(zero_diagonal):
    for n,family,A in qdf_inputs(zero_diagonal):
        for sigma in qdf_permutations(n):
            for j in range(n):
                if sigma[j]==j:
                    yield A,sigma,j

def qdf_report(name,count,expected):
    assert count==expected, (name,count,expected)
    print(name+" PASS "+str(count))
