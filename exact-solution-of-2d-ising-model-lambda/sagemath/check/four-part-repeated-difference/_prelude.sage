# 対象ラベル: claim_four_part_repeated_difference
# 帰属: ZZ^2 と ZZ。有限列を独立に連結して各中間式を評価する。
from itertools import product

def turn(a, b):
    return ZZ(a[1])*ZZ(b[0])-ZZ(a[0])*ZZ(b[1])

def internal(word):
    return sum((turn(a,b) for a,b in zip(word, word[1:])), ZZ(0))

def cyclic(word):
    return internal(word)+turn(word[-1],word[0])

def evaluate(u,v,r,x,c):
    uc, rc = u*c, r*c
    un, rn = u*(c+1), r*(c+1)
    z, zn = uc+v+rc+x, un+v+rn+x
    joints = [
        turn(uc[-1],v[0])+turn(v[-1],rc[0])+turn(rc[-1],x[0])+turn(x[-1],uc[0]),
        turn(u[-1],v[0])+turn(v[-1],rc[0])+turn(rc[-1],x[0])+turn(x[-1],uc[0]),
        turn(u[-1],v[0])+turn(v[-1],r[0])+turn(rc[-1],x[0])+turn(x[-1],uc[0]),
        turn(u[-1],v[0])+turn(v[-1],r[0])+turn(r[-1],x[0])+turn(x[-1],uc[0]),
        turn(u[-1],v[0])+turn(v[-1],r[0])+turn(r[-1],x[0])+turn(x[-1],u[0])]
    fixed = sum((turn(a,b) for a,b in ((u[-1],v[0]),(v[-1],r[0]),
                                     (r[-1],x[0]),(x[-1],u[0]))),ZZ(0))
    a,b = internal(uc),internal(rc)
    an,bn = internal(un),internal(rn)
    k = internal(v)+internal(x)+fixed
    split = a+turn(uc[-1],v[0])+internal(v)+turn(v[-1],rc[0])+b+turn(rc[-1],x[0])+internal(x)+turn(x[-1],uc[0])
    grouped = a+internal(v)+b+internal(x)+(turn(uc[-1],v[0])+turn(v[-1],rc[0])+turn(rc[-1],x[0])+turn(x[-1],uc[0]))
    stages = [cyclic(z),split,grouped,a+internal(v)+b+internal(x)+joints[0],
              a+internal(v)+b+internal(x)+fixed,a+b+k]
    differences = [cyclic(zn)-cyclic(z),(an+bn+k)-cyclic(z),
                   (an+bn+k)-(a+b+k),(an-a)+(bn-b),cyclic(u)+(bn-b),
                   cyclic(u)+cyclic(r)]
    direct = sum((turn(zn[j],zn[(j+1)%len(zn)]) for j in range(len(zn))),ZZ(0))-sum((turn(z[j],z[(j+1)%len(z)]) for j in range(len(z))),ZZ(0))
    return {'ends':[(uc[0],u[0]),(uc[-1],u[-1]),(rc[0],r[0]),(rc[-1],r[-1])],
            'joints':joints+[fixed],'stages':stages,'differences':differences,
            'direct':direct,'target':cyclic(u)+cyclic(r)}

if '_four_part_repeat_cases' not in globals():
    alphabet = ((1,0),(0,1),(-1,-1))
    words = [tuple(w) for n in (1,2) for w in product(alphabet,repeat=n)]
    _four_part_repeat_cases = [evaluate(u,v,r,x,c)
                              for u,v,r,x in product(words,repeat=4) for c in (1,2,3)]
    # 長さ一の空内部和に加え、長さの不一致と非単位ベクトルも含める。
    for m,b,n,d in product((1,3,4),repeat=4):
        for c in (1,2,5):
            u=tuple((j-2,2*j+1) for j in range(m))
            v=tuple((2-j,j*j-1) for j in range(b))
            r=tuple((1-3*j,j-1) for j in range(n))
            x=tuple((j*j,-2*j-1) for j in range(d))
            _four_part_repeat_cases.append(evaluate(u,v,r,x,c))
