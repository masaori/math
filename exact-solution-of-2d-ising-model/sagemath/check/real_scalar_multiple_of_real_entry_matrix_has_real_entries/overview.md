# SageMath Check: real_scalar_multiple_of_real_entry_matrix_has_real_entries

## 対象

**対象ラベル**: `real_scalar_multiple_of_real_entry_matrix_has_real_entries`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_real_scalar_multiple_of_real_entry_matrix_has_real_entries`（成分がすべて実数の行列の実数倍は成分がすべて実数）
- 範囲: 成分の鎖の全行と、`r := cs` を取る段落

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 成分の鎖の全行と `r := cs` | `check_entry_chain.sage` | `(c_ℂB)_{pq} = c_ℂB_{pq} = c_ℂs_ℂ = (cs)_ℂ` の 3 段（`def_matrix_scalar_multiple` → `s` の取り方 → `real_inclusion_preserves_product`）を、`c` と `B` の成分 `s_{pq}` を `QQ` 上の不定元にして、`m, n = 1..3` の全成分で。`ι(r) := (r, 0)` は係数を `QQ(i)` に広げた多項式環の元 `r + 0·i`。結果の成分の係数の虚部が 0（`r := cs` の像）であること。否定コントロール 1 件: 掛ける数を `i` にすると虚部 0 でない成分になる | **PASS** | 108 段 |

## 計算の帰属と範囲

- **厳密**: `QQ(i)` 係数の多項式環で、浮動小数点と ℝ/ℂ への脱出はない。人手の `c, s ∈ ℝ` は `QQ` 上の不定元で代表させる（鎖の各段は多項式の恒等式なので、どの実数を代入しても成り立つ）。
- 範囲: 行列の大きさ `m, n = 1..3`。主張は成分ごとの等式なので、大きさによらず同じ 3 段である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_scalar_multiple_of_real_entry_matrix_has_real_entries
```

実行ログは `logs/` に保存する。
