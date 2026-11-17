# SageMath Check: pair_of_matrices_times_matrix_times_column_associative

## 対象

**対象ラベル**: `pair_of_matrices_times_matrix_times_column_associative`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_claim_pair_of_matrices_times_matrix_times_column_associative`（行列の組と 2×2 行列と数の列の積の結合律 `((A, B)P)v = (A, B)(Pv)`）
- 範囲: 主張と、証明の成分の鎖の全 18 行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 主張 | `check_proof_rows.sage` | 左辺を `def_pair_of_matrices_times_two_by_two_matrix`・`def_pair_of_matrices_times_column_of_numbers` の成分の式で、右辺の `Pv` を `mat_mult` の成分の式で組み、等しい | **PASS** | `d = 1, 2, 3`、成分が独立な不定元の `A, B` と不定元 `p, q, r, s, a, b` の `QQ` 上の多項式として厳密 |
| 鎖の 1〜18 行目 | 同上 | 各行を行の表記どおりに組み（和・スカラー倍の展開の行は本文の成分の式、`ℂ` の分配律・結合律・交換律の行は括弧と因子の並びのとおり、有限和の行は `j = 1, 2` の和）、始点 → 1 行目 → … → 18 行目の隣どうしが等しい。始点は主張の左辺、18 行目は主張の右辺の `(k, l)` 成分 | **PASS** | 上と同じ範囲で厳密（全成分） |
| 対照 | 同上 | `(A, B)(P^T v)`・`(Pv)` の成分を入れ替えたもの・`(B, A)(Pv)` は左辺と一致しない | **PASS** | 上と同じ範囲 |

## 計算の帰属と範囲

- **厳密**: `QQ` 上の多項式環で計算した。浮動小数点は使わない。主張の係数は `ℂ` だが、証明は分配律・結合律・交換律と定義の展開だけを使うので、可換環の不定元で確かめれば足りる。
- 範囲外: `d ≥ 4`（成分ごとの主張なので、`d` に依る段は無い）。

## 確かめられない行と理由

- 多項式環は式を正規化するので、隣どうしの行が等しいことは確かめられるが、各行が一つの根拠だけで前の行から得られることは区別できない。それはレビューの目視で確かめた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh pair_of_matrices_times_matrix_times_column_associative
```

実行ログは `logs/` に保存する（2026-11-17）。
