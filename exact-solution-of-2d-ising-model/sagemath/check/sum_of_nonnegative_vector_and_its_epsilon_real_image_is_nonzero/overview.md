# SageMath Check: sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero

## 対象

**対象ラベル**: `sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero`（成分が非負で 0 でないベクトル `u` について、成分が `u_k + (ε_ℝu)_k` のベクトルは 0 でない）
- 範囲: 証明の準備（`u_{k_0} ≠ 0` なる `k_0`、`u_{k_0} > 0`、`(ε_ℝu)_{k_0} ≥ 0`）と 4 行の鎖、結び `v ≠ 0`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備と 4 行の鎖と結び | `check_proof_lines.sage` | `ε` を `σ_1^x⋯σ_{M_col}^x`（共通の準備 `_epsilon_exact.sage`）で作り `ε_ℝ := ϱ(ε)` とする。`M_col = 1, 2, 3, 4` で、成分が非負の有理数で 0 でないベクトル `u` を 8 本ずつ（0 でない成分が 1 個だけのものを各 `M_col` で `min(d, 4)` 本含む。計 32 本、種は固定）取り、`u_{k_0} ≠ 0` を満たすすべての `k_0` で、準備の 2 つの不等号、鎖の等号 2 行・不等号 2 行、`v_{k_0} ≠ 0`、主張 `v ≠ 0` を確かめる（532 段）。否定コントロール 1 件（仮定 `u_k ≥ 0` を外した `u = (1, -1)`（`M_col = 1`）では `v = 0`） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `ε` は QQbar、`ε_ℝ`・`u` は AA で持つ。浮動小数点は使わない。ℝ への脱出は無い。
- 範囲外: `M_col ≥ 5`、選んだ以外の `u`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。一般の `M_col` は人手証明の鎖が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero
```

実行ログは `sagemath/check/sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero/logs/` に保存する（2026-11-07）。
