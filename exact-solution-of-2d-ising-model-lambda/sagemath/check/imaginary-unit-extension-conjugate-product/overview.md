# SageMath Check: 虚数単位を足した体を係数とする多項式と係数の共役の積

## 対象

**対象ラベル**: `def_imaginary_unit_extension_conjugate`, `def_imaginary_unit_extension_conjugate_polynomial`, `claim_imaginary_unit_extension_conjugate_product_subfield_coefficient`

- 実行日: 2026-11-20
- 結果: 全検査通過（PASS 560）
- 帰属: 式鎖の恒等式は整係数多項式環 `ZZ[a_0,…,a_n,b_0,…,b_n,w]`、標本は `QQbar` の厳密な元と数体 `QQ(√2)`。浮動小数点は使わない。
- 標本: $F=\mathbb{Q}(\sqrt2)$（$\overline{\mathbb{Q}}$ の実の正の元が正錐を与える）、$\omega=i$。係数は $F$ の元六つの対から作り、次数四以下の多項式四十個を調べる。

## 何を確かめるか

- $n\le6$、$0\le k\le n$ の全てで、式鎖の各等号: 各項 $(a_i+b_i\omega)(a_{k-i}-b_{k-i}\omega)$ を $(a_ia_{k-i}+b_ib_{k-i})+(b_ia_{k-i}-a_ib_{k-i})\omega$ へ移す段（差が $\omega\omega+1$ の倍数であること）、有限和の分配、積の交換法則、番号の付け替え $i\mapsto k-i$、最後の四則。
- 共役の定義: 標本の対 $(u,v)$ の表示 $u+v\omega$ が値ごとに一つだけで、$\mathrm{cj}_\omega$ が値だけで決まること。$\mathrm{cj}_\omega(0)=0$。
- 標本の多項式 $g$ で、$g\cdot\mathrm{cjp}_\omega(g)$ の各係数が式鎖の最後の行 $\sum_i(a_ia_{k-i}+b_ib_{k-i})$ に一致し、$F$ に属すること。
- 係数の共役を取らない積 $g\cdot g$ は一般に $F$ 係数でない例（$g=(1+i)t+1$）。主張を弱めていないことの確認。

有限個の標本と有限個の $n$ の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
