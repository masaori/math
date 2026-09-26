# 038/039 共通機構: V (転送行列, セクター '-') と V' (フェルミオン exp) を
# 具体行列で構築する。numpy/scipy を使うため `sage -python <file>` で実行する。
#
# 定義対応:
#   V := (V_1^(-))^(1/2) V_2 (V_1^(-))^(1/2)   (parts/008/015 def_T_V)
#     V_1^(-) = exp(i K1 (Y_1 Z_2+...+Y_{M-1}Z_M + Y_M Z_1))  (parts/004/006, '-'セクター)
#     V_2     ∝ exp(K2* sum_k sigma^x_k)                       (前因子はTに無関係)
#   hat(Z)_mu^(-) = sum_j Z_j e^{-i j 2pi mu/M}  (parts/004/009, (minus)は全係数+1: uniform)
#   hat(Y)_mu     = sum_j Y_j e^{-i j 2pi mu/M}
#   psi (def_fermi 029):
#     psi_mu^†= (1/(2√M γ2(-θ)))( +i√(γ2(θ)γ2(-θ)) hatZ_mu^- + γ2(-θ) hatY_mu )
#     psi_mu  = (1/(2√M γ2(-θ)))( -i√(γ2(θ)γ2(-θ)) hatZ_mu^- + γ2(-θ) hatY_mu )
#   V' = exp(X), X = sum_{mu=1}^M γ(θ_mu)(psi_mu^† psi_{-mu} - 1/2 I)   (parts/008/032)
#   γ(θ)=arccosh(γ1(θ)), γ1/γ2/K2* は sagemath/_shared/defs.sage と同一。
import numpy as np
from scipy.linalg import expm
import cmath, math
sx=np.array([[0,1],[1,0]],dtype=complex); sy=np.array([[0,-1j],[1j,0]],dtype=complex)
sz=np.array([[1,0],[0,-1]],dtype=complex); id2=np.eye(2,dtype=complex)
def kron(ms):
    R=ms[0]
    for A in ms[1:]: R=np.kron(R,A)
    return R
def site(op,k,M): return kron([op if j==k else id2 for j in range(1,M+1)])
def Zm(m,M): return kron([sx if j<m else (sz if j==m else id2) for j in range(1,M+1)])
def Ym(m,M): return kron([sx if j<m else (sy if j==m else id2) for j in range(1,M+1)])
def sqrt_cc(z):
    z=complex(z)
    if z==0: return 0j
    r=abs(z); a=cmath.phase(z)
    if a<0: a+=2*math.pi
    return math.sqrt(r)*cmath.exp(1j*a/2)
def params(K1,K2):
    K2s=-math.log(math.tanh(K2))/2
    c1=math.cosh(2*K1); s1=math.sinh(2*K1); c2=math.cosh(2*K2)
    c2s=math.cosh(2*K2s); s2s=math.sinh(2*K2s)
    return K2s,(lambda th:c1*c2s-s1*s2s*math.cos(th)),(lambda th:1j*cmath.exp(1j*th)*s2s*(c1*math.cos(th)-1j*math.sin(th)-s1*c2))
def build(M,K1,K2):
    D=2**M; K2s,g1,g2=params(K1,K2); th=lambda mu:2*math.pi*mu/M
    H1=np.zeros((D,D),dtype=complex)
    for k in range(1,M): H1+=Ym(k,M)@Zm(k+1,M)
    H1+=Ym(M,M)@Zm(1,M)                       # '-' セクター: +Y_M Z_1
    V1half=expm((1j*K1)*H1/2)
    H2=sum(site(sx,k,M) for k in range(1,M+1)); V2=expm(K2s*H2)
    V=V1half@V2@V1half; Vinv=np.linalg.inv(V)
    def hatZm(mu):
        R=np.zeros((D,D),dtype=complex)
        for j in range(1,M+1): R+=Zm(j,M)*cmath.exp(-1j*j*2*math.pi*mu/M)
        return R
    def hatY(mu):
        R=np.zeros((D,D),dtype=complex)
        for j in range(1,M+1): R+=Ym(j,M)*cmath.exp(-1j*j*2*math.pi*mu/M)
        return R
    def psidag(mu):
        t=th(mu); g2m=g2(-t); g2p=g2(t); coef=1/(2*math.sqrt(M)*g2m)
        return coef*(1j*sqrt_cc(g2p*g2m)*hatZm(mu)+g2m*hatY(mu))
    def psi(mu):
        t=th(mu); g2m=g2(-t); g2p=g2(t); coef=1/(2*math.sqrt(M)*g2m)
        return coef*(-1j*sqrt_cc(g2p*g2m)*hatZm(mu)+g2m*hatY(mu))
    Imat=np.eye(D,dtype=complex); X=np.zeros((D,D),dtype=complex)
    for mu in range(1,M+1):
        gam=math.acosh(g1(th(mu)).real); X+=gam*(psidag(mu)@psi(-mu)-0.5*Imat)
    Vp=expm(X); Vpinv=expm(-X)
    return dict(M=M,D=D,V=V,Vinv=Vinv,Vp=Vp,Vpinv=Vpinv,Zm=Zm,Ym=Ym,th=th,g1=g1,psidag=psidag,Imat=Imat)
PARS=[(0.4,0.8),(1.2,0.3),(0.4407,0.4407),(0.2,0.813),(0.3,5.0)]
MS=[2,3,4]; TOL=1e-8
