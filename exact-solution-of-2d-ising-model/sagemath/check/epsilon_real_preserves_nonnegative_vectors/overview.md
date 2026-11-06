# SageMath Check: epsilon_real_preserves_nonnegative_vectors

## 対象

**対象ラベル**: `epsilon_real_preserves_nonnegative_vectors` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_epsilon_real_preserves_nonnegative_vectors`（`u_k ≥ 0 (∀k)` なら `(ε_ℝu)_k ≥ 0 (∀k)`）
- 範囲: 証明の準備（`k = ord(s)`、`ord(-s) ∈ {1,…,d}`）と 3 行の鎖。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備と 3 行の鎖 | `check_proof_lines.sage` | `ε` を `σ_1^x⋯σ_{M_col}^x`（`epsilon_entries_in_row_configuration_numbering` の共通の準備 `_epsilon_exact.sage`）で作り `ε_ℝ := ϱ(ε)` とする。`M_col = 1, 2, 3, 4` で成分が非負の有理数のベクトル `u` を 5 本ずつ（計 20 本、種は固定）取り、`ord(s)` が `{1,…,d}` を覆うことを確かめ、全ての `k ∈ {1,…,d}` で `ord` の逆引きにより `k = ord(s)` の `s` を取って `ord(-s) ∈ {1,…,d}`、鎖の等号 2 行と最後の不等号、主張を確かめる。否定コントロール 1 件（負の成分を含む `u` では負の成分が出る） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `ε` は QQbar、`ε_ℝ`・`u` は AA で持つ。浮動小数点は使わない。ℝ への脱出は無い。
- 範囲外: `M_col ≥ 5`、選んだ以外の `u`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_real_preserves_nonnegative_vectors
```

実行ログは `logs/` に保存する。
