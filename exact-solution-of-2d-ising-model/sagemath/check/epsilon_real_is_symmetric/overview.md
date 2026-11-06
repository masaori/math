# SageMath Check: epsilon_real_is_symmetric

## 対象

**対象ラベル**: `epsilon_real_is_symmetric` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_epsilon_real_is_symmetric`（`ε_ℝ` は対称）
- 範囲: 証明の 4 行の鎖 `((ε_ℝ)_kl)_ℂ = ε_kl = (ε^⊤)_kl = ε_lk = ((ε_ℝ)_lk)_ℂ` と、単射性による `(ε_ℝ)_kl = (ε_ℝ)_lk`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 4 行の鎖と主張 | `check_proof_lines.sage` | `M_col ∈ {1,2,3,4}` で `ε = σ^x⊠⋯⊠σ^x` を作り、`ε_ℝ := ϱ(ε)` を成分から作る。全ての `k, l`（計 340 組）で鎖の 5 つの値を比べ、`(ε_ℝ)_kl = (ε_ℝ)_lk` と `ε_ℝ^⊤ = ε_ℝ` を確かめる。否定コントロール 1 件（3 元の巡回置換行列は 2→3 行の `ε^⊤ = ε` に当たる段で外れる） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `ε` は QQbar、`ε_ℝ` は AA で持つ。浮動小数点は使わない。
- 範囲外: `M_col ≥ 5`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_real_is_symmetric
```

実行ログは `logs/` に保存する。
