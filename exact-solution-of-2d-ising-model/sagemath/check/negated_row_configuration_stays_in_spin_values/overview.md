# SageMath Check: def_negated_row_configuration

## 対象

**対象ラベル**: `def_negated_row_configuration` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_definition_negated_row_configuration`（`(-s)(m) := -s(m)`）
- 範囲: 定義の中の場合分け（`s(m) = 1_ℝ` の 1 行と `s(m) = -1_ℝ` の 2 行）と、`-s ∈ 𝔐` の結論

## 定義の行との対応

| 定義の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `s(m) = 1_ℝ` のとき `-s(m) = -1_ℝ` | `check_definition_lines.sage` | `-1 = -1` を `ZZ` で確かめる | **PASS** | 厳密（等号 1 個） |
| `s(m) = -1_ℝ` のとき `-s(m) = -(-1_ℝ) = 1_ℝ` | 同上 | 代入の行と `real_double_negation`（`a → 1_ℝ`）の行を `ZZ` で、`-(-a) = a` を `ZZ[a]` で確かめる | **PASS** | 厳密（等号 2 個と一般形 1 個） |
| `-s ∈ 𝔐` | 同上 | `M_col = 1..6` の全ての行配位で `-s` の全成分が `{-1, 1}` に入り、`-(-s) = s` であること | **PASS** | 126 件 |
| 否定コントロール | 同上 | 符号反転を恒等写像と取り違えると二つ目の場合が `1` にならない。2 倍と取り違えると `{-1, 1}` から出る | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: `ZZ` と `ZZ[a]` だけで計算した。本文の所属は `ℝ` だが、`1_ℝ`・`-1_ℝ` とその符号反転は整数の部分で厳密に表せる。浮動小数点は使わない。
- 範囲外: 検算は式変形の書き間違いの裏取りであり、証明ではない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh negated_row_configuration_stays_in_spin_values
```

実行ログは `logs/` に保存する（2026-11-24、SageMath 10.9）。
