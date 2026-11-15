# SageMath Check: real_minus_one_times_is_negation

## 対象

**対象ラベル**: `real_minus_one_times_is_negation` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_minus_one_times_is_negation`（`a ∈ ℝ` について `(−1)·a = −a`）
- 範囲: 主張と、証明の 10 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 10 行の鎖（`(−1)a = (−1)a + 0 = (−1)a + (a + (−a)) = ((−1)a + a) + (−a) = ((−1)a + 1·a) + (−a) = ((−1) + 1)a + (−a) = (1 + (−1))a + (−a) = 0·a + (−a) = 0 + (−a) = (−a) + 0 = −a`） | `check_proof_lines.sage` | `−1` を `QQ[m, a]` の不定元 `m` に置き（`(−1)a = −a` を前提にしないため）、加法の逆元（`z → 1`）を当てる段以外の 9 段が恒等的に等しいことと、その段が `m = −1` で `1 + m = 0` になることで成り立つことを確かめ、`m = −1` で全ての行が `−a` になることを確かめる | **PASS** | 厳密（等号 10 個） |
| 否定コントロール | 同上 | `m` が一般の値なら加法の逆元（`z → 1`）の段は成り立たない。分配則の段で `(m + 1)` を `(m − 1)` に取り違えると 4 行目と一致しない。終点の符号を取り違えた `a` は左辺と一致しない | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: 多項式環 `QQ[m, a]` だけで計算した。浮動小数点は使わない。
- 範囲外: `QQ[m, a]` での一致は `ℚ` 係数の多項式としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_minus_one_times_is_negation
```

実行ログは `logs/` に保存する（2026-11-15、SageMath 10.9）。
