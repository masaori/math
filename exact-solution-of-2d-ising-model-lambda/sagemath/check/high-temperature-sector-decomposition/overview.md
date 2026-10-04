# SageMath Check: 高温展開の生成多項式の四セクター分解

## 対象

**対象ラベル**: `claim_high_temperature_sector_decomposition`

- 併せて検証: `def_high_temperature_sector_polynomial`
- 範囲: 高温展開の整数多項式 $H_L\in\mathbb{Z}[x]$ と四つのセクター多項式 $H^{a,b}_L\in\mathbb{Z}[x]$ を全辺部分集合の数え上げで独立に作り、$H_L=H^{0,0}_L+H^{0,1}_L+H^{1,0}_L+H^{1,1}_L$ と、セクターごとの偶部分グラフの個数の和が偶部分グラフの総数に一致すること（分割であること）を厳密検査する

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ について、$H_L$ と $H^{a,b}_L$ を `ZZ[x]` で数え上げ、$H_L=\sum_{a,b}H^{a,b}_L$ とセクター個数の分割を厳密検査する | PASS | 全件一致（偶部分グラフは $L=1,2,3$ で $4,32,1024$ 個、各セクター均等） |
| `check_sector_even.sage` | $A\in\mathcal E_L^{a,b}$ なら $\operatorname{Even}_L(A)$ | PASS | $L=1,2,3$ の偶部分グラフ計 1060 例 |
| `check_unique_sector.sage` | 偶部分グラフが所属するセクターの一意性 | PASS | $L=1,2,3$ の偶部分グラフ計 1060 例 |
| `check_high_temperature_definition.sage` | $H_L$ の定義を偶部分グラフの有限和へ展開 | PASS | $L=1,2,3$ の 3 例 |
| `check_partition_sum.sage` | 二つの巻き付き偶奇の値で有限和を分割 | PASS | $L=1,2,3$ の 3 例 |
| `check_sector_substitution.sage` | 巻き付き偶奇の条件を $A\in\mathcal E_L^{a,b}$ へ置換 | PASS | $L=1,2,3$ の四セクター計 12 例 |
| `check_sector_polynomial_definition.sage` | 各セクター内の有限和を $H_L^{a,b}$ へ置換 | PASS | $L=1,2,3$ の四セクター計 12 例 |
| `check_four_sector_sum.sage` | 四つの添字を列挙した和へ展開 | PASS | $L=1,2,3$ の 3 例 |

行別検算では、巻き付き偶奇の組を切断辺集合との共通部分の元数から計算し、セクターの所属条件は頂点次数と境界辺の指示関数の和から独立に判定する。各セクターで集合そのものと多項式の和が一致することを確かめる。有限集合・非負整数・`ZZ[x]` だけを使い、浮動小数点は使わない。

## 実行方法

プロジェクト直下で実行する。`check.sage` は既存の全列挙と行別7本を実行する。行別ファイルも同じディレクトリから単独実行できる。

```sh
sage sagemath/check/high-temperature-sector-decomposition/check.sage
```

**2026-08-13 実行: すべて通過。**

**2026-10-04 実行:** SageMath 10.9 で既存の全列挙と行別 7 本を実行し、全件 PASS（終了コード 0）。
