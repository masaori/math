# SageMath Check: finite_sum_of_real_numbers_moves_one_term_to_end

## 対象

**対象ラベル**: `finite_sum_of_real_numbers_moves_one_term_to_end` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_finite_sum_of_real_numbers_moves_one_term_to_end`（実数の有限和の一つの項は末尾へ移せる）と、
  それが引く `calc_formulae_definition_index_skipping_map`（`def_index_skipping_map`、一つの添字を飛ばす写像）
- 範囲: 主張 `Σ_{j=1}^{m+1} b_j = (Σ_{j=1}^{m} b_{δ^m_k(j)}) + b_k` と、証明の帰納法の各場合の各行・各場合の前置き（`δ` の値）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `def_index_skipping_map` の値 | `check_induction_chain.sage` | `m = 1,…,9`、全ての `k` で、`δ^m_k` の像が `{1,…,m+1}` から `k` を除いた集合に一致する | **PASS** | 有限の全数検査 |
| `m = 1`、`k = 1` の 6 行と `k = 2` の 3 行 | 同上 | 前置き `δ^1_1(1) = 2`・`δ^1_2(1) = 1` と、隣り合う行が等しい | **PASS** | 厳密等号（9 段） |
| `m → m+1`、`k = m+2` の 3 行 | 同上 | `m = 1,…,8` で前置き `δ^{m+1}_{m+2}(j) = j` と、隣り合う行が等しい | **PASS** | 厳密等号（24 段） |
| `m → m+1`、`k ≤ m+1` の前置きと 10 行 | 同上 | `m = 1,…,8`、全ての `k` で帰納法の仮定、前置き `δ^{m+1}_k(j) = δ^m_k(j)`（`j ≤ m`。`j < k` と `j ≥ k` の 2 本の鎖を、途中の値 `j`・`j+1` まで一行ずつ）・`δ^{m+1}_k(m+1) = m+2` と、隣り合う行が等しい | **PASS** | 厳密等号（440 段） |
| 主張そのもの | 同上 | Sage の `sum`（独立な経路）と比べる。否定コントロールとして、`k` を飛ばさずに先頭の `m+1` 項を並べた右辺とは一致しないことも確かめる | **PASS** | 否定コントロール 44 件 |

鎖の段は全体で 473 段（`m = 1` の 9 段、`k = m+2` の 24 段、`k ≤ m+1` の 440 段）である。

## 計算の帰属と範囲

`b_j` を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の `m` は人手証明の帰納法が担う。

鎖の項は多項式環の元なので、結合法則・交換法則の行は Sage の正規形で吸収され、構成上かならず一致する（写し間違いの検出だけに効く）。
効く判定は、`δ` の値の前置き（添字の計算）と、`δ` を通した項の並び（`B(delta(…))`）が前の行と同じ値を持つこと、および主張と否定コントロールである。
添字は本文と同じ 1 始まりで書いた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_real_numbers_moves_one_term_to_end
```

実行ログは `sagemath/check/finite_sum_of_real_numbers_moves_one_term_to_end/logs/` に保存する（2026-11-06）。
