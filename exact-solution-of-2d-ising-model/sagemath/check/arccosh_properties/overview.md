# SageMath Check: arccosh_properties

## 対象

**対象ラベル**: `arccosh_properties` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `transfer_matrix_000h3_claim_arccosh_properties`（逆双曲線余弦は非負側の双曲線余弦の逆。
  (1) `arccosh(y) ≥ 0`、(2) `cosh(arccosh(y)) = y`、(3) `t ≥ 0`・`cosh t = y` なら `t = arccosh(y)`、(4) `arccosh(1) = 0`）
- 範囲: 準備の三行と `log 1 = 0` の鎖、(1)〜(4) の証明の全行、主張そのもの

## 証明の行との対応

記号: `r := √(y^2-1)`、`u := arccosh(y)`。exact は `check_lines_exact.sage`、ball は `check_statement_with_balls.sage`。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `r ≥ 0 ∧ r^2 = y^2-1`、`y + r ≥ 1` | exact | 7 点の `y ∈ AA`（`1`、`1+10^{-6}`、`√2+1`、`10^6` など）で、`y^2-1 ≥ 0`、AA の非負の根が `r^2 = y^2-1` を満たし、`z^2 = y^2-1` の実根のうち非負なのがそれだけであること、`y + r ≥ 1`（`y > 1` なら `> 1`） | **PASS** | 厳密 |
| 準備 `log 1 = log(exp(0)) = 0` | exact・ball | 厳密な根拠は、本文の部分和 `S_N([0])` が `N = 0..24` で `[1]`（`exp(0) = 1`）であることと、逆写像の定義 `log(exp x) = x`。ボールでは `exp(0)` が半径 0 で 1 であることと、`log 1` の囲み（`[-2^{-130}, 2^{-130}]` 程度）が 0 を含むことだけを見る | **PASS** | 厳密・囲み |
| (1) `y + r > 1` の場合の `arccosh(y) = log(y+r) > log 1 = 0` | ball | `y > 1` の 6 点で `log(y+r)` の囲みが 0 より大きい | **PASS** | 全点で成り立つ |
| (1) `y + r = 1` の場合の `arccosh(y) = log(y+r) = log 1 = 0` | exact・ball | `y = 1` で `y + r = 1` を AA で厳密に。`log 1 = 0` は準備の厳密な根拠に依る（囲みは 0 を含むことだけを見る。負の値も含むので `≥ 0` の判定には使わない） | **PASS** | 厳密 |
| (2) `exp(u) = exp(log(y+r)) = y + r` | ball | `u` の囲みを本文の exp で写した像が `y + r` と重なる | **PASS** | 全点で成り立つ |
| (2) `y^2 - r^2 = y^2 - (y^2-1) = 1` | exact | 各行の差が、その行の (∵) の関係式（`r^2 = y^2-1`）だけのイデアルに入る（関係式を使う行は、関係式なしでは差が 0 でない） | **PASS** | 厳密 |
| (2) `exp(-u)` の八行の鎖 | exact | `exp(u), exp(-u), exp(-u+u), exp(0)` を独立な不定元に置き、各行がその行の関係式だけのイデアルで成り立つ。ただし指数法則・`-u+u = 0`・`exp(0) = 1` の三行は、その行の等式自身を関係式として渡すので、イデアルの確かめは「両辺に `y - r` を掛けた形」までしか示さない。三つの等式の中身は次の三つで別々に確かめる: 積の法則 `exp(a)exp(b) = exp(a+b)` を `QQ[a,b]` の形式冪級数（全次数 14 以下）で確かめて `a = -u, b = u` を代入（対照: `exp(a-b)` とは一致しない）、`-u+u = 0` を `QQ[u]` で、`exp(0) = 1` を部分和 `S_N([0]) = [1]`（`N = 0..24`）で | **PASS** | 厳密 |
| (2) `exp(-u) = y - r` の結論 | ball | `exp(-u)` の囲みが `y - r` と重なる | **PASS** | 全点で成り立つ |
| (2) `cosh(arccosh y)` の六行の鎖 | exact | 1 行目 `cosh(arccosh y) = cosh(u)` は `u` の定め方そのもので計算を含まないので検算しない。2 行目（`def_cosh_sinh` の適用）は定義の関数と本文の式の書き写しの一致で、自明に通る。代入の 3・4 行目を別々の関係式（`exp(u) = y+r`、`exp(-u) = y-r`）だけのイデアルで、5・6 行目を多項式の等号で | **PASS** | 厳密 |
| (3) `t > 0` なら `sinh t > 0` | ball | 6 点の `t ∈ QQ_{>0}` で `sinh t` のボールが正 | **PASS** | 全点で成り立つ |
| (3) `sinh 0 = (exp(0)-exp(-0))/2 = … = 0` | exact | `-0 = 0`、部分和の `exp(0) = 1`、`(1-1)/2 = 0` | **PASS** | 厳密 |
| (3) `(sinh t)^2 = (cosh t)^2 - 1 = y^2 - 1` | exact | `cosh t, sinh t` を不定元に置き、`cosh^2 - sinh^2 = 1`、`cosh t = y` だけのイデアルで | **PASS** | 厳密 |
| (3) `sinh t = √(y^2-1) = r` | ball | `y := cosh t` のボールで、`sinh t` と `√(y^2-1)` が重なる | **PASS** | 全点で成り立つ |
| (3) `t = log(exp t) = log(cosh t + sinh t) = log(y + sinh t) = log(y + r) = arccosh(y)` | exact・ball | `exp(t) = cosh t + sinh t`（`cosh_sinh_basic_properties` (1)）は `exp(t)`・`exp(-t)` を不定元に置くと定義の展開だけで成り立つ（exp の性質を使わない）ことを、関係式なしで。代入の二行を別々の関係式で。`log(exp t)` と `arccosh(cosh t)` の囲みが `t` を含むことをボールで | **PASS** | 厳密・囲み |
| (4) `arccosh(1) = log(1+√(1^2-1)) = log(1+√0) = log(1+0) = log 1 = 0` | exact・ball | `1^2-1 = 0`、AA で `√0 = 0`（`0 ≥ 0`、`0^2 = 0`）、`1+0 = 1`。`arccosh(1)` の囲みが 0 を含む（対照: `y = 1+10^{-6}` では含まない） | **PASS** | 厳密・囲み |
| 主張 (3) の仮定 `t ≥ 0` が要ること（対照） | ball | `t = -1/3, -2` では `arccosh(cosh t)` の囲みが `-t` を含み `t` を含まない | **PASS** | 期待どおり不成立 |

