# SageMath Check: 奇数次の多項式は部分体上の次数が奇数の根を持つ

## 対象

**対象ラベル**: `claim_qbar_poly_product_top_coefficient`, `claim_odd_degree_polynomial_has_odd_degree_root`

- 実行日: 2026-11-18
- 結果: 全検査通過（PASS 540。$F=\mathbb Q$ と $F=\mathbb Q(s)$（$s\cdot s=2$）。積の係数 300 件、主張 240 件。主張のうち、$d$ が偶数で帰納法の仮定を当てた段は 173 回）
- 帰属: $\mathbb Q$・数体 $\mathbb Q(s)$ とその上の多項式環の厳密計算。$F=\mathbb Q$ の場合は根を `QQbar` の元として取り、値が零であることも `QQbar` で判定する。浮動小数点は使わない。
- 読み替え: 根 $\beta$ は $f$ の $F$ 上の既約因子 $p$（最高次の係数を 1 にしたもの）で表し、$\deg_F(\beta)$ を $p$ の次数として読む。最小次数の零化多項式が既約因子の定数倍であることはこの検査の前提であり、本文はこれを使わない（本文は $\deg_F(\beta)$ の定義と整除だけを使う）。

## 何を確かめるか

本文の証明の段を、行ごとに次で確かめる。普遍量化された主張の証明ではない。

- 積の係数: 係数の上界 $a$, $b$、積の係数の和、$i\ne a$ の項が零であること、番号 $a$ の項を分けた和、$\mathrm{ac}_{a+b}(f\cdot g)=\mathrm{ac}_a(f)\cdot\mathrm{ac}_b(g)$。
- 主張: 証明の強い帰納法を手続きにして、各段で次を確かめる。主張の仮定、$\mathrm{aev}_\beta(f)=0$、$\mathrm{ac}_d(p)\ne0$、$d\ge1$、$f=u\cdot p$、$u\ne0$、$e$ の取り方、$\mathrm{ac}_{e+d}(f)=\mathrm{ac}_e(u)\cdot\mathrm{ac}_d(p)\ne0$、$k>e+d$ で係数が零、$e+d=n$、$d$ が偶数の場合の $e$ の鎖と $e<n$、帰納法で得た $\gamma$ について $\mathrm{aev}_\gamma(f)=\mathrm{aev}_\gamma(u)\cdot\mathrm{aev}_\gamma(p)=0$ と $\deg_F(\gamma)\le e$。根に取る既約因子は無作為に選び、偶数次の既約因子を多めに含めて $d$ が偶数の段を通す。

## 実行方法

```sh
sage check.sage
```
