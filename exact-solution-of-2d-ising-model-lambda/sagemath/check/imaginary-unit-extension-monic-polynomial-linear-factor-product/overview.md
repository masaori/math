# SageMath Check: 虚数単位を足した体を係数とする最高次の係数が一の多項式は、その体の元を根とする一次因子の積である

## 対象

**対象ラベル**: `claim_imaginary_unit_extension_monic_polynomial_linear_factor_product`

- 実行日: 2026-11-21
- 結果: 全検査通過（PASS 231）
- 帰属: 標本は `QQbar` の厳密な元と `QQbar[t]` の多項式。浮動小数点は使わない。
- 標本の部分体は二つ。
  - $F=$ 実代数的数の全体（`AA`）。正の元は平方で、奇数次の多項式は根を持つので主張の仮定を満たす。$\omega=i$、$\mathrm{Lin}_F(\omega)=\overline{\mathbb{Q}}$。番号 $d$ の係数が 1 の多項式四つ（$d=0,\dots,3$、係数に虚部を持つもの）。根は元の多項式の根を一度だけ取り、各段でその中から選ぶ（本文の根の存在の代わり）。
  - $F=\mathbb{Q}(\sqrt2)$。主張の仮定は満たさないが、一歩の (二)〜(五) は根 $w\in\mathrm{Lin}_F(\omega)$ が与えられれば仮定を使わないので、$\mathrm{Lin}_F(\omega)$ の元の一次因子の積として作った四つ（$d=1,\dots,4$、重根を含む）で、商の係数と根の所属を自明でない所属判定で確かめる。

## 何を確かめるか

本文の帰納法を再帰としてそのまま実行し、各段で次を確かめる。

- 仮定: 係数が $\mathrm{Lin}_F(\omega)$、$k>d$ で係数が零、番号 $d$ の係数が 1。
- 出発点 $d=0$: $g=1=$ 空積、$0\in\mathrm{Lin}_F(\omega)$。
- 一歩 (一) 根 $w\in\mathrm{Lin}_F(\omega)$ で $\mathrm{aev}_w(g)=0$。
- 一歩 (二) 商 $q=\sum_{k\le d}\widehat{\mathrm{ac}_k(g)}K_k(w)$ で $g=(t-\widehat w)q$。
- 一歩 (三) $q$ の係数が $\mathrm{Lin}_F(\omega)$。
- 一歩 (四) 番号 $d$（一歩の $d+1$）以上で $q$ の係数が零。
- 一歩 (五) $\mathrm{ac}_{d-1}(q)=\mathrm{ac}_d((t-\widehat w)q)=\mathrm{ac}_d(g)=1$。
- 帰納法の仮定 $q=\prod(t-\widehat{\alpha'(i)})$、$\alpha$ の値が全て $\mathrm{Lin}_F(\omega)$、結論の五行の式鎖、因子の個数が $d$。
- 所属判定が自明でないこと（$\sqrt3\notin\mathrm{Lin}_{\mathbb{Q}(\sqrt2)}(i)$）。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
