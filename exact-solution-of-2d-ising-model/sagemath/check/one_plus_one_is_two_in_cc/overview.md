# SageMath Check: one_plus_one_is_two_in_cc

## 対象

**対象ラベル**: `one_plus_one_is_two_in_cc`

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_one_plus_one_is_two_in_cc`（`1_C + 1_C = 2_C`）
- 範囲: 主張と、証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の四行 | `check_chain.sage` | `ℂ` を実数の対、和を `definition_of_cc` の式として、鎖の五つの項を各行に書かれた式どおりに組み、隣り合う項が等しい。2 行目の根拠 `real_inclusion_preserves_sum` を不定元 `a, b` の対の和で確かめる。独立な経路として `QQ(i)` の和でも確かめる。否定の対照: `1_C + 1_C` は `1_C` でも `(2, 1)` でもない | **PASS** | 対の成分の厳密等号 |

## 計算の帰属と範囲

成分はすべて `QQ` の元（または `QQ[a, b]` の元）である。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh one_plus_one_is_two_in_cc
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する（2026-11-10）。
