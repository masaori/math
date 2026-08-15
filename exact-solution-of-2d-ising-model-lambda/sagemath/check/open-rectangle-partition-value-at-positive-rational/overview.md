# SageMath Check: 開境界長方形の分配多項式の正の有理点での値とその正値性

## 対象

**対象ラベル**: `def_open_rectangle_partition_value_at_positive_rational` `claim_open_rectangle_value_at_rational_is_positive`

- 実行日: 2026-08-16
- 状態: PASS（長方形 10 形 $(a,b)\in\{(1,1),(1,2),(2,1),(2,2),(2,3),(3,2),(3,3),(1,4),(4,1),(3,4)\}$、正の有理点 9 点。合計 43446 件）
- 帰属: `ZZ`/`QQ` の厳密計算。浮動小数点・ball 算術は使わない（定義と主張は $\mathbb Q$ で閉じている）。

## 検査内容

各形 $(a,b)$ と正の有理数 $q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ について、

- 準備: $|\Sigma^{\mathrm{op}}_{a,b}|=2^{ab}\ge1$、各配位 $\sigma$ で $b^{\mathrm{op}}_{a,b}(\sigma)\in\mathbb N$、$0<q^{b^{\mathrm{op}}_{a,b}(\sigma)}$（$\mathbb Q$ の厳密比較）、$b^{\mathrm{op}}_{a,b}(\sigma)=0$ なら $q^0=1$。
- 定義: $Z^{\mathrm{op}}_{a,b}(q)$ は $\mathbb Z[x]$ の分配多項式への $q$ の代入であり、$\mathbb Q$ の元。二つ目の等号 $Z^{\mathrm{op}}_{a,b}(q)=\sum_\sigma q^{b^{\mathrm{op}}_{a,b}(\sigma)}$（代入は和と冪を保つ）。
- 主張: $Z^{\mathrm{op}}_{a,b}(q)\in\mathbb Q_{>0}$（正の有理数を 1 個以上足したものは正）。$q=1$ では $Z^{\mathrm{op}}_{a,b}(1)=2^{ab}$ との整合も見る。

有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-rectangle-partition-value-at-positive-rational/check.sage
```
