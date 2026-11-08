# SageMath Check: norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four

## 対象

**対象ラベル**: `norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four`（`‖u‖ = 1` のとき、成分が `u_k + (ε_ℝu)_k` のベクトル `v` について `‖v‖^2 ≤ 4`）
- 範囲: 証明の準備（`‖x‖^2 = Σ|x_k|^2` の 2 行、`|v_k|^2` の 4 行の鎖）と主張の 9 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備と主張の鎖 | `check_proof_lines.sage` | `ε` を `σ_1^x⋯σ_{M_col}^x`（共通の準備 `_epsilon_exact.sage`）で作り `ε_ℝ := ϱ(ε)` とする。`M_col = 1, 2, 3, 4` で、`‖u‖ = 1` の `u` を 6 本ずつ（`e_1`、`ε_ℝu = u` となる `(e_1 + ε_ℝe_1)/‖e_1 + ε_ℝe_1‖`、有理数のベクトルを正規化したもの 4 本。計 24 本、種は固定）取り、準備の 2 行を `x → u, ε_ℝu, v` で、`|v_k|^2` の 4 行をすべての `k` で、主張の 9 行を確かめる（1080 段）。`ε_ℝu = u` の 4 本で等号 `‖v‖^2 = 4` になる（評価の 4 は下げられない）。否定コントロール 1 件（仮定 `‖u‖ = 1` を外した `u = 2e_1`（`M_col = 1`）では `‖v‖^2 = 8`） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `ε` は QQbar、`ε_ℝ`・`u`・ノルムは AA（実代数的数。平方根も AA で厳密）で持つ。浮動小数点は使わない。
- 範囲外: `M_col ≥ 5`、選んだ以外の `u`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。一般の `M_col` は人手証明の鎖が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four
```

実行ログは `logs/` に保存する（2026-11-07）。
