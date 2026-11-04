# SageMath Check: real_inclusion_preserves_sum

## 対象

**対象ラベル**: `real_inclusion_preserves_sum` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_real_inclusion_preserves_sum`（実数の和の包含は包含の和に等しい）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 4 行の鎖（`inclusion_rr_to_cc` を 2 か所・`definition_of_cc` の和・ℝ で `0 + 0 = 0`・`inclusion_rr_to_cc`） | `check_chain.sage` | `a, b` を不定元に置き、隣り合う行が等しい。左辺を `QQ(i)` 係数へ送った値を `a + b` と比べた。虚部を `1` にした否定コントロールが外れる | **PASS** | 4 個の等号を厳密に確かめた |

## 計算の帰属と範囲

浮動小数点はない。ℂ は本文 `definition_of_cc` どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage`）、`a, b` を `QQ` 上の多項式環の不定元に置いて確かめた。不定元で成り立つ多項式の等号は、実数を代入しても成り立つ。

## 確かめられない行と理由

1 行目と 2 行目、4 行目と 5 行目（`inclusion_rr_to_cc`）は `iota` が `(r, 0)` を組む作りから、2 行目と 3 行目は `definition_of_cc` の和の定義そのものから一致するので、検算では同語反復である。実質の比較は `QQ(i)` へ送った値との照合である。否定コントロール（`b` の虚部を `1` にする）は入力を変えるもので、鎖の行を壊すものではない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_inclusion_preserves_sum
```

実行ログは `sagemath/check/real_inclusion_preserves_sum/logs/` に保存する。
