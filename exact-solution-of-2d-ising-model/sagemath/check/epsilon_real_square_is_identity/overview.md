# SageMath Check: epsilon_real_square_is_identity

## 対象

**対象ラベル**: `epsilon_real_square_is_identity` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_epsilon_real_square_is_identity`（`ε_ℝε_ℝ = I_{Mat(2^{M_col},ℝ)}`）
- 範囲: 証明の 5 行の鎖 `ε_ℝε_ℝ = ϱ(εε) = ϱ(I_{Mat(d,ℂ)}) = ϱ(ε^0) = (ε_ℝ)^0 = I_{Mat(d,ℝ)}`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 5 行の鎖と主張 | `check_proof_lines.sage` | `M_col ∈ {1,2,3,4}` で `ε = σ^x⊠⋯⊠σ^x` と `ε_ℝ := ϱ(ε)` を作り、積を成分の和（`def_real_matrix_product`・`mat_mult`）、`A^0` を `def_exp` (1) の `A^0 := I` で作って、鎖の 6 つの値が一致することと `εε = I` を確かめる。否定コントロール 1 件（3 元の巡回置換行列 `C` は `CC ≠ I`） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `ε` は QQbar、`ε_ℝ` は AA で持つ。浮動小数点は使わない。
- 範囲外: `M_col ≥ 5`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_real_square_is_identity
```

実行ログは `logs/` に保存する。
