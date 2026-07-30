import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))
for (M,K1v,K2v) in [(2,0.4,0.8),(3,0.4,0.8),(4,0.4,0.8),(3,0.7,0.3),(4,0.7,0.3),(5,0.4,0.8)]:
    O=SpinOps(M); W=W_matrix(O,K1v,K2v); Pp,Pm=projectors(O)
    cp=rayleigh_sup(to_real(Pp*W*Pp)); cm=rayleigh_sup(to_real(Pm*W*Pm))
    g=gamma_fn(K1v,K2v); s2=RDF(sinh(2*RDF(K2v))); pref=RDF((2*s2)**(RDF(M)/2))
    def Lam(delta):
        return RDF(pref*exp(sum(g(th)/2 for th in theta_family(M,delta))))
    Vp=V_sym(O,K1v,K2v,1); Vm=V_sym(O,K1v,K2v,-1)
    evp=sorted([RDF(CDF(z).real()) for z in Vp.eigenvalues()])
    evm=sorted([RDF(CDF(z).real()) for z in Vm.eigenvalues()])
    print(f"M={M} K1={K1v} K2={K2v}")
    print(f"   c+={cp:.10f}  Lam(1/2)={Lam(RDF(1)/2):.10f}  maxEV(V+)={evp[-1]:.10f}")
    print(f"   c-={cm:.10f}  Lam(0)  ={Lam(RDF(0)):.10f}  maxEV(V-)={evm[-1]:.10f}")
