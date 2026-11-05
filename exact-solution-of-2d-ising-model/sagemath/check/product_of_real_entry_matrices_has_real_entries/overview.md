# SageMath Check: product_of_real_entry_matrices_has_real_entries

## 対象

**対象ラベル**: `product_of_real_entry_matrices_has_real_entries`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_product_of_real_entry_matrices_has_real_entries`（成分がすべて実数の行列の積は成分がすべて実数）
- 範囲: 証明の鎖 4 行（`mat_mult` → `s_j, t_j` の取り方 → `real_inclusion_preserves_product` → `real_inclusion_preserves_finite_sum`）と、結論

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| 1→2（`mat_mult`） | `check_entry_chain.sage` | 対の積の ℂ の有限和（左から）で組んだ `(AB)_ik` | **PASS** |
| 2→3（`s_j, t_j` の取り方） | `check_entry_chain.sage` | 各成分が `ι(s)`・`ι(t)` と一致 | **PASS** |
| 3→4（`real_inclusion_preserves_product` を各項へ） | `check_entry_chain.sage` | 各項で `ι(s)ι(t)`（`definition_of_cc` の積）と `ι(st)` の比較と、和の比較 | **PASS** |
| 4→5（`real_inclusion_preserves_finite_sum`） | `check_entry_chain.sage` | `Σ ι(s_jt_j)`（ℂ の和）と `ι(Σ s_jt_j)`（ℝ の和の像） | **PASS** |
| 結論（虚部 0）と主張 | `check_entry_chain.sage` | 鎖の先頭の虚部が 0。QQ(i) の行列に具体の有理数を入れた Sage の行列積の成分の虚部が 0 で、実部が鎖の最後の実数と一致 | **PASS** |

`A`・`B` の成分を QQ 上の不定元にし、`m, n, p = 1..3` の全成分 `(i, k)` で。1296 段。

## 計算の帰属と範囲

- **厳密**: QQ 上の多項式環の実数の組で組んだ ℂ と `QQ(i)`。浮動小数点と ℝ/ℂ への脱出はない。人手の実数は QQ 上の不定元で代表させる（各段は多項式の恒等式）。

## 構成上かならず一致する比較

- 1→2（`mat_mult`）は、`(AB)_ik` を `mat_mult` の式で作るので構成上一致する。2→3 の `A_ij = ι(s)` の行は、成分を `(s, 0)` で置いたので構成上一致する。中身は 3→4・4→5（`definition_of_cc` の積と和を対の成分で計算した比較）と、QQ(i) の組み込みの積との比較にある。

## 否定コントロール（1 件）

- `A` の成分の一つの虚部を 1 にすると、積の成分の虚部が `t` で 0 でない（仮定「成分が実」が効いている）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh product_of_real_entry_matrices_has_real_entries
```
