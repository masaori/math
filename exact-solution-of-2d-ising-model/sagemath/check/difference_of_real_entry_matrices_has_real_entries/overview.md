# SageMath Check: difference_of_real_entry_matrices_has_real_entries

## 対象

**対象ラベル**: `difference_of_real_entry_matrices_has_real_entries`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_difference_of_real_entry_matrices_has_real_entries`（成分がすべて実数の行列の差は成分がすべて実数）
- 範囲: 行列の鎖の 3 行と、続く段落

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の 3 行と段落 | `check_chain.sage` | `A - B = A + (-B) = A + (-1_ℂ)B = A + (-1)_ℂB` の 3 段（`matrix_difference_is_sum_with_negation` → `negation_is_scalar_multiple_by_minus_one` → `inclusion_rr_to_cc` の略記）を、`A`・`B` の成分を `QQ` 上の不定元にして `m, n = 1..3` で。続く段落の `(-1)_ℂB`・`A + (-1)_ℂB`・`A - B` の成分の虚部が 0 であること。否定コントロール 1 件: `B` の成分を `i` 倍すると差は実でない | **PASS** | 63 段 |

## 計算の帰属と範囲

- **厳密**: `QQ(i)` 係数の多項式環で、浮動小数点と ℝ/ℂ への脱出はない。人手の実数は `QQ` 上の不定元で代表させる（鎖の各段は多項式の恒等式なので、どの実数を代入しても成り立つ）。
- 範囲: 行列の大きさ `m, n = 1..3`。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh difference_of_real_entry_matrices_has_real_entries
```

実行ログは `logs/` に保存する。
