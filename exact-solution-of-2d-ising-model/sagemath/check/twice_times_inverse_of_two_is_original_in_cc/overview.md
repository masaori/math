# SageMath Check: twice_times_inverse_of_two_is_original_in_cc

## 対象

**対象ラベル**: `twice_times_inverse_of_two_is_original_in_cc`

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_claim_twice_times_inverse_of_two_is_original_in_cc`（`(2_C z) 2_C^{-1} = z`）
- 範囲: 主張と、証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の四行 | `check_chain.sage` | 主張の前置き `2_C = (2,0) ≠ (0,0) = 0_C` と、`z` を不定元にした `QQ(i)` 上の有理関数体で鎖の五つの項を各行に書かれた式どおりに組み、隣り合う項が等しい。`2_C^{-1}` は `2_C 2_C^{-1} = 1_C` を満たす `QQ` の `1/2` を置き、その等式も確かめる。具体的な 5 つの値でも当てはめる。否定の対照: `2_C^{-1}` の代わりに `2_C` を掛けると `z` に戻らない | **PASS** | 有理関数の厳密等号 |

## 計算の帰属と範囲

係数はすべて `QQ(i)` の元である。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh twice_times_inverse_of_two_is_original_in_cc
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する（2026-11-13）。
