# SageMath Check: 正錐の非負係数条件どうしの和

**対象ラベル**: `claim_quadratic_positive_add_nonnegative`

## 検証内容

- $a,b,a',b'\in\mathbb{Q}_{\ge0}$ と $(a,b)\ne(0,0)$、$(a',b')\ne(0,0)$ から、
  $a+a'\ge0$、$b+b'\ge0$、$(a+a',b+b')\ne(0,0)$ が従うことを厳密有理数で検査する。
- 浮動小数点と実数体は使わない。

## 実行結果

- 2026-08-14: `sage check.sage` 成功。
