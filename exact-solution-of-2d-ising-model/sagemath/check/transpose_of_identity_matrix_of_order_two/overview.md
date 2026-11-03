# SageMath Check: transpose_of_identity_matrix_of_order_two

## 対象

**対象ラベル**: `transpose_of_identity_matrix_of_order_two`

- ファイル: `structured-latex/content/006_Z_Y_anticommutation.ts`
- ブロック: `Z_Y_anticommutation_claim_transpose_of_identity_matrix_of_order_two`（2 次の単位行列の転置）
- 範囲: `I^⊤ = I` の 5 行の鎖（`def_matrix_transpose`・`def_identity_matrix`・`def_kronecker_delta` 2 回・`def_identity_matrix`）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の鎖の全行 | `check_chain.sage` | 5 段。転置は `def_matrix_transpose`、単位行列は `def_identity_matrix`・`def_kronecker_delta` の成分の式で組み、Sage の `transpose()`・`identity_matrix` との一致を見てから使う。対照 1 件: 行列単位 `E_12` は転置で変わる | **PASS** | 成り立つ |

共通の準備は `sagemath/_shared/pauli_sites_exact.sage`（σ^x, σ^y, σ^z, I は `pauli_matrix_products` の成分）と、
`sagemath/_shared/matrix_operations_by_definition.sage` の `body_transpose`（`def_matrix_transpose`）。

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ(i)` で、浮動小数点と ℝ/ℂ への脱出はない。
- 範囲: 主張は 2 次の具体的な行列 1 つについての等式なので、鎖の全行をそのまま確かめた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh transpose_of_identity_matrix_of_order_two
```

実行ログは `logs/` に保存する。
