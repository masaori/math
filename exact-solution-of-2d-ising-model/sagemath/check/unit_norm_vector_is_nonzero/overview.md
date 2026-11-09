# SageMath Check: ‖x‖ = 1 なら x ≠ 0

## 対象

**対象ラベル**: `unit_norm_vector_is_nonzero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_claim_unit_norm_vector_is_nonzero`
- 範囲: `x = 0` と仮定して `‖x‖ = 0` に着く 6 行の鎖と、ℝ で `0 ≠ 1` なので `‖x‖ = 1` と矛盾する段。

## 証明の行との対応

| 段 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `‖x‖ = √(Σ\|x_j\|^2) = √(Σ\|0\|^2) = √(Σ0^2) = √(Σ0) = √0 = 0` の 6 行（和は左から順に足して各段で `0 + 0 = 0`）と `0 ≠ 1` | `check_proof_lines.sage` | `d = 1..16` で各行を本文の字面どおり（絶対値は `def_real_absolute_value`、平方根は `y ≥ 0, y^2 = x` を満たす `y`）に組んで比べる | **PASS** | 等号 96 個 |
| 否定の対照 | `check_proof_lines.sage` | ノルム 1 の具体的なベクトル（標準基底 `e_k` と、成分 `±1/√d`）が零でないこと | **PASS** | 152 件 |

## 計算の帰属と範囲

- **厳密**: AA だけで計算した。浮動小数点は使わない。
- 範囲外: `d ≥ 17`。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh unit_norm_vector_is_nonzero
```

実行ログは `logs/` に保存する。
