# SageMath Check: real_sum_of_two_equal_terms_is_twice

## 対象

**対象ラベル**: `real_sum_of_two_equal_terms_is_twice` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_sum_of_two_equal_terms_is_twice`（`ℝ` で `a + a = 2·a`）
- 範囲: 主張と、証明の 3 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 `a + a = 1·a + 1·a`（乗法の単位元 `1·x = x`（`x → a`）を右辺から左辺へ 2 か所に同時適用） | `check_proof_lines.sage` | `a` を多項式環 `QQ[a]` の不定元に置き、恒等的に等しい | **PASS** | 厳密 |
| 2 行目 `= (1 + 1)·a`（分配則 `(x+y)t = xt+yt`（`x → 1, y → 1, t → a`）を右辺から左辺へ） | 同上 | 隣り合う行が恒等的に等しい | **PASS** | 厳密 |
| 3 行目 `= 2·a`（`def_real_two` の `2 := 1 + 1` を右辺から左辺へ） | 同上 | 隣り合う行が恒等的に等しく、`1 + 1 = 2`（QQ） | **PASS** | 厳密 |
| 鎖の両端 | 同上 | `a ∈ {0, 1, −3, 7/5}` で両端がともに `2a` | **PASS** | 厳密 |
| 否定コントロール | 同上 | 2 行目の `1 + 1` を `1` にすると、3 行目の `2` を `3` にすると等しくない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: `QQ` と多項式環 `QQ[a]` だけで計算した。浮動小数点は使わない。
- 範囲外: `QQ` 係数の多項式としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_sum_of_two_equal_terms_is_twice
```

実行ログは `logs/` に保存する（2026-11-19、SageMath 10.9）。
