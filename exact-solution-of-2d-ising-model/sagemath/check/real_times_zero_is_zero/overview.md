# SageMath Check: real_times_zero_is_zero

## 対象

**対象ラベル**: `real_times_zero_is_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_times_zero_is_zero`（`x ∈ ℝ` について `x·0 = 0`）
- 範囲: 主張と、証明の 6 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 6 行の鎖（`x0 = x0 + 0 = x0 + (x0 + (−(x0))) = (x0 + x0) + (−(x0)) = x(0 + 0) + (−(x0)) = x0 + (−(x0)) = 0`） | `check_proof_lines.sage` | 掛けられる側の `0` を `QQ[o, x]` の不定元 `o` に置き（`x·0 = 0` を前提にしないため）、`0 + 0 = 0` を当てる段以外の 5 段が恒等的に等しいことと、その段が 4 行目の `(o + o)` を `o` に置き換えたものであることを確かめ、`o = 0` で全ての行が `0` になることを確かめる | **PASS** | 厳密（等号 6 個） |
| 否定コントロール | 同上 | `o` が一般の値なら `0 + 0 = 0` の段は成り立たない。分配則の段で `(o + o)` を `(o + 1)` に取り違えると 3 行目と一致しない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 多項式環 `QQ[o, x]` だけで計算した。浮動小数点は使わない。
- 範囲外: `QQ[o, x]` での一致は `ℚ` 係数の多項式としての一致であり、ℝ の全ての点での証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_times_zero_is_zero
```

実行ログは `logs/` に保存する（2026-11-14、SageMath 10.9）。
