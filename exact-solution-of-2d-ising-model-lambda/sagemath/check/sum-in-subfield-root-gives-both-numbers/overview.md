# SageMath Check: 和が部分体に入る二数と部分体の根

## 対象

**対象ラベル**: `claim_sum_in_subfield_root_gives_both_numbers`

- 実行日: 2026-11-20
- 結果: 全検査通過（PASS 332）
- 帰属: 式鎖の恒等式は整係数多項式環 `ZZ[a,b,g]`、標本は `QQbar` の厳密な元と数体 $\mathbb{Q}(\sqrt2)$。浮動小数点は使わない。
- 標本: $K=\mathbb{Q}(\sqrt2)$。$K$ の元五つから $\alpha,\beta$ を取り、$\gamma$ を $\alpha$・$\beta$・$K$ の元五つとして、二次式の値が零になる組だけを調べる。

## 何を確かめるか

- 式鎖 $(\gamma-\alpha)(\gamma-\beta)=\dots=\gamma\gamma-(\alpha+\beta)\gamma+\alpha\beta$ の三つの等号（可換な三変数の整係数多項式の恒等式）。
- 二つの場合の四則の等号（$\alpha=\gamma-(\gamma-\alpha)$、$\beta=(\alpha+\beta)-\alpha$ と、その $\alpha,\beta$ を入れ替えたもの）。
- 標本で、$(\gamma-\alpha)(\gamma-\beta)=0$、$\gamma-\alpha=0$ なら $\alpha=\gamma$、そうでなければ $\gamma-\beta=0$ かつ $\beta=\gamma$、結論 $\alpha,\beta\in K$。両方の場合が標本に現れること。
- 仮定 $\gamma\in K$ を外すと結論が成り立たない例（$\alpha=\sqrt3$、$\beta=-\sqrt3$ は $\alpha+\beta\in K$ だが $\alpha\notin K$）。主張を弱めていないことの確認。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
