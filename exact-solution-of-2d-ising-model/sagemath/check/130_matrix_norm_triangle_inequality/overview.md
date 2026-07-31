# SageMath Check: 130_matrix_norm_triangle_inequality

## 対象

**対象ラベル**: `matrix_norm_triangle_inequality` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`

- 範囲: (1) 正定値性、(2) 斉次性、(3) 三角不等式、(4) 極限の一意性、および定義式との一致

<def_matrix_norm> の Frobenius ノルム（成分の平方和の平方根）を定義式から直接計算し、公理を確認する。三角不等式の等号（B = tA, t>0）も踏む。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_norm_axioms.sage` | ノルムの公理と等号条件 | 415 | 3.320e-16 | **PASS** |
| 02 | `check_02_limit_uniqueness.sage` | (4) 極限の一意性（証明の骨格 ‖A−A'‖ ≤ ‖A_N−A‖+‖A_N−A'‖） | 70 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

(4) 極限の一意性は「A = A'」という極限の主張なので数値でそのまま確かめることはできないが、**証明の骨格そのものは検査できる**（以前この check には含めていなかった穴を 02 で埋めた）。02 は収束列 A_N → A に対し A' := A + δ（δ ≠ O）を別の極限候補として置き、(a) 三角不等式による評価 ‖A−A'‖ ≤ ‖A_N−A‖+‖A_N−A'‖ が全 N で成り立つこと、(b) 逆向きの三角不等式から |‖A_N−A'‖ − ‖δ‖| ≤ ‖C‖/N であり ‖A_N−A'‖ が ‖δ‖ へ張り付いて 0 に落ちないこと、(c) ‖δ‖ を 1e0 から 1e-8 まで下げても δ ≠ O なら必ず区別できること、を確認している。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 130
```

実行ログは `sagemath/check/130_matrix_norm_triangle_inequality/logs/` に保存してある（この表の数値はそのログから取った）。
