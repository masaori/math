# SageMath Check: real_symmetric_matrix_is_hermitian

## 対象

**対象ラベル**: `real_symmetric_matrix_is_hermitian`

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_real_symmetric_matrix_is_hermitian`（実対称な複素行列はエルミート）
- 範囲: 証明の成分の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 成分の鎖の全行 | `check_entry_chain.sage` | `(A^*)_{kl} = \overline{A_{lk}} = \overline{r_ℂ} = r_ℂ = A_{lk} = (A^⊤)_{kl} = A_{kl}` の 6 段（`def_hermitian_positive_definite` の共役転置 → `r` の取り方 → `complex_conjugate_of_real_inclusion` → `r` の取り方 → `def_matrix_transpose` → `A^⊤ = A`）を、成分が `QQ` 上の不定元 `r_{kl} = r_{lk}` の包含の実対称な行列で、`n = 1..4` の全成分で。否定コントロール 2 件: 成分が `i` の 1 行 1 列の行列は転置で不変だがエルミートでない、転置で不変でない実の行列 `((0,1),(0,0))` はエルミートでない | **PASS** | 180 段 |

## 計算の帰属と範囲

- **厳密**: 複素数は本文 `definition_of_cc` どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage` の `iota`・`cc_conj`）、成分の環は `QQ` 上の多項式環である。浮動小数点と ℝ/ℂ への脱出はない。
  不定元は実数の代表である（鎖の各段は多項式の恒等式なので、どの実数を代入しても成り立つ）。
- 鎖の 1・2・4・5 段目は、行列を本文の定義どおりに組んだことから必ず成り立つ（構成上の一致）。中身を確かめているのは 3 段目（`\overline{r_ℂ} = r_ℂ`）と 6 段目（`A^⊤ = A`）で、否定コントロールの 2 件がそれぞれに対応する。
- 範囲: 行列の大きさ `n = 1..4`。主張は成分ごとの等式なので、大きさによらず同じ段である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_symmetric_matrix_is_hermitian
```

実行ログは `logs/` に保存する。
