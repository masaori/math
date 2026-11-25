# SageMath Check: real_inclusion_preserves_finite_sum

## 対象

**対象ラベル**: `real_inclusion_preserves_finite_sum` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_real_inclusion_preserves_finite_sum`（実数の有限和の包含は包含の有限和に等しい）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 0` の 3 行（ℂ の空の和の式・`0_ℂ := (0_ℝ)_ℂ`・ℝ の空の和の式を右辺から左辺へ） | `check_induction_chain.sage` | 空の和（`fsum_cc([])` は `0_ℂ`、`fsum_rr([])` は `0`）で、隣り合う行が等しい（定数どうしの比較なので、確かめるのは各行の写し間違いだけである） | **PASS** | 厳密等号 |
| `m = 1` の 2 行 | `check_induction_chain.sage` | `r_1` を不定元に置き、`def_finite_sum_of_complex_numbers` の和で組んだ値と比べる | **PASS** | `m + 1 = 2,…,9` で厳密等号 |
| `m → m+1` の 7 行（`def_finite_sum`・帰納法の仮定・`inclusion_rr_to_cc`・`definition_of_cc` の和・ℝ の有限和・`0 + 0 = 0`・`inclusion_rr_to_cc`） | 同上 | `r_1,…,r_9` を不定元に置き、`m + 1 = 2,…,9` で隣り合う行が等しい。帰納法の仮定も各 `m` で確かめた。左辺を `QQ(i)` 係数へ送った値を Sage の `sum` と比べた | **PASS** | 同上 |

## 計算の帰属と範囲

浮動小数点はない。ℂ は本文 `definition_of_cc` どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage`）、`r_j` を `QQ` 上の多項式環の不定元に置いて確かめた。不定元で成り立つ多項式の等号は、実数を代入しても成り立つ。

左辺を `QQ(i)` 係数へ送った値を Sage の `sum` と比べた。

## 確かめられない行と理由

一般の `m` は検算の範囲外で、人手証明の帰納法が担う。`(Σ^m r_j, 0) + (r_{m+1}, 0)` から `(Σ^m r_j + r_{m+1}, 0+0)` への行は `definition_of_cc` の和の定義そのもので、検算では同語反復である。

## 記録

2026-11-25: 主張を `m ∈ ℤ_{≥0}` へ広げ、証明に足した `m = 0` の 3 行の検査を足して再実行した（`fsum_cc`・`fsum_rr` は空の和の式を返す）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_inclusion_preserves_finite_sum
```

実行ログは `sagemath/check/real_inclusion_preserves_finite_sum/logs/` に保存する。
