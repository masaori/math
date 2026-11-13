# SageMath Check: i_times_i_is_minus_one_in_cc

## 対象

**対象ラベル**: `i_times_i_is_minus_one_in_cc`

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_claim_i_times_i_is_minus_one_in_cc`（`i i = -1_C`）
- 範囲: 主張と、証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の四行 | `check_chain.sage` | `ℂ` を実数の対、積を `definition_of_cc` の式、`i := (0,1)`（`def_imaginary_unit`）として、鎖の五つの項を各行に書かれた式どおりに組み、隣り合う項が等しい。独立な経路として `QQ(i)` の積でも確かめる。否定の対照: 積の第 1 成分を `xu + yv` と書き違えると `-1_C` にならない | **PASS** | 対の成分の厳密等号 |

## 計算の帰属と範囲

成分はすべて `QQ` の元である（`-1, 0, 1` だけが現れる）。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh i_times_i_is_minus_one_in_cc
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する（2026-11-13）。
