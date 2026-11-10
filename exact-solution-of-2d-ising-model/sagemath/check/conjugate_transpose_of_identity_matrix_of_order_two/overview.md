# SageMath Check: conjugate_transpose_of_identity_matrix_of_order_two

## 対象

**対象ラベル**: `conjugate_transpose_of_identity_matrix_of_order_two`

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_conjugate_transpose_of_identity_matrix_of_order_two`（2 次の単位行列の共役転置）
- 範囲: `I^* = I` の 6 行の鎖（`def_hermitian_positive_definite`・`def_identity_matrix`・`def_kronecker_delta`・`complex_conjugate_of_real_inclusion`・`def_kronecker_delta`・`def_identity_matrix`）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の鎖の全行 | `check_chain.sage` | 6 段。`body_star` が Sage の `conjugate_transpose()` と一致することを見てから使う。対照 1 件: 行列単位 `E_{12}` は共役転置で変わる | **PASS** | 成り立つ |

共通の準備は `sagemath/_shared/hermitian_forms_by_definition.sage`（`body_star`: `def_hermitian_positive_definite` の
`(A^*)_{kl} := \overline{A_{lk}}`）と `sagemath/_shared/complex_as_real_pairs.sage`（`definition_of_cc` の対の和・積、
`inclusion_rr_to_cc`、`multiply_by_minus_one`、`def_complex_conjugate`）。

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ` の対で、浮動小数点と ℝ/ℂ への脱出はない。比べる側は `QQ(i)` の Sage の `conjugate_transpose()`。
- 範囲: 主張は 2 次の具体的な行列 1 つについての等式なので、鎖の全行をそのまま確かめた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh conjugate_transpose_of_identity_matrix_of_order_two
```

実行ログは `logs/` に保存する。
