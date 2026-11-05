# SageMath Check: epsilon_commutes_with_W

## 対象

**対象ラベル**: `epsilon_commutes_with_W`

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_010b_claim_epsilon_commutes_with_W`（`εW = Wε` と、`W` が `F^{(+)}` を保つこと）
- 範囲: 証明の準備（`εD = Dε`・`ε(cD) = (cD)ε`・`εV_2 = V_2ε` と `εS` の鎖 3 行）、本体の鎖 11 行、`F^{(+)}` の鎖 4 行と結論 `Wf ∈ F^{(+)}`。
- 記号は証明のとおり `S := V_1^{1/2} = exp(cD)`（検算のコードでは変数名 `B`）、`c := ((1/2)K_1)_ℂ`、`D := Σ_m σ_m^zσ_{m+1}^z`、`W := (SV_2)S`。

## 証明の行との対応

| 証明の行 | 検査内容 | ステータス |
|---|---|---|
| 準備: `εD = Dε`（`epsilon_commutes_with_bond_sum`） | `D` を `def_kronecker` の成分の式の経路と Sage の積・和の経路の二通りで作って一致を見てから、`εD`・`Dε` を `mat_mult` の成分の式で組んで比べる | **PASS** |
| 準備: `ε(cD) = (cD)ε`（`commuting_with_scalar_multiple`） | `c` を `QQ(i)[c]` の不定元に置き、`cD` を `def_matrix_scalar_multiple` の成分の式で組んで比べる | **PASS** |
| 準備: `εV_2 = V_2ε`（`epsilon_commutes_with_V2`） | `V_2` を `def_transfer_matrix` の成分（行・列番号から `μ` を 2 進展開で復元）で作り比べる | **PASS** |
| 準備: `εS = ε exp(cD) = exp(cD)ε = Sε` の 3 行 | `S = exp(cD)` を `D` の固有値の射影から作り（下の「計算の帰属」）、`SS = V_1`（`V_1` は成分から作る）で平方根であることを確かめたうえで、各行を比べる | **PASS** |
| 本体の鎖 11 行（`def_symmetrized_transfer_matrix`・`mat_mult_associative`・`εS = Sε`・`εV_2 = V_2ε`） | 各行の行列を、その行の括弧の形どおりに `mat_mult` の成分の式で組み、隣の行と比べる。`W` は Sage の積 `S*V_2*S` とも比べる | **PASS** |
| `F^{(+)}` の鎖 4 行（結論 `ε(Wf) = Wf` は 4 行の推移で従う） | `F^{(+)} = ker(ε − I)` の基底（次元 `2^{M_col−1}` も見る）と、`QQ(i)` の係数の一次結合 2 つの `f` を `n` 行 1 列の行列にして、`εf = f` と各行を比べる | **PASS** |

`M_col = 1..5`。等号 315 件、否定コントロール 24 件。

## 計算の帰属と範囲

- `ε`・`σ_m^z`・`D` は `QQ(i)` の行列。`Y := exp((1/2)K_1)`、`X2 := exp(K_2)` を Laurent 多項式環 `QQ(i)[Y^{±1}, X2^{±1}]` の不定元に置く。
  `D` は整数の固有値 `λ` をもつ対角化可能な行列なので（`exp_by_spectral_projectors` が `Σ P_λ = I`・`DP_λ = λP_λ` を確かめる）、
  `S = exp(cD) := Σ_λ Y^λ P_λ` と作る（実数の exp の指数法則 `exp(cλ) = exp((1/2)K_1)^λ` を、肩が整数倍のときにだけ使う）。
  `V_2` の成分は `exp(K_2 Σ_m μ(m)μ'(m)) = X2^{Σ μμ'}`。
- **ℝ への脱出は、実数の exp の値を不定元に置く一点だけ**で、以後の等号は全て厳密計算である。浮動小数点は使わない。
  `K_1, K_2` の値に依らない形で確かめているので、具体の結合定数は別に置かない。
- 範囲外: `M_col ≥ 6`。`commuting_matrix_commutes_with_exp` の極限の推論そのもの（ここでは exp を固有値の射影で与える）。

## 構成上かならず成り立つ比較

- `εS` の鎖の 1 行目と 3 行目（`def_transfer_matrix_square_root` で `S` と `exp(cD)` を入れ替える行）と、本体の鎖の 1 行目・11 行目
  （`def_symmetrized_transfer_matrix` で `W` と `(SV_2)S` を入れ替える行）は、同じ行列を代入するので必ず成り立つ。写し間違いの検出だけに効く。
  中身の検査は、`εS` の鎖の 2 行目と、本体の鎖の 4・6・9 行目（可換性を当てる行）にある。
- 本体の鎖の 2・3・5・7・8・10 行目と `F^{(+)}` の鎖の 1・3 行目（`mat_mult_associative` を当てる行）は、どの行列でも成り立つので、
  括弧の写し間違いの検出だけに効く。否定コントロールを置かないのはこのためである。

## 否定コントロール

- `ε` の代わりに `σ_1^z`（`S` と可換だが `V_2` と可換でない）を置くと、本体の鎖の 6 行目（`εV_2 = V_2ε` を当てる行）と主張が崩れる。
- `ε` と可換でない対角行列 `S' := diag(Y^0, …, Y^{n−1})` を `S` の代わりに置くと、本体の鎖の 4 行目（`εS = Sε` を当てる行）が崩れる。
- `εf = −f` の `f` では `ε(Wf) ≠ Wf` になる（`F^{(+)}` の鎖の最後の行 `εf = f` が要る）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_commutes_with_W
```

実行ログは `logs/` に保存する。
