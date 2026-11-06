# SageMath Check: finite_double_sum_of_real_numbers_interchange

## 対象

**対象ラベル**: `finite_double_sum_of_real_numbers_interchange` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_finite_double_sum_of_real_numbers_interchange`（実数の二重の有限和は和の順序を入れ替えても等しい）
- 範囲: 主張 `Σ_{k=1}^{n_1} Σ_{l=1}^{n_2} c_{k,l} = Σ_{l=1}^{n_2} Σ_{k=1}^{n_1} c_{k,l}` と、証明の帰納法の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `n_1 = 1` の 2 行 | `check_induction_chain.sage` | `def_finite_sum_of_real_numbers` どおり左から足した和で、隣り合う行が等しい（`n_2 = 1,…,6`） | **PASS** | 厳密等号（12 段） |
| `n_1 → n_1+1` の 4 行 | 同上 | `n_1 = 1,…,6`・`n_2 = 1,…,6` で帰納法の仮定を確かめ、隣り合う行が等しい | **PASS** | 厳密等号（144 段。`n_1 = 1` の行と合わせて 156 段） |
| 主張そのもの | 同上 | Sage の `sum`（独立な経路）と比べる。否定コントロールとして、`c_{n_1+1,n_2}` を落とした右辺とは一致しないことも確かめる | **PASS** | `n_1 = 2,…,7`・`n_2 = 1,…,6` で厳密等号 |

## 計算の帰属と範囲

`c_{k,l}` を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
スクリプトの変数 `p`・`q`・`a(k, l)` は本文の `n_1`・`n_2`・`c_{k,l}` に当たる。浮動小数点と `RR` / `CC` への脱出はない。一般の `n_1, n_2` は人手証明の帰納法が担う。

鎖の項は多項式環の元なので、和の括弧の付け方の違いは Sage の正規形で吸収される。
この検査が確かめるのは、各行に書かれた式（添字の範囲・外側と内側の和の順・項の並び）が前の行と同じ値を持つことである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_double_sum_of_real_numbers_interchange
```

実行ログは `sagemath/check/finite_double_sum_of_real_numbers_interchange/logs/` に保存する（2026-11-06）。
