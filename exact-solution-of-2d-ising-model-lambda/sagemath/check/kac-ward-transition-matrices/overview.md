# 四つの Kac--Ward 遷移行列

## 対象

**対象ラベル**: `claim_transition_entries_in_mu8`

本文の四つの Kac--Ward 遷移行列 `M^{a,b}` の成分（`def_kac_ward_transition_matrices`）を、
向き付き辺・回転位相・ねじれ符号の定義から組み立てて検査する。

## 検査内容

- `L=1,2,3` と四つのスピン構造 `(a,b)` の全部について、全成分（`(4L²)²` 個）を構成する。
- 各成分が `0` であるか、または 8 乗して `1` になる（1 の 8 乗根に属する）ことを確認する。

## 実行結果

2026-08-29: PASS。`QQbar` と整数の厳密計算だけを用い、浮動小数点は使っていない。

```bash
sage sagemath/check/kac-ward-transition-matrices/check.sage
```