## 計算の帰属と範囲

- **厳密**: 係数は `QQ`、`y` の点は `AA`（実代数的数）。exp・cosh・sinh の値を独立な不定元に置いた行は、
  その行が引く関係式以外の性質を使っていないことまで確かめている。exp の積の法則の行は、
  本文の exp が部分和の極限なので、形式冪級数として全次数 14 以下の部分で比べた。
- **`ℝ` への脱出（`RealBallField(512)`）**: log・exp の値を含む行と主張だけ。値が `QQ`・`AA` に収まらないためである。
  exp は本文の部分和に尾の評価を半径として足したボール、log は有理数の端点を本文の exp のボールで確かめて挟んだ区間
  （共通の準備 `sagemath/_shared/positive_coupling_and_real_log.sage` の `real_log_enclosure`）。`y` がボールのときの
  `√(y^2-1)` は Arb の sqrt（非負の根を含む区間）を使った。許容誤差は置かず、ボールの包含・重なり・大小で判定する。
  `cosh(arccosh y)` のボールの半径が相対 `2^{-100}` 未満であることも確かめ、重なりの判定が値を十分に絞っていることを示す。

範囲外のもの:

- 選んだ以外の点と、14 次を超える項。
- `real_log_strictly_increasing`・`cosh_sinh_basic_properties` などの引かれる主張そのもの（それぞれの検算が持つ）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh arccosh_properties
```

実行ログは `logs/` に保存する。
