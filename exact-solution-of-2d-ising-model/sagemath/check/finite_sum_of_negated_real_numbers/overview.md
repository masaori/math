# SageMath Check: finite_sum_of_negated_real_numbers

## 対象

**対象ラベル**: `finite_sum_of_negated_real_numbers` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_finite_sum_of_negated_real_numbers`（実数の符号反転の有限和は有限和の符号反転）
- 範囲: 主張 `Σ_{j=1}^{m}(−x_j) = −Σ_{j=1}^{m} x_j` と、証明の帰納法の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 1` の 2 行 | `check_induction_chain.sage` | `def_finite_sum_of_real_numbers` どおり左から足した和で、隣り合う行が等しい | **PASS** | 厳密等号 |
| `m → m+1` の 4 行 | 同上 | `m = 1,…,8` で帰納法の仮定を確かめ、隣り合う行が等しい | **PASS** | 厳密等号（`m = 1` の 2 行と合わせて 34 段） |
| 主張そのもの | 同上 | Sage の `sum`（独立な経路）と比べる。否定コントロールとして、最後の項 `x_{m+1}` の符号を反転し忘れた右辺とは一致しないことも確かめる | **PASS** | `m = 2,…,9` で厳密等号、否定コントロール 8 件 |

## 計算の帰属と範囲

`x_j` を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の `m` は人手証明の帰納法が担う。

鎖の項は多項式環の元なので、「ℝ で `(−a) + (−b) = −(a + b)`」の行は Sage の正規形で吸収される。
この検査が確かめるのは、各行に書かれた式（添字・括弧・項の並び）が前の行と同じ値を持つことである。添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_negated_real_numbers
```

実行ログは `sagemath/check/finite_sum_of_negated_real_numbers/logs/` に保存する（2026-11-04）。
