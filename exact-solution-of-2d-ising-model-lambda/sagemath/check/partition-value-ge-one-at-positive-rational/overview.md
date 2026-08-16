# SageMath Check: 正の有理点での分配多項式の値は 1 以上である

## 対象

**対象ラベル**: `claim_partition_value_ge_one_at_positive_rational`

準備として次も検査する（$\sigma_+$ が配位の全列挙に含まれること、$b(\sigma_+)=0$）。

- `def_constant_plus_configuration`
- `claim_constant_plus_breaks_no_bond`

- 実行日: 2026-08-16
- 状態: PASS（$L\in\{1,2,3,4\}$、正の有理点 9 点。準備の各項の正値性 594594 件、式変形の各行と $1\le Z_L(q)$ 252 件、合計 594846 件）
- 帰属: `ZZ`/`QQ` の厳密計算。浮動小数点・ball 算術は使わない（主張は $\mathbb Q$ で閉じている）。

## 検査内容

$L\in\{1,2,3,4\}$ と正の有理数 $q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ について、

- 準備: 各配位 $\sigma\in\Sigma_L$ で $b(\sigma)\in\mathbb N$、$0<q^{b(\sigma)}$（$\mathbb Q$ の厳密比較）、$b(\sigma)=0$ なら $q^0=1$。
- 式変形の各行: $1=q^0$、$q^0=q^{b(\sigma_+)}$（$b(\sigma_+)=0$）、$q^{b(\sigma_+)}\le q^{b(\sigma_+)}+\sum_{\sigma\ne\sigma_+}q^{b(\sigma)}$
  （加えた和が $0$ 以上）、分離した 1 項を有限和へ戻す等式、$\sum_\sigma q^{b(\sigma)}=Z_L(q)$（全配位から組んだ分配多項式への代入）、
  そして主張 $1\le Z_L(q)$。$q=1$ では $Z_L(1)=2^{L^2}$ との整合も見る。

有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/partition-value-ge-one-at-positive-rational/check.sage
```
