# SageMath Check: complex_one_is_multiplicative_identity

## 対象

**対象ラベル**: `complex_one_is_multiplicative_identity` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_complex_one_is_multiplicative_identity`（1_ℂ は ℂ の積の単位元）
- 範囲: 主張 `z·1_ℂ = z`・`1_ℂ·z = z`（`z ∈ ℂ`。`0_ℂ` を含む）と、証明の二本の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `z·1_ℂ = z` の鎖の八行 | `check_component_chain.sage` | 鎖の九つの項を各行に書かれた式どおりに組み（`1_ℂ = (1, 0)`、積は `definition_of_cc` の式どおり）、隣り合う項が等しい | **PASS** | 八行すべて厳密等号 |
| `1_ℂ·z = z` の鎖の二行 | 同上 | `1_ℂ·z = z·1_ℂ = z` | **PASS** | 厳密等号 |
| 主張そのもの | 同上 | `z = (0, 0)` の代入（鎖は不定元で成り立つので、`0_ℂ` を含む全ての元で成り立つ）と、対照として `(1, 1)` は単位元でないこと | **PASS** | 厳密等号・対照は不一致 |

## 計算の帰属と範囲

`a, b` を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。
多項式環は可換なので、行に書いた形（`x·1 = x` か `1·x = x` か）の左右は検算では区別できない。行に書いた形と代入はレビューの目視で確かめた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_one_is_multiplicative_identity
```

実行ログは `sagemath/check/complex_one_is_multiplicative_identity/logs/` に保存する（2026-11-17）。
