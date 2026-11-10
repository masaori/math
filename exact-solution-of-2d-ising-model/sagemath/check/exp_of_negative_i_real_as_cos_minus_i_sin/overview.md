# SageMath Check: exp_of_negative_i_real_as_cos_minus_i_sin

## 対象

**対象ラベル**: `exp_of_negative_i_real_as_cos_minus_i_sin`

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_claim_exp_of_negative_i_real_as_cos_minus_i_sin`（θ ∈ ℝ で `exp(-iθ_C) = (cos θ)_C - i(sin θ)_C`。
  `euler_formula_cos_sin` の主張から導く）
- 範囲: 証明の準備の三つの鎖（`1_C + 1_C = 2_C` の 4 等号、`(a+b) - (a-b) = 2_C b` の 17 等号、`i(2_C i)^{-1} = 2_C^{-1}` の 6 等号）、主鎖の 22 等号と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の第一の鎖 `1_C + 1_C = (1)_C + (1)_C = (1+1)_C = (2)_C = 2_C`、第二の鎖 `(a+b) - (a-b) = … = 2_C b` の各行 | `check_prep_chains.sage` | ℂ を `QQ[a0,a1,b0,b1]` の対で持ち、和・積・包含・`-z := (-1_C)z`・`z - w := z + (-w)` を本文の定義の式で書いた関数で、各行をその行の式の形のまま組み、隣り合う行が恒等的に等しいことを見る。対照: 7 行目の `(-1_C)(-1_C)` を `-1_C`、13 行目の `a + (-a)` を `a` に替えると等号が切れる | **PASS** | 成り立つ |
| 準備の第三の鎖 `i(2_C i)^{-1} = 1_C(i(2_C i)^{-1}) = … = 2_C^{-1}` の各行と、前置きの `2_C, i, 2_C i ≠ 0_C` | `check_prep_chains.sage` | 同じ対の表示で、逆元を `multiplicative_group_of_cc` の証明の逆元の式 `(x,y)^{-1} := (x/(x^2+y^2), -y/(x^2+y^2))` で作り、各行を組んで隣り合う行が等しいことを見る。対照: 2 行目の `2_C^{-1}2_C` を `2_C` に替えると等号が切れる | **PASS** | 成り立つ |
| 主鎖の第 1〜14・16〜21 等号（積の単位元・逆元・結合律・可換律、`def_complex_quotient`、`def_complex_difference`、右からの分配律、`multiply_by_minus_one`、準備の第二・第三の鎖の参照） | `check_chain_lines.sage` | a, b, c, s を `QQ(i)` 上の独立な不定元にした有理関数体で、商を `z w^{-1}` として各行をその行の式のまま組み、恒等的に等しいことを見る。対照: 第 2 等号の `2^{-1}2` を `2`、第 17 等号の `i(2i)^{-1}` を `i` に替えると等号が切れる | **PASS** | 成り立つ |
| 主鎖の第 15 等号（`(a+b)/2 - (a-b)/2 = c - (a-b)/2`）、第 22 等号（`c - i(a-b)/(2i) = c - is`）。`euler_formula_cos_sin` の第 1・第 2 の等式を引く行 | `check_chain_lines.sage` | 同じ体で、差がちょうど `(a+b)/2 - c`・`i(s - (a-b)/(2i))` であり、その等式を代入すると 0、代入しなければ 0 でないことを見る（その行だけが根拠の等式を使っていることの確認） | **PASS** | 成り立つ |
| 主鎖の全行（具体の点） | `check_chain_lines.sage` | θ = 2πq（分母 1..12、\|q\| ≤ 2 の 324 点）で a, b を 1 の冪根、c, s を AA の cos・sin として、23 項を `QQbar` で厳密に比べる | **PASS** | 成り立つ |
| 主張 | `check_claim_ball.sage` | 本文の exp（部分和と尾の上界のボール）の `exp(-iθ_C)` と、Arb の cos θ - i sin θ が重なる（θ = 2πq の 324 点と θ = r/7 の 141 点）。対照: -i を +i に替えると 380 点で交わらない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 準備の鎖は `QQ[a0,a1,b0,b1]` の対（第三の鎖は成分が `QQ`）、主鎖は `QQ(i)` 上の有理関数体と `QQbar`。
- **ℝ への脱出**: `check_claim_ball.sage` だけ。π と本文の exp の値（級数の極限）、Arb の cos・sin を 512 bit のボールで囲む。
  部分和の項数と尾の評価は `sagemath/_shared/half_integer_phase_exact.sage` の `body_exp_i_ball`。重なりは等号の必要条件であって証明ではない。
- 具体の点で c, s を 1 の冪根の実部・虚部から作るのは Euler の公式を前提にした表し方なので、そこでの `euler_formula_cos_sin` の成立は表し方の整合の確認にとどまる。
  この主張が `euler_formula_cos_sin` の等式だけから従うことは、不定元の検査（第 15・第 22 等号の差）が確かめている。
- 全実数上の cos・sin は本文では未整備（`euler_formula_cos_sin` の前置き）で、主張はそれを前提とする。検算では通常の cos・sin の値を使う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh exp_of_negative_i_real_as_cos_minus_i_sin
```

実行ログは `logs/` に保存する。
