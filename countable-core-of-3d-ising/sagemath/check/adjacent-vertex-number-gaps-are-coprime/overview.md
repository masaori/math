# SageMath Check: 隣接する頂点数差の互いに素性

## 対象

**対象ラベル**: `claim_adjacent_vertex_number_gaps_are_coprime`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 頂点数差の準備等式、隣接する差の四段の式変形、最大公約数の結論

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_gap_factorization.sage` | `3L^2+3L+1=3L(L+1)+1` | PASS | 正の箱サイズ 4096 件で一致 |
| `check_difference_from_definitions.sage` | 二つの頂点数差の定義式を展開 | PASS | 正の箱サイズ 4096 件で一致 |
| `check_collect_like_terms.sage` | 定義式の差の同類項を整理 | PASS | 正の箱サイズ 4096 件で一致 |
| `check_square_difference.sage` | 平方差を `2L+1` へ置換 | PASS | 正の箱サイズ 4096 件で一致 |
| `check_factor_difference.sage` | 差を `6(L+1)` へ因数分解 | PASS | 正の箱サイズ 4096 件で一致 |
| `check_adjacent_gaps_coprime.sage` | 隣接する二つの頂点数差の最大公約数 | PASS | 正の箱サイズ 4096 件で最大公約数が 1 |

## 備考

- `ZZ` の厳密計算だけを使う。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 実行日: 2026-08-25。六検査とも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/adjacent-vertex-number-gaps-are-coprime/check_*.sage; do sage "$f"; done
```
