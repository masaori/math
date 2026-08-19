# SageMath Check: 2 次元境界応答多項式の Pfaffian 予言

## 対象

**対象ラベル**: `claim_two_dimensional_boundary_response_pfaffian_prediction`

自由境界の $L'=1,L=2$ について、Fisher terminal graph の Kasteleyn 向き付けから作る
Pfaffian に全外部辺の分母を掛けると、符号を除いて境界応答多項式の偶部分グラフ和と一致することを
多変数整数係数多項式として確認する。

## 結果

`check.sage` は既存の有限例検証を再利用し、分母消去後の Pfaffian が
$\prod_e(1-X_e)+\prod_e(1+X_e)$ に符号を除いて一致することを確認した。

**2026-08-19 実行: PASS。**

## 実行方法

```sh
sage sagemath/check/two-dimensional-boundary-response-pfaffian-prediction/check.sage
```
