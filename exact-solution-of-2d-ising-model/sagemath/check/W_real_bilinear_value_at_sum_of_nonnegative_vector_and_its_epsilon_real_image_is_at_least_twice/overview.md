# SageMath Check: W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice

## 対象

**対象ラベル**: `W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice`（成分が非負のベクトル `u` について、成分が `u_k + (ε_ℝu)_k` のベクトル `v` は `v^⊤W_ℝv ≥ 2(u^⊤W_ℝu)` を満たす）
- 範囲: 証明の準備の 3 つ（`u^⊤W_ℝũ ≥ 0`・`ũ^⊤W_ℝu ≥ 0` と和の不等式 2 本、`ε_ℝ(W_ℝũ) = W_ℝu` の 7 行、`ũ^⊤W_ℝũ = A` の 5 行。`ũ := ε_ℝu`、`A := u^⊤W_ℝu`）と主張の 11 行の鎖。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の 3 つと主張の 11 行の鎖 | `check_proof_lines.sage` | `W` を `W_real_is_symmetric` の共通の準備 `_W_exact.sage`（`M_col = 2, 3`、`x, y ∈ {2, 3}`）で、`ε` を `σ^x ⊠ ⋯ ⊠ σ^x` で作り、`W_ℝ := ϱ(W)`・`ε_ℝ := ϱ(ε)` とする。各組で成分が非負の有理数のベクトル `u` を 4 本（`e_1` を含む。種は固定）取り、準備の `ũ_k ≥ 0`・`(W_ℝ)_kl > 0`・交差項 2 つの非負性と和の不等式 2 本、準備の 2 本の鎖の各等号、主張の鎖の各行（等号 9 行・不等号 2 行）と主張を確かめる（32 組、864 段）。積と双線型値は定義の成分の和で作る。否定コントロール 1 件（仮定 `u_k ≥ 0` を外した `u = e_1 − e_4`（`M_col = 2`、`x = y = 2`）では `ε_ℝu = −u`、`v = 0` で `v^⊤W_ℝv < 2u^⊤W_ℝu`） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `W` は実の数体の元から QQbar へ、`W_ℝ`・`ε_ℝ`・`u` は AA で持つ。浮動小数点は使わない。ℝ への脱出は、共通の準備が `K_1 := 2 log y`、`K_2 := log x` と選ぶ一点だけである。
- 範囲外: `M_col = 1` と `M_col ≥ 4`、選んだ以外の `(K_1, K_2)` と `u`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。一般の場合は人手証明の鎖が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice
```

実行ログは `sagemath/check/W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice/logs/` に保存する（2026-11-07）。
