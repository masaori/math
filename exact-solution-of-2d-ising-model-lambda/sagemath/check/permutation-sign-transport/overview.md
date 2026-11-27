# SageMath Check: 全単射で移した置換の符号

**対象ラベル**: `claim_permutation_sign_transport`

$\mathcal J=\{0,\dots,n-1\}$ に任意の線型順序、$\mathcal K=\{0,\dots,n-1\}$ に標準順序を置き、全単射 $d$ と置換 $\sigma$ を走査した
（$n=0,\dots,4$ は $\mathcal J$ の順序を全て、$n=5$ は二つの順序）。証明の各段を整数上で検査した。

- $\Pi_d:P_{\mathcal J}\to P_{\mathcal K}$ と $\Pi_\sigma:P_{\mathcal J}\to P_{\mathcal J}$ が全単射であること、$\Pi_{d^{-1}}\circ\Pi_d=\mathrm{id}$
- $|C|=\mathrm{inv}_{\mathcal K}(\tau)$、$|A|=\mathrm{inv}_{\mathcal J}(\sigma)$、$|B'|=|B|$
- 各対で $A,B,B',C$ に属するものの個数が偶数であること
- 結論 $\operatorname{sgn}_{\mathcal K}(d\circ\sigma\circ d^{-1})=\operatorname{sgn}_{\mathcal J}(\sigma)$

- 実行: `sage sagemath/check/permutation-sign-transport/check.sage`
- 状態: PASS（2026-11-27、$42850$ 組の $(d,\sigma)$）
- 浮動小数点: 不使用
