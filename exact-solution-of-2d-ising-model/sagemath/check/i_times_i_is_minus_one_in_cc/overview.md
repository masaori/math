# SageMath Check: i_times_i_is_minus_one_in_cc

## 対象

**対象ラベル**: `i_times_i_is_minus_one_in_cc`

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_claim_i_times_i_is_minus_one_in_cc`（`i i = -1_C`）
- 範囲: 主張と、証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の十行 | `check_chain.sage` | `ℂ` を実数の対、積を `definition_of_cc` の式、`i := (0,1)`（`def_imaginary_unit`）として、鎖の十一の項を各行に書かれた式どおりに組み、隣り合う項が等しい。3〜9 行目が使う等式（`0·x = 0`・`x·0 = 0`・`1·x = x`・`0 + 0 = 0`・`y − z = y + (−z)`・`0 + a = a`）を不定元の多項式環 `QQ[x, a, y, z]` でも確かめ、`y − z = y + (−z)` に `y → 0, z → 1` を当てた値も確かめる。独立な経路として `QQ(i)` の積でも確かめる。否定の対照: 積の第 1 成分を `xu + yv` と書き違えると `-1_C` にならない | **PASS** | 対の成分の厳密等号 |
| ℝ の単位元を引く 3 行（`set_and_algebra_notation`）: `1·1 = 1（1·x = x の x → 1）`、`0 + 0 = 0（x + 0 = x の x → 0）`、`0 + (−1) = −1（0 + x = x の x → −1）` | `check_unit_rows_cite_set_and_algebra_notation.sage` | 行に書いた形と代入で形の両辺を作り、前後の行が同じ文脈（対の成分）の穴にそれを入れたものと `QQ` で等しいことを確かめる。式を正規化するので、形の左右は区別できず、それはレビューの目視で確かめた。対照（`0 + 1 ≠ 0`・`2·3 ≠ 3`） | **PASS** | 厳密（3 行） |

## 計算の帰属と範囲

成分はすべて `QQ` の元である（`-1, 0, 1` だけが現れる）。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh i_times_i_is_minus_one_in_cc
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する（2026-11-13。3 行目「ℝ の四則」を 7 行に割ったのに合わせて 2026-11-15 に鎖を更新）。
