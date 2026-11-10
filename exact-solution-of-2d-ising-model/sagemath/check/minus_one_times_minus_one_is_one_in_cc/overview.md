# SageMath Check: minus_one_times_minus_one_is_one_in_cc

## 対象

**対象ラベル**: `minus_one_times_minus_one_is_one_in_cc`

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_minus_one_times_minus_one_is_one_in_cc`（`(-1_C)(-1_C) = 1_C`）
- 範囲: 主張と、証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の四行 | `check_chain.sage` | `ℂ` を実数の対、積を `definition_of_cc` の式として、鎖の五つの項を各行に書かれた式どおりに組み、隣り合う項が等しい。1 行目の読みの対照として `(-1)_C + 1_C = 0_C`（`definition_of_cc` の和）を確かめる。独立な経路として `QQ(i)` の積でも確かめる。否定の対照: `(-1_C)1_C` は `1_C` ではない | **PASS** | 対の成分の厳密等号 |

## 計算の帰属と範囲

成分はすべて `QQ` の元である（`-1, 0, 1` だけが現れる）。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh minus_one_times_minus_one_is_one_in_cc
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する（2026-11-10）。
