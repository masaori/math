# SageMath Check: complex_multiplication_is_commutative

## 対象

**対象ラベル**: `complex_multiplication_is_commutative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_complex_multiplication_is_commutative`（ℂ の積の可換律）
- 範囲: 主張 `w·z = z·w`（`z, w ∈ ℂ`。`0_ℂ` を含む）と、証明の七行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の七行 | `check_component_chain.sage` | 鎖の八つの項を各行に書かれた式どおりに組み（積は `definition_of_cc` の式どおり `_prelude.sage` で組む）、隣り合う項が等しい | **PASS** | 七行すべて厳密等号 |
| 主張そのもの | 同上 | `z = (0, 0)` を代入しても両辺が一致する（主張が `ℂ^×` に限らないこと）。対照として、積の第 2 成分の符号を誤った式とは一致しないことを確かめる | **PASS** | 厳密等号・対照は不一致 |

## 計算の帰属と範囲

`a, b, c, d` を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。
多項式環は可換なので、ℝ の積・和の可換律の行で左右を取り違えても検算では区別できない。行に書いた形と代入はレビューの目視で確かめた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_multiplication_is_commutative
```

実行ログは `sagemath/check/complex_multiplication_is_commutative/logs/` に保存する（2026-11-17）。
