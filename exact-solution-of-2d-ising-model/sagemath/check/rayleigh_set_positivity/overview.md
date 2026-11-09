# SageMath Check: def_rayleigh_sup の c(M_col) > 0

## 対象

**対象ラベル**: `def_rayleigh_sup` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_006_definition_rayleigh_sup`（`c(M_col) := sup 𝓡`）
- 範囲: `c(M_col) > 0` の段の `|(e_1)_i|^2`（`i ≥ 2` と `i = 1`）の 3 行の鎖 2 本と `‖e_1‖ = 1` の 4 行の鎖と `e_1^⊤W_ℝe_1 > 0`。
  上に有界であることの鎖は `rayleigh_set_upper_bound_chain/` が受け持つ。
  `𝓡 ⊆ ℝ_{>0}` の段の `x ≠ 0` は主張 `unit_norm_vector_is_nonzero` を引くので、その 6 行の鎖は `unit_norm_vector_is_nonzero/` が受け持つ。

## 証明の行との対応

| 段 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `|(e_1)_i|^2` の 3 行 2 本、`‖e_1‖ = 1` の 4 行（和は左から順に足して各段で `1 + 0 = 1`） | `check_proof_lines.sage` | `M_col = 1..4` で各行を本文の字面どおり（絶対値は `def_real_absolute_value`、平方根は `y ≥ 0, y^2 = x` を満たす `y`）に組んで比べる。否定コントロール 4 件（成分を 2 にした `2e_1` ではノルムが 1 でない） | **PASS** | 成り立つ |
| `e_1^⊤W_ℝe_1 > 0`（`W_real_is_positive_definite`、`x → e_1`） | `check_proof_lines.sage` | 具体の `W`（`M_col = 2, 3`、`x, y ∈ {2, 3}`）で `e_1^⊤W_ℝe_1 = (W_ℝ)_11 > 0`。 | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: QQ・AA だけで計算した。浮動小数点は使わない。
- 範囲外: `c(M_col) = sup 𝓡 ≥ e_1^⊤W_ℝe_1` の行（上限は ℝ の完備性で存在する値で、検算では作らない）。選んだ以外の `M_col`・結合定数。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh rayleigh_set_positivity
```

実行ログは `logs/` に保存する。
