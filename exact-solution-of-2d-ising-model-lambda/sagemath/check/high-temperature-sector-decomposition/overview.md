# SageMath Check: 高温展開の生成多項式の四セクター分解

## 対象

**対象ラベル**: `claim_high_temperature_sector_decomposition`

- 併せて検証: `def_high_temperature_sector_polynomial`
- 範囲: 高温展開の整数多項式 $H_L\in\mathbb{Z}[x]$ と四つのセクター多項式 $H^{a,b}_L\in\mathbb{Z}[x]$ を全辺部分集合の数え上げで独立に作り、$H_L=H^{0,0}_L+H^{0,1}_L+H^{1,0}_L+H^{1,1}_L$ と、セクターごとの偶部分グラフの個数の和が偶部分グラフの総数に一致すること（分割であること）を厳密検査する

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ について、$H_L$ と $H^{a,b}_L$ を `ZZ[x]` で数え上げ、$H_L=\sum_{a,b}H^{a,b}_L$ とセクター個数の分割を厳密検査する | PASS | 全件一致（偶部分グラフは $L=1,2,3$ で $4,32,1024$ 個、各セクター均等） |

## 実行方法

```sh
sage sagemath/check/high-temperature-sector-decomposition/check.sage
```

**2026-08-13 実行: すべて通過。**
