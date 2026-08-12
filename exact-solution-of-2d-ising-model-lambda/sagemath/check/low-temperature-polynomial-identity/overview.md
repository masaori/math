# SageMath Check: 低温展開の多項式恒等式

## 対象

**対象ラベル**: `claim_low_temperature_polynomial_identity`

- 併せて検証: `def_broken_edge_set_polynomial`
- 範囲: 破れた辺の集合の各原像が二配位であることと、$Z_L=2D_L$ の有限多項式恒等式

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ の全配位を破れた辺の集合で類別し、各原像の元の個数と多項式恒等式を厳密計算する | PASS | 1、8、256 個の破れ集合について各原像が 2 配位であり、$Z_L=2D_L$ |

## 備考

スピン値は `ZZ`、生成多項式は `ZZ['x']` で計算する。浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。

## 実行方法

```sh
sage sagemath/check/low-temperature-polynomial-identity/check.sage
```

**2026-08-12 実行: すべて通過。**
