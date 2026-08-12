# SageMath Check: 高温展開の多項式恒等式

## 対象

**対象ラベル**: `claim_high_temperature_polynomial_identity`

- 併せて検証: `def_high_temperature_polynomial`
- 範囲: 一辺の二項表示、全辺への積、偶部分グラフだけに残る整数多項式恒等式

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2$ の全配位で一辺表示を全辺へ掛けた等式を検査し、全辺部分集合から作った $H_L$ と $2^{L^2}Z_L$ を比較する | PASS | 両辺は `ZZ[x]` で一致 |

## 備考

端点は番号つきで数えるため、$L=1$ の自己ループも二つの端点を持つ。すべて `ZZ[x]` の厳密計算であり、浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。

## 実行方法

```sh
sage sagemath/check/high-temperature-polynomial-identity/check.sage
```

**2026-08-12 実行: すべて通過。**
