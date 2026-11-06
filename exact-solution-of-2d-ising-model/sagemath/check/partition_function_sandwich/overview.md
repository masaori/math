# SageMath Check: partition_function_sandwich

## 対象

**対象ラベル**: `partition_function_sandwich` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_009_claim_partition_function_sandwich`（`c(M_col)^{N_row} ≤ Z(K_1,K_2) ≤ 2^{M_col}c(M_col)^{N_row}`）
- 範囲: 証明の準備の鎖 `(Z(K_1,K_2))_ℂ = tr(W^{N_row}) = T_ℂ`（`T := Σ_k ((W_ℝ)^{N_row})_kk`）、単射性による `Z(K_1,K_2) = T`、
  二つの鎖 `Z = T ≥ c^{N_row}` と `Z = T ≤ 2^{M_col}c^{N_row}`。

浮動小数点で主張の不等式を見る検算は `check/044_claim_max_eigenvalue/check_02_sandwich.sage` にある。ここは証明の行を厳密に確かめる。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の 2 行の鎖、`Z(K_1,K_2) = T`、二つの鎖 | `check_proof_lines.sage` | `W` を `W_real_is_symmetric` の検算と同じ厳密な経路（`../W_real_is_symmetric/_W_exact.sage`、`M_col = 2, 3`、`K_1 := 2 log y`、`K_2 := log x`、`x, y ∈ {2, 3}`）で作り、`N_row = 1, 2, 3`（計 24 組）で比べる。`Z(K_1,K_2)` は `def_partition_function_2d_ising` の全配位の和として転送行列を経由せずに計算する。`c(M_col)` は `W_ℝ` の最大の固有値（AA）。否定コントロール: 行と列を入れ替えた格子（`N_row = 2`, `M_col = 3`）の `Z` は `M_col = 2` の `tr(W^3)` と一致しない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `W` は QQbar、`W_ℝ` と `c(M_col)` は AA、`Z(K_1,K_2)` は QQ で持つ。浮動小数点は使わない。ℝ への脱出は `K_1`・`K_2` の選び方の一点だけ。
- `c(M_col)` を最大の固有値で取るのはこの検算の値の取り方で、本文は上限が最大固有値に等しいことを使わない。
- 範囲外: 選んだ以外の `M_col`・`N_row`・結合定数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh partition_function_sandwich
```

実行ログは `logs/` に保存する（2026-11-06、SageMath 10.9）。
