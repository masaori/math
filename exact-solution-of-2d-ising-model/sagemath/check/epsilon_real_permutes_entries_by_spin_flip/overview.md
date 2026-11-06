# SageMath Check: epsilon_real_permutes_entries_by_spin_flip

## 対象

**対象ラベル**: `epsilon_real_permutes_entries_by_spin_flip` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_epsilon_real_permutes_entries_by_spin_flip`（`(ε_ℝu)_{ord(s)} = u_{ord(-s)}`）
- 範囲: 証明の `l ≠ ord(-s)` の 5 行、`l = ord(-s)` の 5 行、`((ε_ℝu)_{ord(s)})_ℂ` から始まる 5 行の鎖と、単射性による結論。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 二つの 5 行・主鎖の 5 行・結論 | `check_proof_lines.sage` | `ε` を `σ_1^x⋯σ_{M_col}^x`（`epsilon_entries_in_row_configuration_numbering` の共通の準備 `_epsilon_exact.sage`）で作り `ε_ℝ := ϱ(ε)` とする。`M_col = 1, 2, 3` で成分が有理数のベクトル `u` を 5 本ずつ（計 15 本、種は固定）取り、全ての `s` と `l` で各行の値の一致（外れたら行と `s` を出す）と `(ε_ℝu)_{ord(s)} = u_{ord(-s)}` を確かめる。否定コントロール 1 件（右辺を並べ替えない `u_{ord(s)}` にすると外れる） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `ε` は QQbar、`ε_ℝ`・`u` は AA で持つ。浮動小数点は使わない。ℝ への脱出は無い。
- 範囲外: `M_col ≥ 4`、選んだ以外の `u`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_real_permutes_entries_by_spin_flip
```

実行ログは `logs/` に保存する。
