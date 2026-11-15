# SageMath Check: real_negation_of_zero_is_zero

## 対象

**対象ラベル**: `real_negation_of_zero_is_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_negation_of_zero_is_zero`（ℝ で `-0 = 0`）
- 範囲: 主張と、証明の 3 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 3 行の鎖（`-0 = -0 + 0 = 0 + (-0) = 0`） | `check_proof_lines.sage` | `-0` を `QQ[n]` の不定元 `n` に置き（`-0 = 0` を前提にしないため）、加法の単位元と可換則の 2 段が恒等的に等しいことと、最後の段が逆元の条件 `0 + n = 0` を課した商環 `QQ[n]/(0 + n)` で成り立つことを確かめる | **PASS** | 厳密（等号 3 個） |
| 否定コントロール | 同上 | 逆元の条件を課さなければ最後の段は成り立たない。条件を `1 + n = 0` に取り違えると `n` は `0` にならない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 多項式環 `QQ[n]` とその商環だけで計算した。浮動小数点は使わない。
- 範囲外: `QQ` 係数の多項式としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_negation_of_zero_is_zero
```

実行ログは `logs/` に保存する（2026-11-15、SageMath 10.9）。
