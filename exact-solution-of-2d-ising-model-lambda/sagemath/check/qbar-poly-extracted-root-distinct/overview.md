# SageMath Check: 取り出した分解の残りの因子の根は、取り出した因子の根と相異なる

**対象ラベル**: `claim_qbar_poly_extracted_root_distinct`

本文の背理法に対応させ、$f=t^{\,n}+\widehat{-1}$ と $\mu_n$ の各根 $w$ について
分解 $f=(t-w)h$ を作り、仮定（$h$ の係数の上界・分解の等式）、鎖の第 2 段
（評価が積を保つこと $h(w)=A(w)g(w)$）、非零性 $h(w)\ne0$、および $h=Ag$ の
分け方を変えたすべての場合で $g$ の各根 $w'$ が $g(w')=0$ かつ $w'\ne w$ を
満たすことを `QQbar` の厳密計算で確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/qbar-poly-extracted-root-distinct/check.sage
```

**2026-08-12 実行: すべて通過。**
