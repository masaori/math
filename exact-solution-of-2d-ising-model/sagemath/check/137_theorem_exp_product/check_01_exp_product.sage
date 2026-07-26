# <theorem_exp_product>: AB = BA なら exp(A)exp(B) = exp(A+B)。可換性が本質的であることも確認。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rng = np.random.default_rng(int(107))
rep = CheckReport("theorem_exp_product")
noncomm_broken = 0
for n in [2,3,5]:
    # 可換な組: 同じ行列の多項式
    for _ in range(10):
        X = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        # X の多項式は可換だが、正規化しないと成分が 1e3 規模になり exp が 1e10 を超えて
        # 倍精度の相対誤差が 1e-9 を割る。指数の肩を穏当な大きさに保つ。
        X = X/np.sqrt(np.sum(np.abs(X)**2))*0.8
        A = X @ X + 0.3*X
        B = 2.1*X - 0.7*(X @ X @ X)
        rep.close(comm(A,B), np.zeros((n,n)), f"n={n}: A,B は可換")
        rep.close(_expm(A) @ _expm(B), _expm(A+B), f"n={n}: exp A exp B = exp(A+B)")
    # 対角行列どうしも可換
    for _ in range(5):
        A = np.diag(0.7*(rng.normal(size=n) + 1j*rng.normal(size=n)))
        B = np.diag(0.7*(rng.normal(size=n) + 1j*rng.normal(size=n)))
        rep.close(_expm(A) @ _expm(B), _expm(A+B), f"n={n}: 対角行列で成立")
    # 非可換だと破れる
    for _ in range(10):
        A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        B = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        if np.max(np.abs(comm(A,B))) < 1e-8:
            continue
        if np.max(np.abs(_expm(A) @ _expm(B) - _expm(A+B))) > 1e-6:
            noncomm_broken += 1
print(f"  非可換な組で等式が破れた事例: {noncomm_broken} 件（可換性の仮定が本質的）")
rep.truth(noncomm_broken > 0, "非可換だと破れる（仮定の必要性）")
rep.finish()
