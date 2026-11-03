# SageMath Check: sum_of_real_entry_matrices_has_real_entries

## 対象

**対象ラベル**: `sum_of_real_entry_matrices_has_real_entries`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_sum_of_real_entry_matrices_has_real_entries`（成分がすべて実数の行列の和は成分がすべて実数）
- 範囲: 成分の鎖の全行と、`r := s + t` を取る段落

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 成分の鎖の全行と `r := s + t` | `check_entry_chain.sage` | `(A+B)_{pq} = A_{pq} + B_{pq} = s_ℂ + t_ℂ = (s,0) + (t,0) = (s+t, 0+0) = (s+t, 0) = (s+t)_ℂ` の 6 段（`def_matrix_sum` → `s, t` の取り方 → `inclusion_rr_to_cc` を 2 箇所 → `definition_of_cc` の和 → ℝ で `0 + 0 = 0` → `inclusion_rr_to_cc`）を、複素数を実数の組 (実部, 虚部) で組み、`A`・`B` の成分を `QQ` 上の不定元にして `m, n = 1..3` の全成分で。和の成分の虚部が 0 であること。否定コントロール 1 件: `B` の成分の虚部を 1 にすると和の虚部が 0 でない | **PASS** | 216 段 |

## 計算の帰属と範囲

- **厳密**: `QQ` 上の多項式環の実数の組で組んだ ℂ（`definition_of_cc` の和の定義どおり）で、浮動小数点と ℝ/ℂ への脱出はない。人手の実数は `QQ` 上の不定元で代表させる（鎖の各段は多項式の恒等式なので、どの実数を代入しても成り立つ）。
- 範囲: 行列の大きさ `m, n = 1..3`。主張は成分ごとの等式なので、大きさによらず同じ 6 段である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sum_of_real_entry_matrices_has_real_entries
```

実行ログは `logs/` に保存する。
